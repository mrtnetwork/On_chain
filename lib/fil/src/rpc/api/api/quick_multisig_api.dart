import 'package:blockchain_utils/chain/address/address.dart';

import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/fil/src/address/address.dart';
import 'package:on_chain/fil/src/crypto/crypto.dart';
import 'package:on_chain/fil/src/rpc/rpc.dart';
import 'package:on_chain/fil/src/types/types.dart';

/// High-level helpers for the built-in **Multisig** actor.
mixin FilQuickMultisigApi implements FilQuickApi {
  // ---------------------------------------------------------------------------
  // Queries
  // ---------------------------------------------------------------------------

  Future<FilMultisigStateInfo> getMultisigState(FilAddress address) async {
    final state = await provider.request(
      LotusFullNodeRequestStateReadState(actor: address.address),
    );
    if (state == null) {
      throw OnChainErrors.filPlugin(
        "getMultisigState",
        reason: "State not found.",
        details: {"address": address.address},
      );
    }
    network.getSupportedCid(FilActorNames.multisig, state.code);
    return FilMultisigStateInfo(
      balance: state.balance,
      code: state.code,
      state: FilMultisigState.fromJson(
        JsonParser.valueEnsureAsMap(state.state),
      ),
    );
  }

  Future<List<LotusResponseMsigTransaction>> getMultisigPending(
    FilAddress address,
  ) async {
    return await provider.request(
      LotusFullNodeRequestMsigGetPending(address: address.address),
    );
  }

  // ---------------------------------------------------------------------------
  // Create
  // ---------------------------------------------------------------------------

  Future<TxResultWithMessageId<FilExecReturn>> multisigCreate({
    required FilAddress from,
    required List<FilAddress> signers,
    required BigInt threshold,
    required FilSigner signer,
    Cid? codeCid,
    BigInt? unlockDuration,
    BigInt? startEpoch,
    BigInt? initBalance,
    int confidence = 1,
    Duration? timeout,
  }) async {
    codeCid ??= network.getLatestActor(FilActorNames.multisig).cid;
    final constructorParams = FilMultisigConstructorParams(
      signers: signers,
      numApprovalsThreshold: threshold,
      unlockDuration: unlockDuration ?? BigInt.zero,
      startEpoch: startEpoch ?? BigInt.zero,
    );
    final execParams = FilInitExecParams(
      codeCid: codeCid,
      constructorParams: constructorParams.toCbor().encode(),
    );
    final result = await buildAndSendMessage(
      to: FilAddress.one(network: network.network),
      from: from,
      signer: signer,
      params: execParams.toCbor().encode(),
      value: initBalance,
      method: FilMethods.initExec,
      confidence: confidence,
      timeout: timeout,
    );
    final rData = result.rawData;
    if (rData == null) {
      throw OnChainErrors.filPlugin(
        'multisigCreate',
        reason: 'Empty Exec return.',
        details: {"address": from.address},
      );
    }
    return TxResultWithMessageId(
      message: result.message,
      result: FilExecReturn.deserialize(rData, network: network.network),
      rawData: rData,
      messageId: result.messageId,
    );
  }

  // ---------------------------------------------------------------------------
  // Propose / Approve / Cancel
  // ---------------------------------------------------------------------------

  Future<TxResultWithMessageId<FilMultisigProposeReturn>> multisigPropose({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required FilAddress to,
    BigInt? value,
    BigInt? method,
    List<int> params = const [],
    int confidence = 1,
    Duration? timeout,
  }) async {
    final amount = FilTokenAmount(value ?? BigInt.zero);
    final p = FilMultisigProposeParams(
      to: to,
      value: amount,
      method: method ?? FilMethods.send,
      params: params,
    );
    FilAddress requester = from;
    if (requester.type != FilAddrType.id) {
      final id = await lookupID(from);
      if (id == null) {
        throw OnChainErrors.filPlugin(
          'multisigPropose',
          reason: 'Failed to get requester account ID.',
          details: {"from": from.address},
        );
      }
      requester = id;
    }
    final result = await buildAndSendMessage(
      to: msig,
      from: from,
      signer: signer,
      params: p.toCbor().encode(),
      method: FilMethods.msigPropose,
      confidence: confidence,
      timeout: timeout,
    );
    final rData = result.rawData;
    if (rData == null) {
      throw OnChainErrors.filPlugin(
        'multisigPropose',
        reason: 'Empty Propose return.',
        details: {"msig": msig.address},
      );
    }
    final hash = multisigProposalHash(
      requester: requester,
      to: to,
      value: amount,
      method: method ?? FilMethods.send,
      params: params,
    );
    return TxResultWithMessageId(
      message: result.message,
      result: FilMultisigProposeReturn.deserialize(
        bytes: rData,
        proposalHash: hash,
      ),
      rawData: result.rawData,
      messageId: result.messageId,
    );
  }

  Future<TxResultWithMessageId<FilMultisigApproveReturn>> multisigApprove({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required BigInt txnId,
    List<int>? proposalHash,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final p = FilMultisigTxnIDParams(id: txnId, proposalHash: proposalHash);
    final result = await buildAndSendMessage(
      to: msig,
      from: from,
      signer: signer,
      params: p.toCbor().encode(),
      method: FilMethods.msigApprove,
      confidence: confidence,
      timeout: timeout,
    );
    final rData = result.rawData;
    if (rData == null) {
      throw OnChainErrors.filPlugin(
        'multisigApprove',
        reason: 'Empty Approve return.',
        details: {"msig": msig.address},
      );
    }
    return TxResultWithMessageId(
      message: result.message,
      result: FilMultisigApproveReturn.deserialize(rData),
      rawData: result.rawData,
      messageId: result.messageId,
    );
  }

  Future<TxResultWithMessageId<FilEmptyReturn>> multisigCancel({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required BigInt txnId,
    List<int>? proposalHash,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final p = FilMultisigTxnIDParams(id: txnId, proposalHash: proposalHash);
    return await buildAndSendMessage(
      to: msig,
      from: from,
      signer: signer,
      params: p.toCbor().encode(),
      method: FilMethods.msigCancel,
      confidence: confidence,
      timeout: timeout,
    );
  }

  // ---------------------------------------------------------------------------
  // Signer management
  // ---------------------------------------------------------------------------

  Future<TxResultWithMessageId<FilEmptyReturn>> multisigAddSigner({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required FilAddress newSigner,
    bool increase = false,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final p = FilMultisigAddSignerParams(signer: newSigner, increase: increase);
    return await buildAndSendMessage(
      to: msig,
      from: from,
      signer: signer,
      params: p.toCbor().encode(),
      method: FilMethods.msigAddSigner,
      confidence: confidence,
      timeout: timeout,
    );
  }

  Future<TxResultWithMessageId<FilMultisigProposeReturn>>
  multisigProposeAddSigner({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required FilAddress newSigner,
    bool increase = false,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final inner = FilMultisigAddSignerParams(
      signer: newSigner,
      increase: increase,
    );
    return multisigPropose(
      msig: msig,
      from: from,
      signer: signer,
      to: msig,
      method: FilMethods.msigAddSigner,
      params: inner.toCbor().encode(),
      confidence: confidence,
      timeout: timeout,
    );
  }

  Future<TxResultWithMessageId<FilEmptyReturn>> multisigRemoveSigner({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required FilAddress remove,
    bool decrease = false,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final p = FilMultisigRemoveSignerParams(signer: remove, decrease: decrease);
    return await buildAndSendMessage(
      to: msig,
      from: from,
      signer: signer,
      params: p.toCbor().encode(),
      method: FilMethods.msigRemoveSigner,
      confidence: confidence,
      timeout: timeout,
    );
  }

  Future<TxResultWithMessageId<FilMultisigProposeReturn>>
  multisigProposeRemoveSigner({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required FilAddress remove,
    bool decrease = false,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final inner = FilMultisigRemoveSignerParams(
      signer: remove,
      decrease: decrease,
    );
    return multisigPropose(
      msig: msig,
      from: from,
      signer: signer,
      to: msig,
      method: FilMethods.msigRemoveSigner,
      params: inner.toCbor().encode(),
      confidence: confidence,
      timeout: timeout,
    );
  }

  Future<TxResultWithMessageId<FilEmptyReturn>> multisigSwapSigner({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required FilAddress oldSigner,
    required FilAddress newSigner,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final p = FilMultisigSwapSignerParams(from: oldSigner, to: newSigner);
    return await buildAndSendMessage(
      to: msig,
      from: from,
      signer: signer,
      params: p.toCbor().encode(),
      method: FilMethods.msigSwapSigner,
      confidence: confidence,
      timeout: timeout,
    );
  }

  Future<TxResultWithMessageId<FilMultisigProposeReturn>>
  multisigProposeSwapSigner({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required FilAddress oldSigner,
    required FilAddress newSigner,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final inner = FilMultisigSwapSignerParams(from: oldSigner, to: newSigner);
    return multisigPropose(
      msig: msig,
      from: from,
      signer: signer,
      to: msig,
      method: FilMethods.msigSwapSigner,
      params: inner.toCbor().encode(),
      confidence: confidence,
      timeout: timeout,
    );
  }

  // ---------------------------------------------------------------------------
  // Threshold / lock
  // ---------------------------------------------------------------------------

  Future<TxResultWithMessageId<FilEmptyReturn>>
  multisigChangeNumApprovalsThreshold({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required BigInt newThreshold,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final p = FilMultisigChangeNumApprovalsThresholdParams(newThreshold);
    return await buildAndSendMessage(
      to: msig,
      from: from,
      signer: signer,
      params: p.toCbor().encode(),
      method: FilMethods.msigChangeNumApprovalsThreshold,
      confidence: confidence,
      timeout: timeout,
    );
  }

  Future<TxResultWithMessageId<FilMultisigProposeReturn>>
  multisigProposeChangeNumApprovalsThreshold({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required BigInt newThreshold,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final inner = FilMultisigChangeNumApprovalsThresholdParams(newThreshold);
    return multisigPropose(
      msig: msig,
      from: from,
      signer: signer,
      to: msig,
      method: FilMethods.msigChangeNumApprovalsThreshold,
      params: inner.toCbor().encode(),
      confidence: confidence,
      timeout: timeout,
    );
  }

  Future<TxResultWithMessageId<FilEmptyReturn>> multisigLockBalance({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required BigInt startEpoch,
    required BigInt unlockDuration,
    required BigInt amount,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final p = FilMultisigLockBalanceParams(
      startEpoch: startEpoch,
      unlockDuration: unlockDuration,
      amount: FilTokenAmount(amount),
    );
    return await buildAndSendMessage(
      to: msig,
      from: from,
      signer: signer,
      params: p.toCbor().encode(),
      method: FilMethods.msigLockBalance,
      confidence: confidence,
      timeout: timeout,
    );
  }

  Future<TxResultWithMessageId<FilMultisigProposeReturn>>
  multisigProposeLockBalance({
    required FilAddress msig,
    required FilAddress from,
    required FilSigner signer,
    required BigInt startEpoch,
    required BigInt unlockDuration,
    required BigInt amount,
    int confidence = 1,
    Duration? timeout,
  }) async {
    final inner = FilMultisigLockBalanceParams(
      startEpoch: startEpoch,
      unlockDuration: unlockDuration,
      amount: FilTokenAmount(amount),
    );
    return multisigPropose(
      msig: msig,
      from: from,
      signer: signer,
      to: msig,
      method: FilMethods.msigLockBalance,
      params: inner.toCbor().encode(),
      confidence: confidence,
      timeout: timeout,
    );
  }

  // ---------------------------------------------------------------------------
  // One-shot helpers
  // ---------------------------------------------------------------------------

  Future<FilMultisigOneShotResult> multisigOneShot({
    required FilAddress msig,
    required List<FilSignerWithAddress> signers,
    required FilAddress to,
    BigInt? value,
    BigInt? method,
    List<int> params = const [],
    int confidence = 1,
    Duration? timeout,
  }) async {
    if (signers.isEmpty) {
      throw OnChainErrors.filPlugin(
        'multisigOneShot',
        reason: 'At least one signer is required.',
        details: {"msig": msig.address, "count": "${signers.length}"},
      );
    }
    final proposer = signers.first;
    final proposeMethod = method ?? FilMethods.send;
    final proposeValue = value ?? BigInt.zero;

    final proposeRet = await multisigPropose(
      msig: msig,
      from: proposer.address,
      signer: proposer.signer,
      to: to,
      value: proposeValue,
      method: proposeMethod,
      params: params,
      confidence: confidence,
      timeout: timeout,
    );

    if (proposeRet.result.applied) {
      return FilMultisigOneShotResult(
        txnId: proposeRet.result.txnId,
        propose: proposeRet,
        approvals: const [],
        applied: true,
        latestCode: proposeRet.result.code,
        latestRet: proposeRet.result.ret,
      );
    }

    final hash = multisigProposalHash(
      requester: proposer.address,
      to: to,
      value: FilTokenAmount(proposeValue),
      method: proposeMethod,
      params: params,
    );

    final approvals = <TxResultWithMessageId<FilMultisigApproveReturn>>[];
    for (final s in signers.skip(1)) {
      final approveRet = await multisigApprove(
        msig: msig,
        from: s.address,
        signer: s.signer,
        txnId: proposeRet.result.txnId,
        proposalHash: hash,
        confidence: confidence,
        timeout: timeout,
      );
      approvals.add(approveRet);
      if (approveRet.result.applied) {
        return FilMultisigOneShotResult(
          txnId: proposeRet.result.txnId,
          propose: proposeRet,
          approvals: approvals,
          applied: true,
          latestCode: approveRet.result.code,
          latestRet: approveRet.result.ret,
        );
      }
    }
    return FilMultisigOneShotResult(
      txnId: proposeRet.result.txnId,
      propose: proposeRet,
      approvals: approvals,
      applied: false,
      latestCode: approvals.lastOrNull?.result.code,
      latestRet: approvals.lastOrNull?.result.ret,
    );
  }

  Future<FilMultisigOneShotResult> multisigOneShotTransfer({
    required FilAddress msig,
    required List<FilSignerWithAddress> signers,
    required FilAddress to,
    required BigInt value,
    int confidence = 1,
    Duration? timeout,
  }) {
    return multisigOneShot(
      msig: msig,
      signers: signers,
      to: to,
      value: value,
      method: FilMethods.send,
      params: const [],
      confidence: confidence,
      timeout: timeout,
    );
  }

  List<int> multisigProposalHash({
    required FilAddress requester,
    required FilAddress to,
    required FilTokenAmount value,
    required BigInt method,
    List<int> params = const [],
  }) {
    return FilMultisigProposalHashData(
      requester: requester,
      to: to,
      value: value,
      method: method,
      params: params,
    ).hash();
  }
}
