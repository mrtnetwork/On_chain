import 'dart:async';
import 'package:on_chain/ada/src/provider/exception/blockfrost_api_error.dart';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/address.dart';

import 'package:on_chain/ada/src/models/transaction/input/models/transaction_input.dart';
import 'package:on_chain/ada/src/models/transaction/input/models/transaction_unspent_output.dart';
import 'package:on_chain/ada/src/models/transaction/transaction/models/transaction.dart';
import 'package:on_chain/ada/src/provider/blockfrost/blockfrost.dart';
import 'package:on_chain/exception/onchain_error.dart';

import 'models.dart';

/// Design follows the shared quick-client convention:
/// consumers (swap, wallet) depend on this mixin instead of raw
/// `BlockFrostProvider` request classes or their own client copies.
/// Cardano has a single REST backend, so there is exactly one [provider].
///
/// Error contract (applies to every method below): only a
/// `resourceDoesNotExist` (404) response maps to the documented negative
/// value (`[]` / `null` / [AdaTxStatus.unknown]); any other failure
/// (rate limits, transport, node) **throws** and must never be mistaken
/// for "not found".
///
/// Wallet parity notes (base-native adaptations):
/// - UTXO reads yield raw [ADAAccountUTXOResponse] pages instead of the
///   wallet `CardanoAccountUtxo` wrappers; resolvers partition them.
/// - `getTransactionStatus` takes the hash directly (the wallet only used
///   `transaction.txId`) and returns [AdaTxStatus]; Blockfrost only serves
///   confirmed transactions, so there is no failed state.
/// - Endpoint validation (`validateNetworkMagicNumber`, `verifyService`)
///   stays in the consumers (service wiring, not provider calls).
mixin AdaQuickClientApi {
  /// Single Blockfrost provider serving every call.
  IProvider<IServiceProvider, BlockFrostRequestDetails> get provider;

  /// Maximum UTXOs per page.
  static const int maxUtxoResponse = 100;

  /// True when [e] is a "resource not found" node error (unknown address /
  /// transaction: HTTP 404 or a not-found message), never a transport
  /// failure.
  static bool isBlockfrostNotFound(Object e) {
    if (e is RPCError) {
      if (e.statusCode == BlockfrostStatusCode.resourceDoesNotExist) {
        return true;
      }
      return e.message.toLowerCase().contains('not found');
    }
    return false;
  }

  /// UTXOs of [address], one page ([count] rows) per event following page
  /// numbers. Unknown addresses end the stream silently; any other failure
  /// throws.
  Stream<List<ADAAccountUTXOResponse>> watchAccountUtxos(
    ADAAddress address, {
    int count = maxUtxoResponse,
  }) async* {
    int page = 1;
    while (true) {
      late final List<ADAAccountUTXOResponse> result;
      try {
        result = await provider.request(
          BlockfrostRequestAddressUTXOs(
            address,
            filter: BlockFrostRequestFilterParams(count: count, page: page),
          ),
        );
      } catch (e) {
        if (isBlockfrostNotFound(e)) return;
        rethrow;
      }
      if (result.isNotEmpty) yield result;
      page++;
      if (result.length < count) break;
    }
  }

  /// Native (lovelace) balance of [address], summed over its UTXOs.
  /// Unknown addresses hold zero; any other failure throws.
  Future<BigInt> getBalance(ADAAddress address) async {
    BigInt balance = BigInt.zero;
    await for (final page in watchAccountUtxos(address)) {
      for (final utxo in page) {
        balance += utxo.sumOflovelace;
      }
    }
    return balance;
  }

  /// Broadcasts [transactionCborBytes], returning the transaction id.
  Future<String> submitTransaction(List<int> transactionCborBytes) async {
    return provider.request(
      BlockfrostRequestSubmitTransaction(
        transactionCborBytes: transactionCborBytes,
      ),
    );
  }

  /// Polls until [transactionId] is served (confirmed) or [timeout]
  /// elapses. 404s keep polling; any other failure throws immediately.
  Future<void> trackTransaction({
    required String transactionId,
    Duration timeout = const Duration(minutes: 10),
    Duration periodicTimeOut = const Duration(seconds: 10),
  }) async {
    Timer? timer;
    try {
      final Completer<void> completer = Completer<void>();
      timer = Timer.periodic(periodicTimeOut, (_) async {
        if (completer.isCompleted) return;
        try {
          await provider.request(
            BlockfrostRequestSpecificTransaction(transactionId),
          );
          completer.complete();
        } catch (e) {
          if (!isBlockfrostNotFound(e)) {
            if (!completer.isCompleted) completer.completeError(e);
          }
        }
      });
      await completer.future.timeout(timeout);
    } on TimeoutException {
      throw const BuError(
        OnChainErrorType.adaPlugin,
        'Transaction confirmation failed within the allotted timeout.',
      );
    } finally {
      timer?.cancel();
      timer = null;
    }
  }

  /// Status of a transaction by id: confirmed when served, unknown on 404.
  /// Any other failure throws.
  Future<AdaTxStatus> getTransactionStatus(String transactionId) async {
    try {
      await provider.request(
        BlockfrostRequestSpecificTransaction(transactionId),
      );
      return AdaTxStatus.block;
    } catch (e) {
      if (isBlockfrostNotFound(e)) return AdaTxStatus.unknown;
      rethrow;
    }
  }

  /// Transaction with [txId], or null only when unknown (404). Any other
  /// failure throws.
  Future<ADATransaction?> getTransaction(String txId) async {
    try {
      final cbor = await provider.request(
        BlockfrostRequestTransactionCbor(txId),
      );
      return ADATransaction.deserialize(CborObject.fromCborHex(cbor).cast());
    } catch (e) {
      if (isBlockfrostNotFound(e)) return null;
      rethrow;
    }
  }

  /// Resolves [inputs] to their spent outputs by fetching each distinct
  /// transaction once (CBOR) in parallel. Unknown transactions throw;
  /// dangling indexes are skipped.
  Future<List<TransactionUnspentOutput>> getUtxosOutputs(
    List<TransactionInput> inputs,
  ) async {
    final txIds = inputs.map((e) => e.txIdHex).toSet();
    final List<TransactionUnspentOutput> outputs = [];
    await Future.wait(
      txIds.map((e) async {
        final tx = await getTransaction(e);
        if (tx == null) {
          throw BuError(
            DefaultErrorType.invalidArgument,
            'Failed to fetch transaction by id.',
            details: {'transaction_id': e},
          );
        }
        final input = inputs.where((i) => StringUtils.hexEqual(i.txIdHex, e));
        for (final e in input) {
          final rOutput = tx.body.outputs?.outputs.elementAtOrNull(e.index);
          if (rOutput != null) {
            outputs.add(TransactionUnspentOutput(output: rOutput, input: e));
          }
        }
      }),
    );
    return outputs;
  }

  /// Latest epoch protocol parameters (fee calc input).
  Future<ADAEpochParametersResponse> latestEpochProtocolParameters() async {
    return provider.request(BlockfrostRequestLatestEpochProtocolParameters());
  }

  /// Latest block height, or null when the tip carries no parseable height.
  Future<BigInt?> getBlockHeight() async {
    final block = await provider.request(BlockfrostRequestLatestBlock());
    final height = block.height;
    if (height == null) return null;
    return BigInt.from(height);
  }
}
