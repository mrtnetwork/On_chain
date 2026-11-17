import 'dart:async';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/fil/src/address/address.dart';
import 'package:on_chain/fil/src/crypto/crypto.dart';
import 'package:on_chain/fil/src/rpc/methods/full_node/full_node.dart';
import 'package:on_chain/fil/src/rpc/types/types/full_node.dart';
import 'package:on_chain/fil/src/types/types.dart';

class FilQuickApiUtils {
  static bool isActorNotFoundErr(Object? e) {
    if (e case RPCError err
        when err.message.toLowerCase().contains("actor not found")) {
      return true;
    }
    return false;
  }

  static bool isLookupErrorMessage(Object? e) {
    if (e case RPCError err
        when err.message.toLowerCase().contains("failed to lookup the id")) {
      return true;
    }
    return false;
  }
}

/// Unified transaction status (wallet `WalletTransactionStatus` parity for
/// the Filecoin cases).
enum FilTxStatus {
  /// The message lookup is present and executed successfully.
  block,

  /// The message lookup is present but executed with a non-zero exit code.
  failed,

  /// The message lookup is unknown.
  unknown,
}

/// Core high-level Filecoin RPC helpers.
abstract mixin class FilQuickApi {
  FilNetworkConfig get network;
  IProvider<IServiceProvider, BaseServiceRequestParams> get provider;

  Future<BigInt> getBalance(FilAddress address) async {
    return await provider.request(
      LotusFullNodeRequestWalletBalance(address: address.address),
    );
  }

  Future<LotusResponseActorState?> getState(FilAddress address) async {
    return await provider.request(
      LotusFullNodeRequestStateReadState(actor: address.address),
    );
  }

  Future<Cid> mpoolPush(FilSignedMessage message) async {
    return await provider.request(
      LotusFullNodeRequestMpoolPush(message: message),
    );
  }

  Future<LotusResponseActor?> getActor(FilAddress address) async {
    return await provider.request(
      LotusFullNodeRequestStateGetActor(actor: address.address),
    );
  }

  /// Nonce of [address]; zero when the actor is missing. Any other failure
  /// throws.
  Future<BigInt> getActorNonce(FilAddress address) async {
    try {
      final actor = await getActor(address);
      return actor?.nonce ?? BigInt.zero;
    } catch (e) {
      if (FilQuickApiUtils.isActorNotFoundErr(e)) return BigInt.zero;
      rethrow;
    }
  }

  Future<FilMessage> estimateGas(FilMessage message) async {
    return await provider.request(
      LotusFullNodeRequestGasEstimateMessageGas(message: message),
    );
  }

  Future<BigInt> epoch() async {
    final head = await provider.request(LotusFullNodeRequestChainHead());
    return head.height;
  }

  Future<LotusResponseMsgLookup?> stateSearchMsg(
    Cid message, {
    BigInt? limit,
  }) async {
    return await provider.request(
      LotusFullNodeRequestStateSearchMsg(
        msg: message,
        limit: limit ?? BigInt.from(9000),
        allowReplaced: false,
      ),
    );
  }

  Future<String> networkName() async {
    final params = await provider.request(
      const LotusFullNodeRequestStateGetNetworkParams(),
    );
    return params.networkName;
  }

  Future<FilAddress?> lookupID(FilAddress addr) async {
    try {
      final id = await provider.request(
        LotusFullNodeRequestStateLookupID(address: addr.address),
      );
      if (id == null) return null;
      return FilAddress(id);
    } catch (e) {
      if (FilQuickApiUtils.isActorNotFoundErr(e) ||
          FilQuickApiUtils.isLookupErrorMessage(e)) {
        return null;
      }
      rethrow;
    }
  }

  Future<FilAddress?> lookupRobust(FilAddress addr) async {
    final robust = await provider.request(
      LotusFullNodeRequestStateLookupRobustAddress(address: addr.address),
    );
    if (robust.isEmpty) return null;
    return FilAddress(robust);
  }

  /// Builds, estimates gas, signs and pushes a message.
  ///
  /// [confidence] / [timeout] are forwarded to [pushWithResult].
  Future<TxResultWithMessageId<FilEmptyReturn>> buildAndSendMessage({
    required FilAddress to,
    required FilAddress from,
    required FilSigner signer,
    BigInt? nonce,
    BigInt? value,
    List<int>? params,
    BigInt? method,
    int confidence = 1,
    Duration? timeout,
  }) async {
    if (nonce == null) {
      final actor = await getActor(from);
      nonce = actor?.nonce;
      if (nonce == null) {
        throw OnChainErrors.filPlugin(
          "buildAndSendMessage",
          reason: "Account not found.",
          details: {"from": from.address},
        );
      }
    }
    if (params != null && method == null) {
      throw OnChainErrors.filPlugin(
        "buildAndSendMessage",
        reason: "Method not provided for params.",
      );
    }
    FilMessage message = FilMessage(
      to: to,
      from: from,
      nonce: nonce,
      value: FilTokenAmount(value ?? BigInt.zero),
      gasLimit: BigInt.zero,
      gasFeeCap: FilTokenAmount.zero(),
      gasPremium: FilTokenAmount.zero(),
      method: method ?? FilMethods.send,
      params: params,
    );
    final estimate = await estimateGas(message);
    final signedMessage = await signer.signFilMessage(estimate);
    return await pushWithResult(
      signedMessage,
      confidence: confidence,
      timeout: timeout,
    );
  }

  /// Pushes [message] and waits until it is included and executed.
  Future<TxResultWithMessageId<FilEmptyReturn>> pushWithResult(
    FilSignedMessage message, {
    int confidence = 1,
    Duration? timeout,
  }) async {
    final cid = await mpoolPush(message);
    return waitForMessageExecution(
      message: message,
      messageId: cid,
      confidence: confidence,
      timeout: timeout,
    );
  }

  /// Waits for an already-pushed [message] ([messageId]) to execute without
  /// pushing it again: re-pushing an identical message errors (`already in
  /// mpool`). Mirrors the receipt handling below and returns the same
  /// [TxResultWithMessageId] shape.
  Future<TxResultWithMessageId<FilEmptyReturn>> waitForMessageExecution({
    required FilSignedMessage message,
    required Cid messageId,
    int confidence = 1,
    Duration? timeout,
  }) async {
    timeout ??= Duration(seconds: 120 + (60 * (confidence + 1)));
    final deadline = DateTime.now().toUtc().add(timeout);

    while (DateTime.now().toUtc().isBefore(deadline)) {
      try {
        final result = await provider.request(
          LotusFullNodeRequestStateWaitMsg(
            cid: messageId,
            allowReplaced: false,
            confidence: BigInt.from(confidence),
            limit: BigInt.zero,
          ),
          timeout: timeout,
        );
        final exitCode = result?.receipt.exitCode;
        if (exitCode != BigInt.zero) {
          throw OnChainErrors.filPlugin(
            "waitForMessageExecution",
            reason: "Message execution failed with code: $exitCode.",
            details: {"cid": messageId.cid},
          );
        }
        return TxResultWithMessageId(
          message: message,
          result: const FilEmptyReturn(),
          rawData: result?.receipt.returnValue,
          messageId: messageId,
        );
      } on RPCError {
        await Future.delayed(const Duration(seconds: 3));
      } on TimeoutException {
        break;
      }
    }
    throw OnChainErrors.filPlugin(
      "waitForMessageExecution",
      reason: "Timed out while waiting for message result.",
      details: {
        "cid": messageId.cid,
        "confidence": "$confidence",
        "timeout": "$timeout",
      },
    );
  }

  /// Status of a message by id: failed on a non-zero exit code, confirmed
  /// when the lookup is present, unknown otherwise (mirrors the wallet
  /// lookup; replaced messages with `allowReplaced: false` stay unknown).
  Future<FilTxStatus> getTransactionStatus(Cid messageId) async {
    final lookup = await stateSearchMsg(messageId);
    if (lookup == null) return FilTxStatus.unknown;
    if (lookup.receipt.exitCode != BigInt.zero) {
      return FilTxStatus.failed;
    }
    return FilTxStatus.block;
  }
}
