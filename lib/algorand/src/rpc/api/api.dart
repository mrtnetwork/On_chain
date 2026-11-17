import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/methods/methods.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';
import 'package:on_chain/algorand/src/transaction/src/signatures.dart';
import 'package:on_chain/algorand/src/types/types.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// Unified transaction status for the Algorand cases; transport failures
/// throw instead of degrading to pending.
enum AlgoTxStatus {
  /// The pending info reports a confirmed round.
  block,

  /// The pending info reports a pool error.
  failed,

  /// Not confirmed yet.
  pending,
}

mixin AlgoQuickClientApi {
  IProvider<IServiceProvider, AlgoRequestDetails> get provider;

  /// True when [e] is a "resource not found" node error (unknown account /
  /// asset: HTTP 404 or a not-found message), never a transport failure.
  static bool isAlgoNotFound(Object e) {
    if (e is RPCError) {
      if (e.statusCode == 404) return true;
      return e.message.toLowerCase().contains('not found');
    }
    return false;
  }

  /// Native balance of [address]; zero only when the account does not exist
  /// on-chain. Transport failures rethrow.
  Future<BigInt> getAccountBalance(AlgoAddress address) async {
    try {
      final account = await getAccount(address);
      return account.amount;
    } catch (e) {
      if (isAlgoNotFound(e)) return BigInt.zero;
      rethrow;
    }
  }

  /// Status of a transaction by id: failed on pool errors, block once a
  /// round confirms, pending otherwise.
  Future<AlgoTxStatus> getTransactionStatus(String txId) async {
    final info = await pendingTransactionInfo(txId);
    if (info.poolError.isNotEmpty) return AlgoTxStatus.failed;
    if (info.confirmedRound != null) return AlgoTxStatus.block;
    return AlgoTxStatus.pending;
  }

  /// ASA holdings of [address], one page ([limit] rows) per event, following
  /// `next-token` cursors. Consumers partition fungible tokens from pure
  /// NFTs (see [isNftAssetParams]).
  Stream<List<AlgoRestTypesAccountAssetHolding>> watchAccountHoldings(
    AlgoAddress address, {
    int limit = 1000,
  }) async* {
    String? next;
    do {
      final page = await provider.request(
        AlgoRestRequestAccountAssetsInformation(
          address: address.address,
          limit: limit,
          next: next,
        ),
      );
      final holdings = page.assetHoldings ?? const [];
      if (holdings.isNotEmpty) yield holdings;
      next = page.nextToken;
    } while (next != null);
  }

  /// Asset params of [assetId], or null only when the asset does not exist
  /// on-chain. Transport failures rethrow.
  Future<AlgoRestTypesAssetParams?> getAssetParams(BigInt assetId) async {
    try {
      final asset = await provider.request(
        AlgoRestRequestGetAssetByID(assetId: assetId.toInt()),
      );
      return asset.params;
    } catch (e) {
      if (isAlgoNotFound(e)) return null;
      rethrow;
    }
  }

  /// Pure ASA NFT shape: indivisible single-supply asset.
  static bool isNftAssetParams(AlgoRestTypesAssetParams params) {
    return params.decimals == BigInt.zero && params.total == BigInt.one;
  }

  Future<AlgoRestTypesSimulateResponse> simulateTransactions(
    List<AlgoSignedTxn> txes, {
    bool allowEmptySignatures = true,
    Duration? timeout,
  }) async {
    return await provider.request(
      AlgoRestRequestSimulateTransaction(
        simulate: AlgoRestTypesSimulateRequest(
          allowEmptySignatures: allowEmptySignatures,
          fixSigners: true,
          txnGroups: [AlgoRestTypesSimulateRequestTransactionGroup(txns: txes)],
        ),
      ),
      timeout: timeout,
    );
  }

  Future<AlgoRestTypesTransactionParametersResponse> getTransactionParams({
    Duration? timeout,
  }) async {
    return await provider.request(
      AlgoRestRequestTransactionParams(),
      timeout: timeout,
    );
  }

  Future<AlgoTypesSuggestedParams> getTransactionSuggestedParams({
    BigInt? flatFee,
    Duration? timeout,
  }) async {
    final params = await getTransactionParams(timeout: timeout);
    return AlgoTypesSuggestedParams(
      fee: flatFee ?? params.fee,
      genesisID: params.genesisId,
      genesisHash: params.genesisHash,
      firstRoundValid: params.lastRound,
      lastRoundValid: params.lastRound + BigInt.from(1000),
      consensusVersion: params.consensusVersion,
      flatFee: flatFee != null,
      minFee: params.minFee,
    );
  }

  Future<AlgoRestTypesPostTransactionsResponse> sendTransactions(
    List<AlgoSignedTxn> txs, {
    Duration? timeout,
  }) async {
    final txsBytes = txs.expand((e) => e.toSerializeBytes()).toList();
    return await provider.request(
      AlgoRestRequestRawTransaction(source: txsBytes),
      timeout: timeout,
    );
  }

  Future<AlgoRestTypesNodeStatusResponse> status({Duration? timeout}) async {
    final result = await provider.request(
      AlgoRestRequestGetStatus(),
      timeout: timeout,
    );
    return result;
  }

  Future<AlgoRestTypesAccount> getAccount(
    AlgoAddress address, {
    Duration? timeout,
  }) async {
    return await provider.request(
      AlgoRestRequestAccountInformation(address: address.address),
      timeout: timeout,
    );
  }

  Future<AlgoRestTypesAccountAssetsInformationResponse> getAccountAssets(
    AlgoAddress address, {
    Duration? timeout,
  }) async {
    return await provider.request(
      AlgoRestRequestAccountAssetsInformation(address: address.address),
      timeout: timeout,
    );
  }

  Future<List<int>> compile(List<int> tealBytes, {Duration? timeout}) async {
    final result = await provider.request(
      AlgoRestRequestTealCompile(source: tealBytes),
      timeout: timeout,
    );
    return StringUtils.encode(result.result, encoding: StringEncoding.base64);
  }

  Future<AlgoRestTypesAccountAssetResponse> getAccountAsset(
    AlgoAddress address,
    BigInt assetId, {
    Duration? timeout,
  }) async {
    return await provider.request(
      AlgoRestRequestAccountAssetInformation(
        address: address.address,
        assetId: assetId,
      ),
      timeout: timeout,
    );
  }

  Future<AlgoRestTypesPendingTransactionResponse> pendingTransactionInfo(
    String txId, {
    Duration? timeout,
  }) async {
    return await provider.request(
      AlgoRestRequestPendingTransactionInformation(txid: txId),
      timeout: timeout,
    );
  }

  Future<AlgoRestTypesNodeStatusResponse> statusAfterBlock(
    BigInt round, {
    Duration? timeout,
  }) async {
    return await provider.request(
      AlgoRestRequestWaitForBlock(round: round),
      timeout: timeout,
    );
  }

  Future<AlgoRestTypesPendingTransactionResponse> waitForConfirmation({
    required String txId,
    required int waitRounds,
    Duration? timeout,
  }) async {
    final status = await this.status(timeout: timeout);

    final lastRound = status.lastRound;
    BigInt currentRound = lastRound + BigInt.one;
    AlgoRestTypesPendingTransactionResponse response;
    while (true) {
      if (currentRound > lastRound + BigInt.from(waitRounds)) {
        throw OnChainErrors.algoPlugin(
          "waitForConfirmation",
          reason: "Transaction confirmation timeout.",
        );
      }
      try {
        response = await pendingTransactionInfo(txId);
        if (response.poolError.isNotEmpty) {
          throw OnChainErrors.algoPlugin(
            "waitForConfirmation",
            reason: response.poolError,
          );
        }
        final confirmation = response.confirmedRound;
        if (confirmation != null && confirmation > BigInt.zero) {
          return response;
        }
      } on BuError {
        rethrow;
      } catch (_) {}
      await statusAfterBlock(currentRound);
      currentRound += BigInt.one;
    }
  }
}
