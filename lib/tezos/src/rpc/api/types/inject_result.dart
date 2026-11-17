import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/operations/operations/group.dart';
import 'package:on_chain/tezos/src/rpc/api/types/operations.dart';
import 'package:on_chain/tezos/src/rpc/types/types/mempool.dart';

enum TezosOperationStatus {
  /// Seen in mempool (not yet in a block).
  pending,

  /// Included and applied in a block.
  applied,

  /// Found but refused / branch refused / outdated.
  refused,

  /// Included in a block but operation_result status is failed.
  failed,

  /// Included but backtracked (e.g. sibling in batch failed).
  backtracked,

  /// Timed out without a clear outcome.
  unknown,
}

class TezosConfirmationResult {
  final String operationHash;
  final TezosOperationStatus status;
  final String? blockHash;
  final OctezMempoolResponsePendingOperationsRefusedItem? mempoolRefused;
  final List<OctezUshuaiaRunOperationContentSummary>? operations;

  const TezosConfirmationResult({
    required this.operationHash,
    required this.status,
    this.blockHash,
    this.operations,
    this.mempoolRefused,
  });

  bool get isApplied => status == TezosOperationStatus.applied;

  Map<String, dynamic> toJson() {
    return {
      'operationHash': operationHash,
      'status': status.name,
      'blockHash': blockHash,
      'refused': mempoolRefused?.toJson(),
    }.notNullValue;
  }
}

class TezosInjected {
  final String operationHash;
  final TezosOperationGroup signedGroup;

  const TezosInjected({required this.operationHash, required this.signedGroup});

  Map<String, dynamic> toJson() => {
    'operationHash': operationHash,
    'group': signedGroup.toJson(),
  };
}

class TezosInjectResult<T> {
  final TezosInjected injected;
  final TezosConfirmationResult confirmation;
  final T? result;

  const TezosInjectResult({
    required this.injected,
    required this.confirmation,
    this.result,
  });

  bool get isApplied => confirmation.isApplied;

  Map<String, dynamic> toJson() => {
    'injected': injected.toJson(),
    'confirmation': confirmation.toJson(),
    'isApplied': isApplied,
    'result': result,
  };

  OctezUshuaiaRunOperationContentSummary? getOperationSummary(
    TezosOperationKind operation,
  ) {
    return confirmation.operations?.firstWhereNullable(
      (e) => e.kind == operation,
    );
  }

  TezosInjectResult<E> mapResult<E>({E? result}) {
    return TezosInjectResult<E>(
      injected: injected,
      confirmation: confirmation,
      result: result,
    );
  }
}
