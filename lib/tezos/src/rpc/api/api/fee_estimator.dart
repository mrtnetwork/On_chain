import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/crypto/types/signature.dart';
import 'package:on_chain/tezos/src/operations/operations/group.dart';
import 'package:on_chain/tezos/src/operations/operations/content.dart';
import 'package:on_chain/tezos/src/rpc/api/api/quick_api.dart';
import 'package:on_chain/tezos/src/rpc/api/types/estimated_fee.dart';
import 'package:on_chain/tezos/src/rpc/api/types/operations.dart';
import 'package:on_chain/tezos/src/rpc/api/utils/extensions.dart';
import 'package:on_chain/tezos/src/rpc/types/types/ushuaia.dart';

class _TezosFeeDefaults {
  static BigInt get minimalFees => BigInt.from(100);
  static BigInt get minimalNanotezPerByte => BigInt.from(1000);
  static BigInt get minimalNanotezPerGasUnit => BigInt.from(100);

  static BigInt get defaultTransferGas => BigInt.from(15000);
  static BigInt get defaultRevealGas => BigInt.from(5000);
  static BigInt get defaultTransferStorage => BigInt.from(300);
  static BigInt get defaultOriginationGas => BigInt.from(900000);

  static BigInt get gasSafetyMargin => BigInt.from(400);
  static BigInt get storageSafetyMargin => BigInt.from(300);

  static BigInt get simulationStorageBudget => BigInt.from(60000);

  /// Hard limit per single operation (do NOT exceed this on one op).
  static BigInt get hardGasLimitPerOperation => BigInt.from(1_040_000);

  /// Hard limit per block (~1,386,666). We leave a small margin.
  static BigInt get hardGasLimitPerBlock => BigInt.from(1_300_000);

  static BigInt get simulationFee => BigInt.zero;
}

class TezosNetworkLimits {
  final BigInt hardGasLimitPerOperation;
  final BigInt hardGasLimitPerBlock;
  final BigInt hardStorageLimitPerOperation;
  final BigInt costPerByte;

  const TezosNetworkLimits({
    required this.hardGasLimitPerOperation,
    required this.hardGasLimitPerBlock,
    required this.hardStorageLimitPerOperation,
    required this.costPerByte,
  });

  factory TezosNetworkLimits.defaults() => TezosNetworkLimits(
    hardGasLimitPerOperation: _TezosFeeDefaults.hardGasLimitPerOperation,
    hardGasLimitPerBlock: _TezosFeeDefaults.hardGasLimitPerBlock,
    hardStorageLimitPerOperation: _TezosFeeDefaults.simulationStorageBudget,
    costPerByte: BigInt.from(250),
  );

  static BigInt _positive(String? value, BigInt fallback) {
    final parsed = BigintUtils.tryParse(value ?? '');
    if (parsed == null || parsed <= BigInt.zero) return fallback;
    return parsed;
  }

  factory TezosNetworkLimits.fromConstants(
    OctezUshuaiaResponseContextConstants constants,
  ) {
    final fallback = TezosNetworkLimits.defaults();
    return TezosNetworkLimits(
      hardGasLimitPerOperation: _positive(
        constants.hardGasLimitPerOperation,
        fallback.hardGasLimitPerOperation,
      ),
      hardGasLimitPerBlock: _positive(
        constants.hardGasLimitPerBlock,
        fallback.hardGasLimitPerBlock,
      ),
      hardStorageLimitPerOperation: _positive(
        constants.hardStorageLimitPerOperation,
        fallback.hardStorageLimitPerOperation,
      ),
      costPerByte: _positive(constants.costPerByte, fallback.costPerByte),
    );
  }

  /// Simulation storage budget, capped by the network storage hard limit.
  BigInt get simulationStorageBudget {
    const cap = 60000;
    final capBig = BigInt.from(cap);
    if (hardStorageLimitPerOperation < capBig) {
      return hardStorageLimitPerOperation;
    }
    return capBig;
  }

  /// Per-op simulation gas for a batch of [count]: never above the op hard
  /// limit, and the batch sum never exceeds the block budget.
  BigInt simulationGasPerOp(int count) {
    final n = count <= 0 ? 1 : count;
    var perOp = hardGasLimitPerBlock ~/ BigInt.from(n);
    if (perOp > hardGasLimitPerOperation) {
      perOp = hardGasLimitPerOperation;
    }
    if (perOp <= BigInt.zero) {
      perOp = hardGasLimitPerOperation;
    }
    return perOp;
  }
}

/// Per-content simulation outcome used by the fee estimator.

/// Parses gas/storage/errors from typed run_operation responses via the
/// [OctezUshuaiaRunOperationUsefulData] extension.
class TezosSimulationParser {
  static BigInt milligasToUnits(BigInt milligas) {
    if (milligas <= BigInt.zero) return BigInt.zero;
    return (milligas + BigInt.from(999)) ~/ BigInt.from(1000);
  }

  static BigInt _parsePositive(String? value) {
    if (value == null || value.isEmpty) return BigInt.zero;
    return BigintUtils.tryParse(value) ?? BigInt.zero;
  }

  static String? _formatErrors(List<OctezUshuaiaN025PsUshuaiError>? errors) {
    if (errors == null || errors.isEmpty) return null;
    return errors.map((e) => e.toString()).join('; ');
  }

  static TezosSimulatedContent fromContentSummary(
    OctezUshuaiaRunOperationContentSummary summary,
  ) {
    final gasUnits = milligasToUnits(summary.totalConsumedMilligas);

    var storage = _parsePositive(summary.result.paidStorageSizeDiff);
    for (final internal in summary.internalOperations) {
      storage += _parsePositive(internal.result.paidStorageSizeDiff);
    }

    String? error;
    if (summary.hasErrors) {
      final parts = <String>[];
      if (summary.result.isFailed || summary.result.isBacktracked) {
        parts.add(
          _formatErrors(summary.result.errors) ??
              'content status=${summary.result.status.name}',
        );
      }
      for (final internal in summary.internalOperations) {
        if (internal.isFailed || internal.isBacktracked) {
          parts.add(
            _formatErrors(internal.result.errors) ??
                'internal ${internal.kind}'
                    '${internal.nonce != null ? ' #${internal.nonce}' : ''}'
                    ' status=${internal.result.status.name}',
          );
        }
      }
      error = parts.isEmpty ? 'simulation failed' : parts.join(' | ');
    }

    return TezosSimulatedContent(
      gasUnits: gasUnits,
      storage: storage,
      error: error,
      kind: summary.kind,
      succeeded: summary.succeeded,
    );
  }

  static List<TezosSimulatedContent> parseRunOperation(
    OctezUshuaiaResponseHelpersScriptsRunOperation result,
  ) {
    return switch (result) {
      OctezUshuaiaResponseHelpersScriptsRunOperationOperationWithMetadata() =>
        result.contentSummaries.map(fromContentSummary).toList(),
      OctezUshuaiaResponseHelpersScriptsRunOperationOperationWithoutMetadata() =>
        const [],
    };
  }
}

/// Standalone fee/gas estimator (not a client mixin).
class TezosFeeEstimator {
  final TezosQuickApi api;
  const TezosFeeEstimator(this.api);

  /// Tezos RPC network limits. One extra GET per estimate; falls back to
  /// mainnet defaults per field so offline nodes never break estimation.
  ///
  Future<TezosNetworkLimits> networkLimits() async {
    try {
      final constants = await api.getConstants();
      return TezosNetworkLimits.fromConstants(constants);
    } catch (_) {
      return TezosNetworkLimits.defaults();
    }
  }

  /// Octez fee formula (mutez):
  ///   minimal_fees + ⌈(nanotez_per_byte × size + nanotez_per_gas × gas) / 1000⌉
  static BigInt computeFee({
    required int sizeBytes,
    required BigInt gasLimit,
    int marginPercent = 20, // safety for encoding / sig size
  }) {
    final mf = _TezosFeeDefaults.minimalFees;
    final npb = _TezosFeeDefaults.minimalNanotezPerByte;
    final npg = _TezosFeeDefaults.minimalNanotezPerGasUnit;
    final variable = npb * BigInt.from(sizeBytes) + npg * gasLimit;
    final base = mf + (variable + BigInt.from(999)) ~/ BigInt.from(1000);
    final margin = (base * BigInt.from(marginPercent)) ~/ BigInt.from(100);
    return base + margin;
  }

  // ---------------------------------------------------------------------------
  // 1) Static estimate — NEVER calls the node, NEVER fails
  // ---------------------------------------------------------------------------

  /// Pure local heuristic. No RPC. Always returns values.
  ///
  /// Use when:
  /// - offline / no node
  /// - simulation is unavailable
  /// - you only need a safe upper bound for simple transfers/reveals
  ///
  /// Trade-off: gas/storage are **not** accurate for contract calls.
  /// Fee may be higher than necessary (or slightly low for huge contracts).
  List<EstimatedLimits> estimateStatic(
    List<TezosOperationContent> contents, {
    int forgedSizeHint = 200,
  }) {
    final n = contents.isEmpty ? 1 : contents.length;
    final perOpSize = (forgedSizeHint / n).ceil().clamp(64, 500).toInt();
    return [
      for (final c in contents)
        if (c case TezosManagerOperationContent())
          EstimatedLimits(
            fee: computeFee(sizeBytes: perOpSize, gasLimit: _staticGasFor(c)),
            gasLimit: _staticGasFor(c),
            storageLimit: _staticStorageFor(c),
          )
        else
          EstimatedLimits.zero(),
    ];
  }

  BigInt _staticStorageFor(TezosManagerOperationContent c) {
    if (c.storageLimit > BigInt.zero) return c.storageLimit;
    if (c is TezosOriginationOperation) return BigInt.from(2000);
    if (c is TezosTransactionOperation) {
      return _TezosFeeDefaults.defaultTransferStorage;
    }
    return BigInt.zero;
  }

  BigInt _staticGasFor(TezosManagerOperationContent c) {
    if (c is TezosRevealOperation) return _TezosFeeDefaults.defaultRevealGas;
    if (c is TezosOriginationOperation) {
      return _TezosFeeDefaults.defaultOriginationGas;
    }
    if (c.gasLimit > BigInt.zero) return c.gasLimit;
    return _TezosFeeDefaults.defaultTransferGas;
  }

  // ---------------------------------------------------------------------------
  // 2) Simulated estimate — requires HIGH gas_limit on the request
  // ---------------------------------------------------------------------------

  /// Clone [group] with simulation budgets so `run_operation` does not fail
  /// with `insufficient_gas_for_manager` / `gas_exhausted.operation`.
  ///
  /// Critical rule of Tezos simulation:
  ///   The gas_limit **in the request body** is the budget the node uses to
  ///   *run* the simulation. Too low rejects the call; too high (above the
  ///   network hard limits) fails with `gas_limit_too_high`.
  ///
  /// So budgets derive from [limits] (RPC node truth, mainnet fallback):
  ///   fee          = 0
  ///   gas_limit    = block budget ÷ batch size, capped at the op hard limit
  ///   storage_limit= network-capped simulation budget
  /// Then we read the *real* consumption from the response and refine.
  TezosOperationGroup prepareGroupForSimulation(
    TezosOperationGroup group, {
    TezosNetworkLimits? limits,
  }) {
    final resolved = limits ?? TezosNetworkLimits.defaults();
    final n = group.contents.length;
    if (n == 0) return group;

    // CRITICAL: sum of all gas_limits in batch must be <= block limit.
    // Divide block gas budget evenly across operations.
    final perOpGas = resolved.simulationGasPerOp(n);

    final prepared =
        group.contents
            .map(
              (e) => e.fold(
                onManagerContent:
                    (content) => content.copyWith(
                      fee: _TezosFeeDefaults.simulationFee,
                      gasLimit: perOpGas,
                      storageLimit: resolved.simulationStorageBudget,
                    ),
              ),
            )
            .toList();
    return group.copyWith(contents: prepared);
  }

  /// Simulate with `run_operation`, then derive per-content fee / gas / storage.
  ///
  /// Flow:
  /// 1. Rewrite contents with a large gas/storage budget (see
  ///    [prepareGroupForSimulation]).
  /// 2. POST run_operation.
  /// 3. Parse consumed milligas / paid storage via the typed extension.
  /// 4. Apply safety margins and compute the baker fee.
  ///
  Future<List<EstimatedLimits>> estimateWithSimulation({
    required TezosOperationGroup group,
    required String chainId,
    bool throwOnSimulationError = true,
    TezosNetworkLimits? limits,
    // Fallbacks below must read
    // the caller's limits, never the prepared simulation budgets — otherwise
    // the 60k simulation storage leaks into the final limits (15M burn).
    List<TezosOperationContent>? originalContents,
  }) async {
    final resolvedLimits = limits ?? await networkLimits();
    final simGroup = prepareGroupForSimulation(group, limits: resolvedLimits);
    final int preSimSizeHint = group.simulateSize();
    final body = {
      'operation': {
        ...simGroup.toJson(),
        'signature': TezosGenericSignature.dummy().encode(),
      },
      'chain_id': chainId,
    };

    final rawResult = await api.runOperation(body);
    final parsed = TezosSimulationParser.parseRunOperation(rawResult);
    if (parsed.isEmpty) {
      return estimateStatic(
        originalContents ?? group.contents,
        forgedSizeHint: preSimSizeHint,
      );
    }

    // --- Pass 1: derive gas & storage per content (size-independent) ---
    // Fallback reference is always the ORIGINAL content, never the prepared
    // simulation budgets.
    TezosManagerOperationContent? originalAt(int i) {
      final originals = originalContents;
      if (originals == null || i >= originals.length) return null;
      final content = originals[i];
      if (content case TezosManagerOperationContent manager) return manager;
      return null;
    }

    final gasAndStorage = <({BigInt gas, BigInt storage})>[];
    for (var i = 0; i < parsed.length; i++) {
      final p = parsed[i];
      final op = group.contents[i];
      if (op case TezosManagerOperationContent()) {
        if (p.error != null && throwOnSimulationError) {
          throw RPCError(message: p.error!);
        }

        final ref = originalAt(i);
        var gas = p.gasUnits;
        if (gas <= BigInt.zero) {
          gas = _staticGasFor(ref ?? op);
        } else {
          gas += _TezosFeeDefaults.gasSafetyMargin;
        }

        var storage = p.storage;
        if (storage > BigInt.zero) {
          storage += _TezosFeeDefaults.storageSafetyMargin;
        } else {
          final preset = ref?.storageLimit ?? BigInt.zero;
          if (preset > BigInt.zero) storage = preset;
        }
        if (op is TezosTransactionOperation &&
            storage < _TezosFeeDefaults.defaultTransferStorage) {
          storage = _TezosFeeDefaults.defaultTransferStorage;
        }
        if (op is TezosOriginationOperation && storage < BigInt.from(1000)) {
          storage = BigInt.from(2000);
        }
        if (op is TezosRegisterGlobalConstantOperation &&
            storage < BigInt.from(100)) {
          storage = BigInt.from(500);
        }
        if (gas > resolvedLimits.hardGasLimitPerOperation) {
          gas = resolvedLimits.hardGasLimitPerOperation;
        }

        gasAndStorage.add((gas: gas, storage: storage));
      } else {
        gasAndStorage.add((gas: BigInt.zero, storage: BigInt.zero));
      }
    }

    // --- Pass 2: reforge locally with the REAL gas/storage/counter already
    // applied (fee still 0 here — its own contribution to size is tiny and
    // covered by the margin) to get the TRUE byte size, then price off that. ---
    final resized =
        group.contents.indexed
            .map(
              (e) => e.$2.fold(
                onManagerContent:
                    (content) => content.copyWith(
                      gasLimit: gasAndStorage[e.$1].gas,
                      storageLimit: gasAndStorage[e.$1].storage,
                    ),
              ),
            )
            .toList();
    final trueSize = group.copyWith(contents: resized).simulateSize();
    final perOpSize = (trueSize / gasAndStorage.length).ceil();

    final out = <EstimatedLimits>[];
    for (var i = 0; i < gasAndStorage.length; i++) {
      final op = group.contents[i];
      op.fold(
        onManagerContent: (c) {
          out.add(
            EstimatedLimits(
              fee: computeFee(
                sizeBytes: perOpSize,
                gasLimit: gasAndStorage[i].gas,
              ),
              gasLimit: gasAndStorage[i].gas,
              storageLimit: gasAndStorage[i].storage,
            ),
          );
          return c;
        },
        onContent: (c) {
          out.add(EstimatedLimits.zero());
          return c;
        },
      );
    }

    while (out.length < group.contents.length) {
      out.addAll(estimateStatic([group.contents[out.length]]));
    }
    return out;
  }

  /// Same as [estimateWithSimulation] with optional receipt from raw response.
  Future<TezosEstimateOutcome> estimateWithSimulationDetailed({
    required TezosOperationGroup group,
    required String chainId,
    bool throwOnSimulationError = true,
  }) async {
    final limits = await estimateWithSimulation(
      group: group,
      chainId: chainId,
      throwOnSimulationError: throwOnSimulationError,
    );
    return TezosEstimateOutcome(limits: limits);
  }

  /// Two-pass: simulate → optional re-forge with real size → tighter fee.
  Future<List<EstimatedLimits>> estimateFully({
    required TezosOperationGroup group,
    required String chainId,
    required String dummySignature,
    bool throwOnSimulationError = true,
    bool fallbackToStaticOnGasError = true,
    Future<int> Function(TezosOperationGroup withLimits)? reforgeWithLimits,
  }) async {
    final first = await estimateWithSimulation(
      group: group,
      chainId: chainId,
      throwOnSimulationError: throwOnSimulationError,
    );

    if (reforgeWithLimits == null) return first;

    final updated = <TezosOperationContent>[];
    for (var i = 0; i < group.contents.length; i++) {
      final content = group.contents[i];
      final limits = first[i];
      if (content case TezosManagerOperationContent()) {
        updated.add(
          content.copyWith(
            fee: limits.fee,
            gasLimit: limits.gasLimit,
            storageLimit: limits.storageLimit,
          ),
        );
      } else {
        updated.add(content);
      }
    }
    final sizedGroup = group.copyWith(contents: updated);
    final forgedSize = await reforgeWithLimits(sizedGroup);
    final perOpSize =
        first.isEmpty
            ? 64
            : forgedSize < 64
            ? 64
            : (forgedSize / first.length).ceil().clamp(64, forgedSize).toInt();

    return [
      for (final limits in first)
        EstimatedLimits(
          fee: computeFee(sizeBytes: perOpSize, gasLimit: limits.gasLimit),
          gasLimit: limits.gasLimit,
          storageLimit: limits.storageLimit,
        ),
    ];
  }
}
