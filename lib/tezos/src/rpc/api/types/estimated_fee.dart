import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/rpc/api/types/operations.dart';

/// Result of [estimate]: ops with fee/gas set + optional simulation payload.
class EstimatedFeeWithSimulate {
  /// Operations with [fee], [gasLimit], [storageLimit] filled from simulation
  /// (or static defaults).
  final List<TezosOperationContent> operations;

  /// Per-op limits used to build [operations].
  final List<EstimatedLimits> limits;

  /// Typed run_operation summaries when simulation ran.
  final List<OctezUshuaiaRunOperationContentSummary> summaries;

  const EstimatedFeeWithSimulate({
    required this.operations,
    required this.limits,
    this.summaries = const [],
  });

  TezosEstimateOutcome get outcome =>
      TezosEstimateOutcome(limits: limits, summaries: summaries);
}

class EstimatedLimits {
  final BigInt fee;
  final BigInt gasLimit;
  final BigInt storageLimit;

  const EstimatedLimits({
    required this.fee,
    required this.gasLimit,
    required this.storageLimit,
  });
  factory EstimatedLimits.zero() => EstimatedLimits(
    fee: BigInt.zero,
    gasLimit: BigInt.zero,
    storageLimit: BigInt.zero,
  );

  @override
  String toString() =>
      'EstimatedLimits(fee=$fee, gas=$gasLimit, storage=$storageLimit)';
}

class TezosSimulatedContent {
  final BigInt gasUnits;
  final BigInt storage;
  final String? error;
  final TezosOperationKind kind;
  final bool succeeded;

  const TezosSimulatedContent({
    required this.gasUnits,
    required this.storage,
    this.error,
    required this.kind,
    required this.succeeded,
  });
}

/// Limits + typed simulation summaries for [TezosInjectResult].
class TezosEstimateOutcome {
  final List<EstimatedLimits> limits;
  final List<OctezUshuaiaRunOperationContentSummary> summaries;

  const TezosEstimateOutcome({required this.limits, this.summaries = const []});
}
