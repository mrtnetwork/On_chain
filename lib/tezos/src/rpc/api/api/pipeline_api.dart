import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/operations/operations/group.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/rpc/api/api/confirmation.dart';
import 'package:on_chain/tezos/src/rpc/api/api/fee_estimator.dart';
import 'package:on_chain/tezos/src/rpc/api/api/quick_api.dart';
import 'package:on_chain/tezos/src/rpc/api/types/account.dart';
import 'package:on_chain/tezos/src/rpc/api/types/estimated_fee.dart';
import 'package:on_chain/tezos/src/rpc/api/types/inject_result.dart';

import 'package:on_chain/tezos/src/rpc/api/types/source.dart';

mixin TezosPipelineApi on TezosQuickApi, TezosConfirmation {
  /// Simulate [contents] and return the same ops with fee/gas/storage filled.
  /// Pass [limits] (fetched once per transaction) to skip the extra constants
  /// round-trip; otherwise they are fetched here.
  Future<EstimatedFeeWithSimulate> estimate(
    List<TezosOperationContent> contents, {
    String? branch,
    String? chainId,
    String? chain,
    TezosAccountState? accountState,
    TezosNetworkLimits? limits,
  }) async {
    if (contents.isEmpty) {
      throw OnChainErrors.tezosPlugin(
        'estimate',
        reason: 'Contents must not be empty.',
      );
    }
    final managerOperations =
        contents.whereType<TezosManagerOperationContent>().toList();
    if (managerOperations.isEmpty) {
      return EstimatedFeeWithSimulate(
        operations: contents,
        limits: List.filled(contents.length, EstimatedLimits.zero()),
      );
    }

    chainId = config.resolveChainId(chainId);
    final resolvedBranch = branch ?? await getBranchHash();
    // temporary counters for simulation only
    accountState ??= await getAccountState(managerOperations.first.source);
    BigInt counter = accountState.counter;
    List<TezosOperationContent> simOps =
        contents
            .map(
              (e) => e.fold(
                onManagerContent: (content) {
                  counter += BigInt.one;
                  return content.copyWith(counter: counter);
                },
              ),
            )
            .toList();
    final feeApi = TezosFeeEstimator(this);
    final networkLimits = limits ?? await feeApi.networkLimits();
    final group = feeApi.prepareGroupForSimulation(
      TezosOperationGroup(branch: resolvedBranch, contents: simOps),
      limits: networkLimits,
    );

    final resolvedChainId = chainId ?? await getChainId(chain: chain);

    // Always simulate — never fall back to static silently for production sends.
    final estimatedLimits = await feeApi.estimateWithSimulation(
      group: group,
      chainId: resolvedChainId,
      throwOnSimulationError: true,
      limits: networkLimits,
      originalContents: contents,
    );
    List<TezosOperationContent> operations =
        contents.indexed
            .map(
              (i) => i.$2.fold(
                onManagerContent: (content) {
                  final limit = estimatedLimits[i.$1];
                  return content.copyWith(
                    fee: limit.fee,
                    gasLimit: limit.gasLimit,
                    storageLimit: limit.storageLimit,
                  );
                },
              ),
            )
            .toList();

    return EstimatedFeeWithSimulate(
      operations: operations,
      limits: estimatedLimits,
    );
  }

  /// Fill counters, auto-reveal, and estimate fees where still zero.
  ///
  /// Returns a list ready for [injectOperations].
  Future<List<TezosOperationContent>> fill({
    required List<TezosOperationContent> contents,
    required TezosOperationSource source,
    String? branch,
    String? chainId,
    String? chain,
    bool autoReveal = true,
  }) async {
    if (contents.isEmpty) {
      throw OnChainErrors.tezosPlugin(
        'fill',
        reason: 'Contents must not be empty.',
      );
    }
    final state = await getAccountState(source.address);
    List<TezosOperationContent> ops = contents.clone();
    if (state.needsReveal &&
        autoReveal &&
        !ops.any((e) => e.type == TezosOperationKind.reveal)) {
      final reveal = await source.getReveal();
      ops = [reveal, ...ops];
    }

    // Estimate only ops that still have zero fee (or all if any zero gas)
    final needsEstimate = ops.any((o) {
      if (o case TezosManagerOperationContent()
          when o.fee == BigInt.zero || o.gasLimit == BigInt.zero) {
        return true;
      }
      return false;
    });
    if (needsEstimate) {
      final estimated = await estimate(
        ops,
        branch: branch,
        chainId: chainId,
        chain: chain,
        accountState: state,
      );
      ops = estimated.operations;
    }

    // Assign sequential counters from account state
    BigInt counter = state.counter;
    return ops
        .map(
          (e) => e.fold(
            onManagerContent: (content) {
              counter += BigInt.one;
              return content.copyWith(counter: counter);
            },
          ),
        )
        .toList();
  }

  /// Forge → sign → inject. Returns hash + group only (no wait, no applied result).
  Future<TezosInjectResult> injectOperations({
    required List<TezosOperationContent> contents,
    required TezosOperationSource source,
    String? branch,
    String? chainId,
    String? chain,
    Duration? timeout,
    Duration? interval,
    bool wait = true,
  }) async {
    if (contents.isEmpty) {
      throw OnChainErrors.tezosPlugin(
        'injectOperations',
        reason: 'Contents must not be empty.',
      );
    }
    final resolvedBranch = branch ?? await getBranchHash();
    final filled = await fill(
      contents: contents,
      source: source,
      branch: resolvedBranch,
      chainId: chainId,
      chain: chain,
    );

    TezosOperationGroup group = TezosOperationGroup(
      branch: resolvedBranch,
      contents: filled,
    );
    final signer = await source.getSigner();
    group = await signer.signOperation(group);
    final opHash = await injectOperation(group.serializeBytes(), chain: chain);
    final injected = TezosInjected(operationHash: opHash, signedGroup: group);
    if (wait) {
      final confirmation = await waitForOperation(
        opHash,
        timeout: timeout,
        interval: interval,
        chain: chain,
      );
      return TezosInjectResult(injected: injected, confirmation: confirmation);
    }
    return TezosInjectResult(
      injected: injected,
      confirmation: TezosConfirmationResult(
        operationHash: injected.operationHash,
        status: TezosOperationStatus.unknown,
      ),
    );
  }
}
