import 'dart:async';
import 'package:on_chain/tezos/src/rpc/api/api/quick_api.dart';
import 'package:on_chain/tezos/src/rpc/api/types/inject_result.dart';
import 'package:on_chain/tezos/src/rpc/api/types/operations.dart';
import 'package:on_chain/tezos/src/rpc/methods/methods.dart';
import 'package:on_chain/tezos/src/rpc/types/types.dart';
import 'package:on_chain/tezos/src/rpc/types/types/types.dart';
import 'package:on_chain/tezos/src/rpc/api/utils/extensions.dart';

mixin TezosConfirmation on TezosQuickApi {
  static const int _defaultBlockLookback = 10;

  /// Per-level retries before yielding to the outer loop (unreliable RPC).
  static const int _levelRetryCount = 3;

  /// Short backoff between in-place level retries.
  static const Duration _levelRetryBackoff = Duration(milliseconds: 200);

  /// Poll until the operation is **included in a block**, **refused**, or times out.
  ///
  /// On applied: loads the full operation JSON from that block (with `contents`
  /// + `metadata.operation_result`) so callers can read originated contracts,
  /// global_address, gas, etc. **after** success — no pre-inject simulation.
  Future<TezosConfirmationResult> waitForOperation(
    String operationHash, {
    Duration? timeout,
    Duration? interval,
    String? chain,
    String? version,
    int? blockLookback,
  }) async {
    final effectiveTimeout = config.resolveTimeout(timeout);
    final effectiveInterval = config.resolveInterval(interval);
    final effectiveChain = config.resolveChain(chain);
    final lookback = blockLookback ?? _defaultBlockLookback;
    final deadline = DateTime.now().add(effectiveTimeout);

    // Absolute level cursor. Only advances past levels whose operation_hashes
    // RPC succeeded. Failed levels are retried (in-place, then next tick).
    int? nextLevelToScan;
    var lastKnownHead = 0;

    while (DateTime.now().isBefore(deadline)) {
      // ------------------------------------------------------------------
      // Phase 1 — mempool: terminal refuse only
      // ------------------------------------------------------------------
      try {
        final pending = await provider.request(
          OctezMempoolRequestPendingOperations(
            chainId: effectiveChain,
            operationHash: operationHash,
          ),
        );
        final sighting = _classifyMempool(pending, operationHash);
        if (sighting.$1 == _MempoolSighting.terminalRefused) {
          return TezosConfirmationResult(
            operationHash: operationHash,
            status: TezosOperationStatus.refused,
            mempoolRefused: sighting.$2,
          );
        }
        // inMempool / absent: no early exit. Inclusion is decided by levels.
      } catch (_) {}

      // ------------------------------------------------------------------
      // Phase 2 — walk absolute levels [nextLevelToScan, headLevel]
      // ------------------------------------------------------------------
      var behindHead = false;
      try {
        final headLevel = await _headLevel(effectiveChain);
        lastKnownHead = headLevel;
        nextLevelToScan ??=
            headLevel <= 0 ? 1 : (headLevel - lookback + 1).clamp(1, headLevel);

        if (nextLevelToScan <= headLevel) {
          final result = await _scanLevels(
            operationHash: operationHash,
            chainId: effectiveChain,
            fromLevel: nextLevelToScan,
            toLevel: headLevel,
            deadline: deadline,
          );
          nextLevelToScan = result.nextLevel;
          behindHead = nextLevelToScan <= headLevel;

          if (result.found != null) {
            final hit = result.found!;
            final blockHash = await _blockHashForLevel(
              chainId: effectiveChain,
              level: hit.level,
              fallbackId: hit.blockId,
            );
            final contentSummaries = hit.operation.contentSummaries;
            return TezosConfirmationResult(
              operationHash: operationHash,
              status: _statusFromBlockOperation(contentSummaries),
              blockHash: blockHash,
              operations: contentSummaries,
            );
          }
        }
      } catch (_) {
        // Head failure: leave nextLevelToScan unchanged, retry later.
        behindHead =
            nextLevelToScan != null && nextLevelToScan <= lastKnownHead;
      }

      // While still catching up to head, do not sleep the full poll interval —
      // only a short pause so a flaky node is not overloaded.
      if (behindHead) {
        await Future<void>.delayed(_levelRetryBackoff);
      } else {
        await Future<void>.delayed(effectiveInterval);
      }
    }

    return TezosConfirmationResult(
      operationHash: operationHash,
      status: TezosOperationStatus.unknown,
      operations: const [],
    );
  }

  // ---------------------------------------------------------------------------
  // Level-based scan
  // ---------------------------------------------------------------------------

  /// Inclusive scan of `[fromLevel, toLevel]` using numeric block ids (`"$level"`).
  ///
  /// Each level is attempted up to [_levelRetryCount] times with short backoff
  /// before giving up for this pass (cursor stays on that level).
  Future<({_BlockHit? found, int nextLevel})> _scanLevels({
    required String operationHash,
    required String chainId,
    required int fromLevel,
    required int toLevel,
    required DateTime deadline,
  }) async {
    var cursor = fromLevel;
    for (var level = fromLevel; level <= toLevel; level++) {
      if (!DateTime.now().isBefore(deadline)) {
        return (found: null, nextLevel: level);
      }

      final blockId = '$level';
      final hashes = await _operationHashesWithRetry(
        chainId: chainId,
        blockId: blockId,
      );
      if (hashes == null) {
        // Exhausted retries for this level — outer loop will try again soon.
        return (found: null, nextLevel: level);
      }

      final lp = _findOperation(hashes, operationHash);
      if (lp != null) {
        final operation = await _operationContentsWithRetry(
          chainId: chainId,
          blockId: blockId,
          listOffset: lp.offset,
          operationOffset: lp.position,
        );
        if (operation == null) {
          // Found the hash but failed to load contents — retry this level.
          return (found: null, nextLevel: level);
        }
        return (
          found: _BlockHit(
            level: level,
            blockId: blockId,
            operation: operation,
          ),
          nextLevel: level + 1,
        );
      }
      cursor = level + 1;
    }
    return (found: null, nextLevel: cursor);
  }

  Future<List<List<OctezUshuaiaOperationHash>>?> _operationHashesWithRetry({
    required String chainId,
    required String blockId,
  }) async {
    for (var attempt = 0; attempt < _levelRetryCount; attempt++) {
      try {
        return await provider.request(
          OctezUshuaiaRequestOperationHashes(
            chainId: chainId,
            blockId: blockId,
          ),
        );
      } catch (e) {
        if (attempt + 1 < _levelRetryCount) {
          await Future<void>.delayed(_levelRetryBackoff);
        }
      }
    }
    return null;
  }

  Future<OctezUshuaiaOperationProtocolChainIdHashBranchAndContents?>
  _operationContentsWithRetry({
    required String chainId,
    required String blockId,
    required int listOffset,
    required int operationOffset,
  }) async {
    for (var attempt = 0; attempt < _levelRetryCount; attempt++) {
      try {
        return await provider.request(
          OctezUshuaiaRequestOperationsContentsListOffsetOperationOffset(
            listOffset: listOffset,
            version: config.version,
            blockId: blockId,
            metadata: 'always',
            operationOffset: operationOffset,
          ),
        );
      } catch (e) {
        if (attempt + 1 < _levelRetryCount) {
          await Future<void>.delayed(_levelRetryBackoff);
        }
      }
    }
    return null;
  }

  /// Current head **level** (stable integer). Prefer header RPC over `head~N`.
  Future<int> _headLevel(String chainId) async {
    final header = await provider.request(
      OctezUshuaiaRequestHeader(chainId: chainId, blockId: 'head'),
    );
    return header.level;
  }

  Future<String> _blockHashForLevel({
    required String chainId,
    required int level,
    required String fallbackId,
  }) async {
    try {
      final header = await provider.request(
        OctezUshuaiaRequestHeader(chainId: chainId, blockId: '$level'),
      );
      return header.hash.asBlockHash();
    } catch (_) {
      try {
        return await getBranchHash();
      } catch (_) {
        return fallbackId;
      }
    }
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  TezosOperationStatus _statusFromBlockOperation(
    List<OctezUshuaiaRunOperationContentSummary> operations,
  ) {
    if (operations.isEmpty) return TezosOperationStatus.unknown;
    if (operations.every((e) => e.isApplied)) {
      return TezosOperationStatus.applied;
    }
    if (operations.any((e) => e.isBacktracked)) {
      return TezosOperationStatus.backtracked;
    }
    return TezosOperationStatus.failed;
  }

  /// Block ops JSON is `List<List<operation>>`.
  ({int offset, int position})? _findOperation(
    List<List<OctezUshuaiaOperationHash>> operations,
    String opHash,
  ) {
    for (final operation in operations.indexed) {
      for (final op in operation.$2.indexed) {
        final hash = op.$2.asOperationHash();
        if (hash == opHash) return (position: op.$1, offset: operation.$1);
      }
    }
    return null;
  }

  (_MempoolSighting, OctezMempoolResponsePendingOperationsRefusedItem?)
  _classifyMempool(
    OctezMempoolResponsePendingOperations pending,
    String opHash,
  ) {
    final refused = pending.operationRefused(opHash);
    if (refused != null) {
      return (_MempoolSighting.terminalRefused, refused);
    }
    if (pending.inMempool(opHash)) {
      return (_MempoolSighting.inMempool, null);
    }
    return (_MempoolSighting.absent, null);
  }
}

enum _MempoolSighting { terminalRefused, inMempool, absent }

class _BlockHit {
  final int level;
  final String blockId;
  final OctezUshuaiaOperationProtocolChainIdHashBranchAndContents operation;

  const _BlockHit({
    required this.level,
    required this.blockId,
    required this.operation,
  });
}
