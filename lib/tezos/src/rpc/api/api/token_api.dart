import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/tezos/src/abi/src/abi.dart';
import 'package:on_chain/tezos/src/address/address.dart';
import 'package:on_chain/tezos/src/micheline/micheline.dart';
import 'package:on_chain/tezos/src/rpc/api/api/confirmation.dart';
import 'package:on_chain/tezos/src/rpc/api/api/contract_api.dart';
import 'package:on_chain/tezos/src/rpc/api/types/inject_result.dart';
import 'package:on_chain/tezos/src/rpc/methods/methods.dart';
import 'package:on_chain/tezos/src/rpc/types/types.dart';

/// Unified transaction status (wallet `WalletTransactionStatus` parity for
/// the Tezos cases).
enum TezosTxStatus {
  /// The operation is applied.
  block,

  /// The operation is refused, failed or backtracked.
  failed,

  /// The operation is still pending.
  pending,

  /// The operation status is unknown.
  unknown,
}

/// Token-level Tezos reads over [TezosContractApi] + [TezosConfirmation].
/// Consumers mix this in alongside those two (as [DefaultTezosClient]
/// does).
///
/// Error contract: reads throw on transport failure; only the documented
/// big-map fallbacks apply — absent ledger keys (404) read as zero, and
/// non-FA ledgers read as null. A missing delegate (404) reads as null.
/// Malformed data is never mistaken for absence.
mixin TezosTokenQuickApi on TezosContractApi, TezosConfirmation {
  /// Active bakers with minimal stake for the delegate picker (suggestions
  /// come from the chain's validator set, not wallet addresses). Failures
  /// propagate — the form surfaces them instead of silently offering no suggestions.
  Future<List<TezosAddress>> getActiveBakers() async {
    final bakers = await provider.request(
      const OctezUshuaiaRequestContextDelegates(
        active: 'true',
        withMinimalStake: 'true',
      ),
    );
    return [
      for (final b in bakers)
        if (b is OctezUshuaiaUnistringStringValue) TezosAddress(b.value),
    ];
  }

  /// Unstake request sets: finalizable items plus the single unfinalizable
  /// delegate with its pending requests. Null when the node reports none.
  /// Throws on RPC failure; the stake flow treats failure as unknown (no
  /// block, simulation arbitrates).
  Future<OctezUshuaiaResponseContextContractsContractIdUnstakeRequests?>
  getUnstakeRequests(TezosAddress address) {
    return provider.request(
      OctezUshuaiaRequestContextContractsContractIdUnstakeRequests(
        contractId: address.address,
      ),
    );
  }

  /// Staked (frozen) balance in mutez. Null when the account holds no
  /// staked funds. Throws on RPC failure so callers fail loudly instead
  /// of capping amounts at a wrong zero.
  Future<BigInt> getStakedBalance(TezosAddress address) async {
    final result = await provider.request(
      OctezUshuaiaRequestContextContractsContractIdStakedBalance(
        contractId: address.address,
      ),
    );
    if (result == null || result.isEmpty) return BigInt.zero;
    return BigintUtils.parse(result);
  }

  /// The baker the account delegates to, or null when no delegate is set.
  /// The node answers 404 for undelegated contracts and that maps to null
  /// here; any other failure rethrows so callers never mistake downtime
  /// for "no delegate".
  Future<TezosAddress?> getAccountDelegate(TezosAddress address) async {
    try {
      final result = await provider.request(
        OctezUshuaiaRequestContextContractsContractIdDelegate(
          contractId: address.address,
        ),
      );
      final value = switch (result) {
        OctezUshuaiaUnistringStringValue(value: final v) => v,
        _ => null,
      };
      if (value == null || value.isEmpty) return null;
      return TezosAddress(value);
    } on RPCError catch (e) {
      if (e.statusCode == 404) return null;
      rethrow;
    }
  }

  /// FA standard probe via on-chain entrypoints (TZIP-7 FA1.2 vs TZIP-12
  /// FA2). Implicit addresses short-circuit to neither (they can never host
  /// a contract). Throws on RPC failure so callers propagate instead of
  /// mistaking downtime for "not a token". `methods` carries the raw
  /// entrypoint names so tokens/NFTs persist per-contract capabilities
  /// (transfer/approve/update_operators) for UI action gating.
  Future<({bool isFa12, bool isFa2, List<String> methods})> probeFaStandards(
    TezosAddress contract,
  ) async {
    if (!contract.isContract) {
      return (isFa12: false, isFa2: false, methods: <String>[]);
    }
    final entrypoints = await getContractEntrypoints(contract);
    final names = entrypoints.keys.toSet();
    final isFa12 =
        names.contains('transfer') &&
        names.contains('approve') &&
        names.contains('getBalance');
    final isFa2 =
        names.contains('transfer') &&
        names.contains('balance_of') &&
        names.contains('update_operators');
    final methodList = names.toList()..sort();
    return (isFa12: isFa12, isFa2: isFa2, methods: methodList);
  }

  /// FA1.2 balance through the `ledger` big-map (TZIP-7): script (code +
  /// head storage in one RPC) → `bigMapKeyLookup(storage, 'ledger', owner)`
  /// → big-map value → decode. A 404 on the value read is an absent key
  /// (zero balance); anything else rethrows. Contracts without a `ledger`
  /// path fall back to the `getBalance` view. Implicit addresses read as
  /// not-FA1.2 without RPC.
  Future<BigInt?> getFa12BalanceOrNull({
    required TezosAddress contract,
    required TezosAddress owner,
  }) async {
    if (!contract.isContract) return null;
    final script = await getContractScript(contract);
    final abi = TezosContractAbi.fromCode(script.code);
    final storage = script.storage;
    try {
      final lookup = abi.bigMapKeyLookup(storage, 'ledger', owner);
      try {
        final raw = await getBigMapValue(
          bigMapId: lookup.bigMapId.toString(),
          scriptExpr: lookup.scriptExpr,
        );
        return _decodeFa12Ledger(abi, raw);
      } on RPCError catch (e) {
        // Absent ledger key reads as zero; any other failure rethrows
        // instead of leaking out of the taxonomy.
        if (e.statusCode == 404) return BigInt.zero;
        rethrow;
      }
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.tezosAbi) rethrow;
      return _fa12BalanceViaView(contract: contract, owner: owner);
    }
  }

  /// FA1.2 ledger value decode: plain nat on classic contracts, otherwise
  /// a record holding `balance` (SmartPy-style). Throws when neither
  /// shape decodes.
  BigInt _decodeFa12Ledger(TezosContractAbi abi, MichelineExpr raw) {
    try {
      return abi.decodeBigMapResult<BigInt>('ledger', raw);
    } catch (_) {
      final map = abi.decodeBigMapResult<Map<String, dynamic>>('ledger', raw);
      return map.valueAsBigInt('balance');
    }
  }

  /// Legacy `getBalance` view fallback for FA1.2 contracts without a
  /// `ledger` big-map path. View failures rethrow (the import probe already
  /// confirmed the standard, so this is RPC trouble, not a negative).
  Future<BigInt?> _fa12BalanceViaView({
    required TezosAddress contract,
    required TezosAddress owner,
  }) async {
    final result = await runScriptView(
      contract: contract,
      view: 'getBalance',
      input: MichelineUtils.address(owner),
    );
    if (result is MichelineInt) return result.value;
    return null;
  }

  /// FA1.2 `balance_of` convenience: absent keys read as zero, non-FA1.2
  /// contracts as null, other failures throw.
  Future<BigInt> getFa12Balance({
    required TezosAddress contract,
    required TezosAddress owner,
  }) async {
    return await getFa12BalanceOrNull(contract: contract, owner: owner) ??
        BigInt.zero;
  }

  /// Nullable FA2 balance read through the `ledger` big-map (TZIP-12):
  /// storage → `bigMapKeyLookup(storage, 'ledger', [owner, tokenId])` →
  /// big-map value → nat. A 404 reads as zero, non-FA2 ledgers as null,
  /// other failures throw.
  ///
  /// Single-id wrapper over [getFa2BalancesOrNull] so import probes and
  /// balance refreshes share one decode/wrapping path.
  Future<BigInt?> getFa2BalanceOrNull({
    required TezosAddress contract,
    required TezosAddress owner,
    required BigInt tokenId,
  }) async {
    final balances = await getFa2BalancesOrNull(
      contract: contract,
      owner: owner,
      tokenIds: [tokenId],
    );
    return balances[tokenId];
  }

  /// FA2 `balance_of` convenience: absent keys read as zero, non-FA2
  /// contracts as null, other failures throw.
  Future<BigInt> getFa2Balance({
    required TezosAddress contract,
    required TezosAddress owner,
    required BigInt tokenId,
  }) async {
    return await getFa2BalanceOrNull(
          contract: contract,
          owner: owner,
          tokenId: tokenId,
        ) ??
        BigInt.zero;
  }

  /// Batched FA2 balance read for one contract: one script fetch (code +
  /// head storage together), then one big-map value read per token id
  /// (1+N RPCs instead of 3N). No cross-refresh caching — the grouping
  /// lives only in this call.
  /// Per-id semantics match [getFa2BalanceOrNull]: 404 reads as zero,
  /// non-FA2 ledger reads as null, other failures throw.
  Future<Map<BigInt, BigInt?>> getFa2BalancesOrNull({
    required TezosAddress contract,
    required TezosAddress owner,
    required List<BigInt> tokenIds,
  }) async {
    final unique = tokenIds.toSet().toList();
    if (unique.isEmpty) return {};
    if (!contract.isContract) {
      return {for (final id in unique) id: null};
    }
    final script = await getContractScript(contract);
    final abi = TezosContractAbi.fromCode(script.code);
    final storage = script.storage;
    try {
      abi.bigMapKeyLookup(storage, 'ledger', [owner, unique.first]);
    } on BuError catch (e) {
      if (e.type != OnChainErrorType.tezosAbi) rethrow;
      // No FA2-shaped ledger: not an FA2 asset.
      return {for (final id in unique) id: null};
    }
    final out = <BigInt, BigInt?>{};
    for (final tokenId in unique) {
      try {
        final lookup = abi.bigMapKeyLookup(storage, 'ledger', [owner, tokenId]);
        try {
          final raw = await getBigMapValue(
            bigMapId: lookup.bigMapId.toString(),
            scriptExpr: lookup.scriptExpr,
          );
          out[tokenId] = abi.decodeBigMapResult<BigInt>('ledger', raw);
        } on RPCError catch (e) {
          // Absent ledger key reads as zero; any other failure rethrows.
          if (e.statusCode == 404) {
            out[tokenId] = BigInt.zero;
            continue;
          }
          rethrow;
        }
      } on BuError catch (e) {
        if (e.type != OnChainErrorType.tezosAbi) rethrow;
        out[tokenId] = null;
      }
    }
    return out;
  }

  /// Status of [operationHash] via confirmation polling: applied → block,
  /// refused/failed/backtracked → failed, pending → pending, unknown →
  /// unknown. Timeouts and transport failures throw.
  Future<TezosTxStatus> getTransactionStatus(String operationHash) async {
    final result = await waitForOperation(
      operationHash,
      timeout: const Duration(seconds: 20),
    );
    return switch (result.status) {
      TezosOperationStatus.applied => TezosTxStatus.block,
      TezosOperationStatus.refused ||
      TezosOperationStatus.failed ||
      TezosOperationStatus.backtracked => TezosTxStatus.failed,
      TezosOperationStatus.pending => TezosTxStatus.pending,
      TezosOperationStatus.unknown => TezosTxStatus.unknown,
    };
  }
}
