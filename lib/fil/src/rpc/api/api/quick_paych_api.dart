import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/fil/src/address/address.dart';

import 'package:on_chain/fil/src/crypto/crypto.dart';
import 'package:on_chain/fil/src/types/types.dart';

import 'quick_api.dart';

/// High-level helpers for the built-in **Payment Channel** (Paych) actor.
mixin FilQuickPaychApi implements FilQuickApi {
  Future<TxResultWithMessageId<FilExecReturn>> paychCreate({
    required FilAddress from,
    required FilAddress to,
    required FilSigner signer,
    Cid? codeCid,
    BigInt? initBalance,
    int confidence = 1,
    Duration? timeout,
  }) async {
    codeCid ??= network.getLatestActor(FilActorNames.paymentchannel).cid;
    final ctor = FilPaychConstructorParams(from: from, to: to);
    final exec = FilInitExecParams(
      codeCid: codeCid,
      constructorParams: ctor.toCbor().encode(),
    );
    final result = await buildAndSendMessage(
      to: FilAddress.one(network: network.network),
      from: from,
      signer: signer,
      params: exec.toCbor().encode(),
      value: initBalance,
      method: FilMethods.initExec,
      confidence: confidence,
      timeout: timeout,
    );
    final rData = result.rawData;
    if (rData == null) {
      throw OnChainErrors.filPlugin(
        'paychCreate',
        reason: 'Empty Exec return.',
        details: {"from": from.address},
      );
    }
    return TxResultWithMessageId(
      message: result.message,
      result: FilExecReturn.deserialize(rData, network: network.network),
      rawData: result.rawData,
      messageId: result.messageId,
    );
  }

  Future<TxResultWithMessageId<FilEmptyReturn>> paychUpdateChannelState({
    required FilAddress channel,
    required FilAddress from,
    required FilSigner signer,
    required FilPaychSignedVoucher signedVoucher,
    List<int> secret = const [],
    int confidence = 1,
    Duration? timeout,
  }) async {
    final p = FilPaychUpdateChannelStateParams(
      signedVoucherCbor: signedVoucher,
      secret: secret,
    );
    return await buildAndSendMessage(
      to: channel,
      from: from,
      signer: signer,
      params: p.toCbor().encode(),
      method: FilMethods.paychUpdateChannelState,
      confidence: confidence,
      timeout: timeout,
    );
  }

  Future<TxResultWithMessageId<FilEmptyReturn>> paychSettle({
    required FilAddress channel,
    required FilAddress from,
    required FilSigner signer,
    int confidence = 1,
    Duration? timeout,
  }) async {
    return await buildAndSendMessage(
      to: channel,
      from: from,
      signer: signer,
      method: FilMethods.paychSettle,
      confidence: confidence,
      timeout: timeout,
    );
  }

  Future<TxResultWithMessageId<FilEmptyReturn>> paychCollect({
    required FilAddress channel,
    required FilAddress from,
    required FilSigner signer,
    int confidence = 1,
    Duration? timeout,
  }) async {
    return await buildAndSendMessage(
      to: channel,
      from: from,
      signer: signer,
      method: FilMethods.paychCollect,
      confidence: confidence,
      timeout: timeout,
    );
  }

  Future<TxResultWithMessageId<FilAddress>> getAccountPubkeyAddress({
    required FilAddress account,
    required FilAddress from,
    required FilSigner signer,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final result = await buildAndSendMessage(
      to: account,
      from: from,
      signer: signer,
      method: FilMethods.accountPubkeyAddress,
      confidence: confidence,
      timeout: timeout,
    );
    final rData = result.rawData;
    if (rData == null) {
      throw OnChainErrors.filPlugin(
        'getAccountPubkeyAddress',
        reason: 'Empty account pubkey return.',
        details: {"account": account.address},
      );
    }
    return TxResultWithMessageId(
      message: result.message,
      result: FilAddress.fromBytes(rData, network: network.network),
      rawData: rData,
      messageId: result.messageId,
    );
  }
}
