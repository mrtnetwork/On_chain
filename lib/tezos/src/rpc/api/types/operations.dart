import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/rpc/types/types/ushuaia.dart';

/// Status of an operation result (main or internal).
enum OctezUshuaiaOperationResultStatus {
  applied,
  failed,
  backtracked,
  skipped,
  unknown,
}

/// Minimal result info used for fee estimation and error checking.
class OctezUshuaiaOperationResultInfo {
  final OctezUshuaiaOperationResultStatus status;
  final List<OctezUshuaiaN025PsUshuaiError>? errors;
  final String? consumedMilligas;
  final String? storageSize;
  final String? paidStorageSizeDiff;

  const OctezUshuaiaOperationResultInfo({
    required this.status,
    this.errors,
    this.consumedMilligas,
    this.storageSize,
    this.paidStorageSizeDiff,
  });

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "errors": errors,
      "consumedMilligas": consumedMilligas,
      "storageSize": storageSize,
      "paidStorageSizeDiff": paidStorageSizeDiff,
    }.notNullValue;
  }

  bool get isApplied => status == OctezUshuaiaOperationResultStatus.applied;
  bool get isFailed => status == OctezUshuaiaOperationResultStatus.failed;
  bool get isBacktracked =>
      status == OctezUshuaiaOperationResultStatus.backtracked;
  bool get succeeded => isApplied && (errors == null || errors!.isEmpty);
  BigInt get consumedMilligasAsBigInt =>
      BigintUtils.tryParse(consumedMilligas ?? '0') ?? BigInt.zero;

  static const empty = OctezUshuaiaOperationResultInfo(
    status: OctezUshuaiaOperationResultStatus.unknown,
  );
}

/// Summary of one internal operation result (fee + errors only).
class OctezUshuaiaInternalOperationSummary {
  final String kind;
  final int? nonce;
  final OctezUshuaiaOperationResultInfo result;

  const OctezUshuaiaInternalOperationSummary({
    required this.kind,
    this.nonce,
    required this.result,
  });

  bool get succeeded => result.succeeded;
  bool get isFailed => result.isFailed;
  bool get isBacktracked => result.isBacktracked;
  BigInt get consumedMilligasAsBigInt => result.consumedMilligasAsBigInt;

  Map<String, dynamic> toJson() => {
    "kind": kind,
    "nonce": nonce,
    "result": result.toJson(),
  };
}

/// Summary of one top-level content from a run/simulate response.
///
/// Holds the full content so you can call typed getters for the original
/// operation result (getRevealResult, getTransactionResult, …).
class OctezUshuaiaRunOperationContentSummary {
  final TezosOperationKind kind;
  final OctezUshuaiaOperationResultInfo result;
  final List<OctezUshuaiaInternalOperationSummary> internalOperations;

  /// Manager operation fee / limits (when present).
  final String? fee;
  final String? gasLimit;
  final String? storageLimit;

  /// Full content object (for typed result accessors).
  final OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResult?
  content;

  Map<String, dynamic> toJson() => {
    "kind": kind.name,
    "result": result.toJson(),
    "internalOperations": internalOperations.map((e) => e.toJson()).toList(),
    "fee": fee,
    "gasLimit": gasLimit,
    "storageLimit": storageLimit,
    "content": content?.toJson(),
  };

  const OctezUshuaiaRunOperationContentSummary({
    required this.kind,
    required this.result,
    this.internalOperations = const [],
    this.fee,
    this.gasLimit,
    this.storageLimit,
    this.content,
  });

  bool get isApplied => result.isApplied;
  bool get isFailed => result.isFailed;
  bool get isBacktracked => result.isBacktracked;

  bool get succeeded =>
      result.succeeded && internalOperations.every((i) => i.succeeded);

  bool get hasErrors =>
      result.isFailed ||
      result.isBacktracked ||
      internalOperations.any((i) => i.isFailed || i.isBacktracked);

  BigInt get totalConsumedMilligas {
    var total = result.consumedMilligasAsBigInt;
    for (final internal in internalOperations) {
      total += internal.consumedMilligasAsBigInt;
    }
    return total;
  }

  BigInt get consumedMilligasAsBigInt => result.consumedMilligasAsBigInt;

  // ---- Typed full-result accessors ----------------------------------------

  OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultReveal?
  getRevealResult() {
    final c = content;
    if (c
        is OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultReveal) {
      return c.metadata.operationResult;
    }
    return null;
  }

  OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransaction?
  getTransactionResult() {
    final c = content;
    if (c
        is OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultTransaction) {
      return c.metadata.operationResult;
    }
    return null;
  }

  /// Alias for getTransactionResult (transfer).
  OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransaction?
  getTransferResult() => getTransactionResult();

  OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultOrigination?
  getOriginationResult() {
    final c = content;
    if (c
        is OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultOrigination) {
      return c.metadata.operationResult;
    }
    return null;
  }

  OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSmartRollupOriginate?
  getSmartRollupOriginationResult() {
    final c = content;
    if (c
        is OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSmartRollupOriginate) {
      return c.metadata.operationResult;
    }
    return null;
  }

  OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultDelegation?
  getDelegationResult() {
    final c = content;
    if (c
        is OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultDelegation) {
      return c.metadata.operationResult;
    }
    return null;
  }

  OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultRegisterGlobalConstant?
  getRegisterGlobalConstantResult() {
    final c = content;
    if (c
        is OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultRegisterGlobalConstant) {
      return c.metadata.operationResult;
    }
    return null;
  }

  OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultSetDepositsLimit?
  getSetDepositsLimitResult() {
    final c = content;
    if (c
        is OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultSetDepositsLimit) {
      return c.metadata.operationResult;
    }
    return null;
  }

  OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultIncreasePaidStorage?
  getIncreasePaidStorageResult() {
    final c = content;
    if (c
        is OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultIncreasePaidStorage) {
      return c.metadata.operationResult;
    }
    return null;
  }

  OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultUpdateConsensusKey?
  getUpdateConsensusKeyResult() {
    final c = content;
    if (c
        is OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultUpdateConsensusKey) {
      return c.metadata.operationResult;
    }
    return null;
  }

  OctezUshuaiaN025PsUshuaiOperationAlphaOperationResultTransferTicket?
  getTransferTicketResult() {
    final c = content;
    if (c
        is OctezUshuaiaN025PsUshuaiOperationAlphaOperationContentsAndResultTransferTicket) {
      return c.metadata.operationResult;
    }
    return null;
  }
}
