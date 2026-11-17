import 'package:blockchain_utils/chain/address/address.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/rpc/api/types/operations.dart';
import 'package:on_chain/tezos/src/rpc/types/types/types.dart';
import 'package:on_chain/tezos/src/utils/utils.dart';
import 'package:on_chain/tezos/src/rpc/types/types/mempool.dart';
import 'package:on_chain/tezos/src/rpc/types/types/ushuaia.dart';

extension ExtOctezMempoolOperationHash on OctezMempoolOperationHash {
  String asOperationHash() {
    return switch (this) {
      OctezMempoolUnistringStringValue(:final value) => value,
      OctezMempoolUnistringInvalidUtf8String(:final invalidUtf8String) =>
        TezosUtils.encodeOperationHash(invalidUtf8String),
    };
  }
}

extension ExtOctezUshuaiaOperationHash on OctezUshuaiaOperationHash {
  String asOperationHash() {
    return fold(onString: (v) => v, onBytes: TezosUtils.encodeOperationHash);
  }

  String asBlockHash() {
    return fold(onString: (v) => v, onBytes: TezosUtils.encodeBlockHash);
  }
}

extension ExtOctezMempoolUnistring on OctezMempoolUnistring {
  String asString() {
    return switch (this) {
      OctezMempoolUnistringStringValue(:final value) => value,
      OctezMempoolUnistringInvalidUtf8String() =>
        throw OnChainErrors.tezosPlugin(
          "OctezUshuaiaUnistring.asString",
          reason: "Failed to encode value as string.",
        ),
    };
  }
}

extension ExtOctezMempoolResponsePendingOperations
    on OctezMempoolResponsePendingOperations {
  OctezMempoolResponsePendingOperationsRefusedItem? operationRefused(
    String opHash,
  ) {
    for (final i in branchRefused) {
      if (i.hash.asOperationHash() == opHash) return i;
    }
    for (final i in refused) {
      if (i.hash.asOperationHash() == opHash) return i;
    }
    for (final i in outdated) {
      if (i.hash.asOperationHash() == opHash) return i;
    }
    return null;
  }

  bool inMempool(String opHash) {
    for (final i in validated) {
      if (i.hash.asOperationHash() == opHash) return true;
    }
    for (final i in branchDelayed) {
      if (i.hash.asOperationHash() == opHash) return true;
    }
    for (final i in unprocessed) {
      if (i.hash.asOperationHash() == opHash) return true;
    }
    return false;
  }
}

extension ExtOctezUshuaiaOperation on OctezUshuaiaOperation {
  String getHash() {
    return switch (this) {
      OctezUshuaiaOperationProtocolChainIdHashBranchMetadata(:final hash) ||
      OctezUshuaiaOperationProtocolChainIdHashBranch(:final hash) ||
      OctezUshuaiaOperationProtocolChainIdHashBranch2(
        :final hash,
      ) => hash.asOperationHash(),
    };
  }
}

extension ExtOctezUshuaiaUnistring on OctezUshuaiaUnistring {
  T fold<T>({
    required T Function(String v) onString,
    required T Function(List<int> v) onBytes,
  }) {
    return switch (this) {
      OctezUshuaiaUnistringStringValue(:final value) => onString(value),
      OctezUshuaiaUnistringInvalidUtf8String(:final invalidUtf8String) =>
        onBytes(invalidUtf8String),
    };
  }
}

extension ExtOctezUshuaiaN025PsUshuaiContractIdOriginated
    on OctezUshuaiaN025PsUshuaiContractIdOriginated {
  TezosAddress contractAddress() {
    return fold(
      onString: (v) => TezosAddress(v, type: XtzAddrPrefixes.kt1),
      onBytes: (v) => TezosAddress.fromBytes(v, type: XtzAddrPrefixes.kt1),
    );
  }
}

extension ExtOctezUshuaiaOperationProtocolChainIdHashBranchAndContents
    on OctezUshuaiaOperationProtocolChainIdHashBranchAndContents {
  List<OctezUshuaiaRunOperationContentSummary> get contentSummaries {
    return switch (contents) {
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationWithMetadataOperationWithMetadata
      withMetadat =>
        withMetadat.contents
            .map(OctezOperationSummaryUtils._summarizeContentsAndResult)
            .toList(),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationWithMetadataOperationWithoutMetadata() =>
        [],
    };
  }
}

extension OctezUshuaiaRunOperationUsefulData
    on OctezUshuaiaResponseHelpersScriptsRunOperation {
  List<OctezUshuaiaRunOperationContentSummary> get contentSummaries {
    return switch (this) {
      final OctezUshuaiaResponseHelpersScriptsRunOperationOperationWithMetadata
      withMeta =>
        withMeta.contents
            .map(OctezOperationSummaryUtils._summarizeContentsAndResult)
            .toList(),
      OctezUshuaiaResponseHelpersScriptsRunOperationOperationWithoutMetadata() =>
        const [],
    };
  }

  bool get hasErrors => contentSummaries.any((s) => s.hasErrors);

  bool get allSucceeded =>
      contentSummaries.isNotEmpty && contentSummaries.every((s) => s.succeeded);

  BigInt get totalConsumedMilligas => contentSummaries.fold(
    BigInt.zero,
    (acc, s) => acc + s.totalConsumedMilligas,
  );

  BigInt? suggestedGasLimit({int marginUnits = 100}) {
    final milligas = totalConsumedMilligas;
    if (milligas == BigInt.zero && !allSucceeded) return null;
    final units = milligas ~/ BigInt.from(1000);
    return units + BigInt.from(marginUnits);
  }
}

abstract final class OctezOperationSummaryUtils {
  // ---------------------------------------------------------------------------
  // Top-level content summarizer (fully typed, no dynamic)
  // ---------------------------------------------------------------------------

  static OctezUshuaiaRunOperationContentSummary _summarizeContentsAndResult(
    // OctezUshuaiaN025PsUshuaiOperationAlphaOperationWithMetadata
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResult content,
  ) {
    return switch (content) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultReveal
      r =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.reveal,
          result: _parseRevealResult(r.metadata.operationResult),
          internalOperations: _summarizeInternals(
            r.metadata.internalOperationResults,
          ),
          fee: r.fee,
          gasLimit: r.gasLimit,
          storageLimit: r.storageLimit,
          content: r,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultTransaction
      t =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.transaction,
          result: _parseTransactionResult(t.metadata.operationResult),
          internalOperations: _summarizeInternals(
            t.metadata.internalOperationResults,
          ),
          fee: t.fee,
          gasLimit: t.gasLimit,
          storageLimit: t.storageLimit,
          content: t,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultOrigination
      o =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.origination,
          result: _parseOriginationResult(o.metadata.operationResult),
          internalOperations: _summarizeInternals(
            o.metadata.internalOperationResults,
          ),
          fee: o.fee,
          gasLimit: o.gasLimit,
          storageLimit: o.storageLimit,
          content: o,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultDelegation
      d =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.delegation,
          result: _parseDelegationResult(d.metadata.operationResult),
          internalOperations: _summarizeInternals(
            d.metadata.internalOperationResults,
          ),
          fee: d.fee,
          gasLimit: d.gasLimit,
          storageLimit: d.storageLimit,
          content: d,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultRegisterGlobalConstant
      c =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.registerGlobalConstant,
          result: _parseRegisterGlobalConstantResult(
            c.metadata.operationResult,
          ),
          internalOperations: _summarizeInternals(
            c.metadata.internalOperationResults,
          ),
          fee: c.fee,
          gasLimit: c.gasLimit,
          storageLimit: c.storageLimit,
          content: c,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSetDepositsLimit
      s =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.setDepositsLimit,
          result: _parseSetDepositsLimitResult(s.metadata.operationResult),
          internalOperations: _summarizeInternals(
            s.metadata.internalOperationResults,
          ),
          fee: s.fee,
          gasLimit: s.gasLimit,
          storageLimit: s.storageLimit,
          content: s,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultIncreasePaidStorage
      i =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.increasePaidStorage,
          result: _parseIncreasePaidStorageResult(i.metadata.operationResult),
          internalOperations: _summarizeInternals(
            i.metadata.internalOperationResults,
          ),
          fee: i.fee,
          gasLimit: i.gasLimit,
          storageLimit: i.storageLimit,
          content: i,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultUpdateConsensusKey
      u =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.updateConsensusKey,
          result: _parseUpdateConsensusKeyResult(u.metadata.operationResult),
          internalOperations: _summarizeInternals(
            u.metadata.internalOperationResults,
          ),
          fee: u.fee,
          gasLimit: u.gasLimit,
          storageLimit: u.storageLimit,
          content: u,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultTransferTicket
      t =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.transferTicket,
          result: _parseTransferTicketResult(t.metadata.operationResult),
          internalOperations: _summarizeInternals(
            t.metadata.internalOperationResults,
          ),
          fee: t.fee,
          gasLimit: t.gasLimit,
          storageLimit: t.storageLimit,
          content: t,
        ),
      // Consensus / evidence / voting — no operation_result or gas limits
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultAttestation
      a =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.attestation,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: a,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultAttestationWithDal
      a =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.attestationWithDal,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: a,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultPreattestation
      p =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.preattestation,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: p,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultAttestationsAggregate
      a =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.attestationsAggregate,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: a,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultPreattestationsAggregate
      p =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.preattestationsAggregate,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: p,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultDoubleConsensusOperationEvidence
      d =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.doubleConsensusOperationEvidence,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: d,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultDalEntrapmentEvidence
      d =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.dalEntrapmentEvidence,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: d,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSeedNonceRevelation
      s =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.seedNonceRevelation,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: s,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultVdfRevelation
      v =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.vdfRevelation,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: v,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultDoubleBakingEvidence
      d =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.doubleBakingEvidence,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: d,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultActivateAccount
      a =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.activeAccount,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: a,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultProposals
      p =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.proposals,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: p,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultBallot
      b =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.ballot,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: b,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultDrainDelegate
      d =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.drainDelegate,
          result: const OctezUshuaiaOperationResultInfo(
            status: OctezUshuaiaOperationResultStatus.applied,
          ),
          internalOperations: const [],
          content: d,
        ),
      // Manager-style ops with full operation_result
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultUpdateCompanionKey
      u =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.updateCompanionKey,
          result: _parseUpdateConsensusKeyResult(u.metadata.operationResult),
          internalOperations: _summarizeInternals(
            u.metadata.internalOperationResults,
          ),
          fee: u.fee,
          gasLimit: u.gasLimit,
          storageLimit: u.storageLimit,
          content: u,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultDalPublishCommitment
      d =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.dalPublishCommitment,
          result: _parseDalPublishCommitmentResult(d.metadata.operationResult),
          internalOperations: _summarizeInternals(
            d.metadata.internalOperationResults,
          ),
          fee: d.fee,
          gasLimit: d.gasLimit,
          storageLimit: d.storageLimit,
          content: d,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSmartRollupOriginate
      s =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.smartRollupOriginate,
          result: _parseSmartRollupOriginateResult(s.metadata.operationResult),
          internalOperations: _summarizeInternals(
            s.metadata.internalOperationResults,
          ),
          fee: s.fee,
          gasLimit: s.gasLimit,
          storageLimit: s.storageLimit,
          content: s,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSmartRollupAddMessages
      s =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.smartRollupAddMessages,
          result: _parseSmartRollupAddMessagesResult(
            s.metadata.operationResult,
          ),
          internalOperations: _summarizeInternals(
            s.metadata.internalOperationResults,
          ),
          fee: s.fee,
          gasLimit: s.gasLimit,
          storageLimit: s.storageLimit,
          content: s,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSmartRollupCement
      s =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.smartRollupCement,
          result: _parseSmartRollupCementResult(s.metadata.operationResult),
          internalOperations: _summarizeInternals(
            s.metadata.internalOperationResults,
          ),
          fee: s.fee,
          gasLimit: s.gasLimit,
          storageLimit: s.storageLimit,
          content: s,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSmartRollupPublish
      s =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.smartRollupPublish,
          result: _parseSmartRollupPublishResult(s.metadata.operationResult),
          internalOperations: _summarizeInternals(
            s.metadata.internalOperationResults,
          ),
          fee: s.fee,
          gasLimit: s.gasLimit,
          storageLimit: s.storageLimit,
          content: s,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSmartRollupRefute
      s =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.smartRollupRefute,
          result: _parseSmartRollupRefuteResult(s.metadata.operationResult),
          internalOperations: _summarizeInternals(
            s.metadata.internalOperationResults,
          ),
          fee: s.fee,
          gasLimit: s.gasLimit,
          storageLimit: s.storageLimit,
          content: s,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSmartRollupTimeout
      s =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.smartRollupTimeout,
          result: _parseSmartRollupTimeoutResult(s.metadata.operationResult),
          internalOperations: _summarizeInternals(
            s.metadata.internalOperationResults,
          ),
          fee: s.fee,
          gasLimit: s.gasLimit,
          storageLimit: s.storageLimit,
          content: s,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSmartRollupExecuteOutboxMessage
      s =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.smartRollupExecuteOutboxMessage,
          result: _parseSmartRollupExecuteOutboxMessageResult(
            s.metadata.operationResult,
          ),
          internalOperations: _summarizeInternals(
            s.metadata.internalOperationResults,
          ),
          fee: s.fee,
          gasLimit: s.gasLimit,
          storageLimit: s.storageLimit,
          content: s,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSmartRollupRecoverBond
      s =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.smartRollupRecoverBond,
          result: _parseSmartRollupRecoverBondResult(
            s.metadata.operationResult,
          ),
          internalOperations: _summarizeInternals(
            s.metadata.internalOperationResults,
          ),
          fee: s.fee,
          gasLimit: s.gasLimit,
          storageLimit: s.storageLimit,
          content: s,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultZkRollupOrigination
      z =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.zkRollupOperation,
          result: _parseZkRollupOriginationResult(z.metadata.operationResult),
          internalOperations: _summarizeInternals(
            z.metadata.internalOperationResults,
          ),
          fee: z.fee,
          gasLimit: z.gasLimit,
          storageLimit: z.storageLimit,
          content: z,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultZkRollupPublish
      z =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.zkRollupPublish,
          result: _parseZkRollupPublishResult(z.metadata.operationResult),
          internalOperations: _summarizeInternals(
            z.metadata.internalOperationResults,
          ),
          fee: z.fee,
          gasLimit: z.gasLimit,
          storageLimit: z.storageLimit,
          content: z,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultZkRollupUpdate
      z =>
        OctezUshuaiaRunOperationContentSummary(
          kind: TezosOperationKind.zkRollupUpdate,
          result: _parseZkRollupUpdateResult(z.metadata.operationResult),
          internalOperations: _summarizeInternals(
            z.metadata.internalOperationResults,
          ),
          fee: z.fee,
          gasLimit: z.gasLimit,
          storageLimit: z.storageLimit,
          content: z,
        ),
    };
  }

  // ---------------------------------------------------------------------------
  // Internal operation summarizers
  // ---------------------------------------------------------------------------

  static List<OctezUshuaiaInternalOperationSummary> _summarizeInternals(
    List<OctezUshuaiaN025PsUshuaiApplyInternalResultsAlphaOperationResult>?
    internals,
  ) {
    if (internals == null || internals.isEmpty) return const [];
    return internals.map(_summarizeInternal).toList();
  }

  static OctezUshuaiaInternalOperationSummary _summarizeInternal(
    OctezUshuaiaN025PsUshuaiApplyInternalResultsAlphaOperationResult internal,
  ) {
    return switch (internal) {
      final OctezUshuaiaN025PsUshuaiApplyInternalResultsAlphaOperationResultTransaction
      t =>
        OctezUshuaiaInternalOperationSummary(
          kind: 'transaction',
          nonce: t.nonce,
          result: _parseInternalTransactionResult(t.result),
        ),
      final OctezUshuaiaN025PsUshuaiApplyInternalResultsAlphaOperationResultOrigination
      o =>
        OctezUshuaiaInternalOperationSummary(
          kind: 'origination',
          nonce: o.nonce,
          result: _parseInternalOriginationResult(o.result),
        ),
      final OctezUshuaiaN025PsUshuaiApplyInternalResultsAlphaOperationResultDelegation
      d =>
        OctezUshuaiaInternalOperationSummary(
          kind: 'delegation',
          nonce: d.nonce,
          result: _parseInternalDelegationResult(d.result),
        ),
      final OctezUshuaiaN025PsUshuaiApplyInternalResultsAlphaOperationResultEvent
      e =>
        OctezUshuaiaInternalOperationSummary(
          kind: 'event',
          nonce: e.nonce,
          result: _parseInternalEventResult(e.result),
        ),
    };
  }

  // ---------------------------------------------------------------------------
  // Main result parsers (typed only)
  // ---------------------------------------------------------------------------

  static OctezUshuaiaOperationResultInfo _parseRevealResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultReveal result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultRevealApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultRevealFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultRevealBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),

      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultRevealSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseTransactionResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransaction result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransactionFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransactionApplied
      a =>
        switch (a.value) {
          final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransactionAppliedValueToContract
          c =>
            OctezUshuaiaOperationResultInfo(
              status: OctezUshuaiaOperationResultStatus.applied,
              consumedMilligas: c.consumedMilligas,
              storageSize: c.storageSize,
              paidStorageSizeDiff: c.paidStorageSizeDiff,
            ),
          final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransactionAppliedValueToSmartRollup
          s =>
            OctezUshuaiaOperationResultInfo(
              status: OctezUshuaiaOperationResultStatus.applied,
              consumedMilligas: s.consumedMilligas,
            ),
        },
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransactionBacktracked
      b =>
        switch (b.value) {
          final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransactionBacktrackedValueToContract
          c =>
            OctezUshuaiaOperationResultInfo(
              status: OctezUshuaiaOperationResultStatus.backtracked,
              errors: c.errors,
              consumedMilligas: c.consumedMilligas,
              storageSize: c.storageSize,
              paidStorageSizeDiff: c.paidStorageSizeDiff,
            ),
          final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransactionBacktrackedValueToSmartRollup
          s =>
            OctezUshuaiaOperationResultInfo(
              status: OctezUshuaiaOperationResultStatus.backtracked,
              errors: s.errors,
              consumedMilligas: s.consumedMilligas,
            ),
        },
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransactionSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseOriginationResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultOrigination result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultOriginationApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
          storageSize: a.storageSize,
          paidStorageSizeDiff: a.paidStorageSizeDiff,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultOriginationFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultOriginationBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
          storageSize: b.storageSize,
          paidStorageSizeDiff: b.paidStorageSizeDiff,
        ),

      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultOriginationSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseDelegationResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultDelegation result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultDelegationApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultDelegationFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultDelegationBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultDelegationSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseRegisterGlobalConstantResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultRegisterGlobalConstant
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultRegisterGlobalConstantApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
          storageSize: a.storageSize,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultRegisterGlobalConstantFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultRegisterGlobalConstantBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
          storageSize: b.storageSize,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultRegisterGlobalConstantSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseSetDepositsLimitResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSetDepositsLimit
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSetDepositsLimitApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSetDepositsLimitFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSetDepositsLimitBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSetDepositsLimitSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseIncreasePaidStorageResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultIncreasePaidStorage
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultIncreasePaidStorageApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultIncreasePaidStorageFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultIncreasePaidStorageBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultIncreasePaidStorageSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseUpdateConsensusKeyResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultUpdateConsensusKey
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultUpdateConsensusKeyApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultUpdateConsensusKeyFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultUpdateConsensusKeyBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultUpdateConsensusKeySkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseTransferTicketResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransferTicket result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransferTicketApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
          paidStorageSizeDiff: a.paidStorageSizeDiff,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransferTicketFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransferTicketBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
          paidStorageSizeDiff: b.paidStorageSizeDiff,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransferTicketSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseDalPublishCommitmentResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultDalPublishCommitment
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultDalPublishCommitmentApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultDalPublishCommitmentFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultDalPublishCommitmentBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultDalPublishCommitmentSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseSmartRollupOriginateResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupOriginate
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupOriginateApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
          storageSize: a.size,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupOriginateFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupOriginateBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
          storageSize: b.size,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupOriginateSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseSmartRollupAddMessagesResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupAddMessages
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupAddMessagesApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupAddMessagesFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupAddMessagesBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupAddMessagesSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseSmartRollupCementResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupCement
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupCementApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupCementFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupCementBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupCementSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseSmartRollupPublishResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupPublish
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupPublishApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupPublishFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupPublishBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupPublishSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseSmartRollupRefuteResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupRefute
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupRefuteApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupRefuteFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupRefuteBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupRefuteSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseSmartRollupTimeoutResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupTimeout
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupTimeoutApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupTimeoutFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupTimeoutBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupTimeoutSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo
  _parseSmartRollupExecuteOutboxMessageResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupExecuteOutboxMessage
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupExecuteOutboxMessageApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
          paidStorageSizeDiff: a.paidStorageSizeDiff,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupExecuteOutboxMessageFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupExecuteOutboxMessageBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
          paidStorageSizeDiff: b.paidStorageSizeDiff,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupExecuteOutboxMessageSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseSmartRollupRecoverBondResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupRecoverBond
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupRecoverBondApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupRecoverBondFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupRecoverBondBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupRecoverBondSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseZkRollupOriginationResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupOrigination
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupOriginationApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
          storageSize: a.size,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupOriginationFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupOriginationBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
          storageSize: b.size,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupOriginationSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseZkRollupPublishResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupPublish result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupPublishApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupPublishFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupPublishBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupPublishSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseZkRollupUpdateResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupUpdate result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupUpdateApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupUpdateFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupUpdateBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultZkRollupUpdateSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  // ---------------------------------------------------------------------------
  // Internal result parsers
  // ---------------------------------------------------------------------------

  static OctezUshuaiaOperationResultInfo _parseInternalTransactionResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultTransaction
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultTransactionFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultTransactionApplied
      a =>
        switch (a.value) {
          final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultTransactionAppliedValueToContract
          c =>
            OctezUshuaiaOperationResultInfo(
              status: OctezUshuaiaOperationResultStatus.applied,
              consumedMilligas: c.consumedMilligas,
              storageSize: c.storageSize,
              paidStorageSizeDiff: c.paidStorageSizeDiff,
            ),
          final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultTransactionAppliedValueToSmartRollup
          s =>
            OctezUshuaiaOperationResultInfo(
              status: OctezUshuaiaOperationResultStatus.applied,
              consumedMilligas: s.consumedMilligas,
            ),
        },
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultTransactionBacktracked
      b =>
        switch (b.value) {
          final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultTransactionBacktrackedValueToContract
          c =>
            OctezUshuaiaOperationResultInfo(
              status: OctezUshuaiaOperationResultStatus.backtracked,
              errors: c.errors,
              consumedMilligas: c.consumedMilligas,
              storageSize: c.storageSize,
              paidStorageSizeDiff: c.paidStorageSizeDiff,
            ),
          final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultTransactionBacktrackedValueToSmartRollup
          s =>
            OctezUshuaiaOperationResultInfo(
              status: OctezUshuaiaOperationResultStatus.backtracked,
              errors: s.errors,
              consumedMilligas: s.consumedMilligas,
            ),
        },
      OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultTransactionSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseInternalOriginationResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultOrigination
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultOriginationApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
          storageSize: a.storageSize,
          paidStorageSizeDiff: a.paidStorageSizeDiff,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultOriginationFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultOriginationBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
          storageSize: b.storageSize,
          paidStorageSizeDiff: b.paidStorageSizeDiff,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultOriginationSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseInternalDelegationResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultDelegation
    result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultDelegationApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultDelegationFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultDelegationBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultDelegationSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }

  static OctezUshuaiaOperationResultInfo _parseInternalEventResult(
    OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultEvent result,
  ) {
    return switch (result) {
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultEventApplied
      a =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.applied,
          consumedMilligas: a.consumedMilligas,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultEventFailed
      f =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.failed,
          errors: f.errors,
        ),
      final OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultEventBacktracked
      b =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.backtracked,
          errors: b.errors,
          consumedMilligas: b.consumedMilligas,
        ),
      OctezUshuaiaN025PsUshuaiOperationAlphaInternalOperationResultEventSkipped() =>
        OctezUshuaiaOperationResultInfo(
          status: OctezUshuaiaOperationResultStatus.skipped,
        ),
    };
  }
}
