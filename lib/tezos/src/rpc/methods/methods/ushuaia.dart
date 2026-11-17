// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unnecessary_cast

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/rpc/core/core.dart';
import 'package:on_chain/tezos/src/rpc/types/types.dart';

/// GET /chains/{chain_id}/blocks/{block_id}/
class OctezUshuaiaRequestRoot
    extends
        OctezUshuaiaRequest<OctezUshuaiaResponseRoot, Map<String, dynamic>> {
  final String version;
  final String? forceMetadata;
  final String? metadata;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestRoot({
    required this.version,
    this.forceMetadata,
    this.metadata,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'version': version,
    'force_metadata': forceMetadata,
    'metadata': metadata,
  };

  @override
  OctezUshuaiaResponseRoot onResponse(Map<String, dynamic> result) {
    return OctezUshuaiaResponseRoot.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/adaptive_issuance_launch_cycle
class OctezUshuaiaRequestContextAdaptiveIssuanceLaunchCycle
    extends OctezUshuaiaRequest<int?, int?> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextAdaptiveIssuanceLaunchCycle({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/adaptive_issuance_launch_cycle';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int? onResponse(int? result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/big_maps/{big_map_id}
class OctezUshuaiaRequestContextBigMapsBigMapId
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression>,
          List<dynamic>
        > {
  final String bigMapId;
  final String? offset;
  final String? length;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextBigMapsBigMapId({
    required this.bigMapId,
    this.offset,
    this.length,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/big_maps/$bigMapId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'offset': offset,
    'length': length,
  };

  @override
  List<OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) =>
              OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression.fromJson(e),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/big_maps/{big_map_id}/{script_expr}
class OctezUshuaiaRequestContextBigMapsBigMapIdScriptExpr
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression,
          dynamic
        > {
  final String bigMapId;
  final String scriptExpr;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextBigMapsBigMapIdScriptExpr({
    required this.bigMapId,
    required this.scriptExpr,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/big_maps/$bigMapId/$scriptExpr';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression onResponse(
    dynamic result,
  ) {
    return OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression.fromJson(
      result,
    );
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/context/big_maps/{big_map_id}/{script_expr}/normalized
class OctezUshuaiaRequestContextBigMapsBigMapIdScriptExprNormalized
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression,
          dynamic
        > {
  final String bigMapId;
  final String scriptExpr;
  final String chainId;
  final String blockId;
  final OctezUshuaiaContextBigMapsBigMapIdScriptExprNormalizedBody requestBody;

  const OctezUshuaiaRequestContextBigMapsBigMapIdScriptExprNormalized({
    required this.bigMapId,
    required this.scriptExpr,
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/big_maps/$bigMapId/$scriptExpr/normalized';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression onResponse(
    dynamic result,
  ) {
    return OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/cache/contracts/all
class OctezUshuaiaRequestContextCacheContractsAll
    extends
        OctezUshuaiaRequest<
          List<List<OctezUshuaiaResponseContextCacheContractsAllItemItem>>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextCacheContractsAll({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/cache/contracts/all';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<List<OctezUshuaiaResponseContextCacheContractsAllItemItem>> onResponse(
    List<dynamic> result,
  ) {
    return result
            .map(
              (e) =>
                  (e as List)
                      .map(
                        (x) =>
                            OctezUshuaiaResponseContextCacheContractsAllItemItem.fromJson(
                              x,
                            ),
                      )
                      .toList(),
            )
            .toList()
        as List<List<OctezUshuaiaResponseContextCacheContractsAllItemItem>>;
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/context/cache/contracts/rank
class OctezUshuaiaRequestContextCacheContractsRank
    extends OctezUshuaiaRequest<int?, int?> {
  final String chainId;
  final String blockId;
  final OctezUshuaiaUnistring requestBody;

  const OctezUshuaiaRequestContextCacheContractsRank({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/cache/contracts/rank';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  int? onResponse(int? result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/cache/contracts/size
class OctezUshuaiaRequestContextCacheContractsSize
    extends OctezUshuaiaRequest<int, int> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextCacheContractsSize({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/cache/contracts/size';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int onResponse(int result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/cache/contracts/size_limit
class OctezUshuaiaRequestContextCacheContractsSizeLimit
    extends OctezUshuaiaRequest<int, int> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextCacheContractsSizeLimit({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/cache/contracts/size_limit';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int onResponse(int result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/constants
class OctezUshuaiaRequestContextConstants
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextConstants,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextConstants({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/constants';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextConstants onResponse(Map<String, dynamic> result) {
    return OctezUshuaiaResponseContextConstants.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/constants/errors
class OctezUshuaiaRequestContextConstantsErrors
    extends OctezUshuaiaRequest<dynamic, dynamic> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextConstantsErrors({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/constants/errors';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/constants/parametric
class OctezUshuaiaRequestContextConstantsParametric
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextConstantsParametric,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextConstantsParametric({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/constants/parametric';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextConstantsParametric onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextConstantsParametric.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts
class OctezUshuaiaRequestContextContracts
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaN025PsUshuaiContractId>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContracts({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/contracts';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaN025PsUshuaiContractId> onResponse(List<dynamic> result) {
    return result
        .map((e) => OctezUshuaiaN025PsUshuaiContractId.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}
class OctezUshuaiaRequestContextContractsContractId
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextContractsContractId,
          Map<String, dynamic>
        > {
  final String contractId;
  final String? normalizeTypes;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractId({
    required this.contractId,
    this.normalizeTypes,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'normalize_types': normalizeTypes,
  };

  @override
  OctezUshuaiaResponseContextContractsContractId onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextContractsContractId.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/all_ticket_balances
class OctezUshuaiaRequestContextContractsContractIdAllTicketBalances
    extends
        OctezUshuaiaRequest<
          List<
            OctezUshuaiaResponseContextContractsContractIdAllTicketBalancesItem
          >,
          List<dynamic>
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdAllTicketBalances({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/all_ticket_balances';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseContextContractsContractIdAllTicketBalancesItem>
  onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseContextContractsContractIdAllTicketBalancesItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/balance
class OctezUshuaiaRequestContextContractsContractIdBalance
    extends OctezUshuaiaRequest<String, String> {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdBalance({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) => result.replaceAll('"', '').trim();
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/balance_and_frozen_bonds
class OctezUshuaiaRequestContextContractsContractIdBalanceAndFrozenBonds
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdBalanceAndFrozenBonds({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/balance_and_frozen_bonds';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/big_map_get
class OctezUshuaiaRequestContextContractsContractIdBigMapGet
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression?,
          dynamic
        > {
  final String contractId;
  final String chainId;
  final String blockId;
  final OctezUshuaiaContextContractsContractIdBigMapGetBody requestBody;

  const OctezUshuaiaRequestContextContractsContractIdBigMapGet({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/big_map_get';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression? onResponse(
    dynamic result,
  ) {
    if (result == null) return null;
    return OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/counter
class OctezUshuaiaRequestContextContractsContractIdCounter
    extends OctezUshuaiaRequest<String, String> {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdCounter({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/counter';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) => result.replaceAll('"', '').trim();
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/delegate
class OctezUshuaiaRequestContextContractsContractIdDelegate
    extends OctezUshuaiaRequest<OctezUshuaiaUnistring, dynamic> {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdDelegate({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/delegate';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaUnistring onResponse(dynamic result) {
    return OctezUshuaiaUnistring.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/entrypoints
class OctezUshuaiaRequestContextContractsContractIdEntrypoints
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextContractsContractIdEntrypoints,
          Map<String, dynamic>
        > {
  final String contractId;
  final String? normalizeTypes;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdEntrypoints({
    required this.contractId,
    this.normalizeTypes,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/entrypoints';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'normalize_types': normalizeTypes,
  };

  @override
  OctezUshuaiaResponseContextContractsContractIdEntrypoints onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextContractsContractIdEntrypoints.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/entrypoints/{entrypoint}
class OctezUshuaiaRequestContextContractsContractIdEntrypointsEntrypoint
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression,
          dynamic
        > {
  final String contractId;
  final String entrypoint;
  final String? normalizeTypes;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdEntrypointsEntrypoint({
    required this.contractId,
    required this.entrypoint,
    this.normalizeTypes,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/entrypoints/$entrypoint';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'normalize_types': normalizeTypes,
  };

  @override
  OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression onResponse(
    dynamic result,
  ) {
    return OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/estimated_own_pending_slashed_amount
class OctezUshuaiaRequestContextContractsContractIdEstimatedOwnPendingSlashedAmount
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdEstimatedOwnPendingSlashedAmount({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/estimated_own_pending_slashed_amount';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/frozen_bonds
class OctezUshuaiaRequestContextContractsContractIdFrozenBonds
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdFrozenBonds({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/frozen_bonds';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/full_balance
class OctezUshuaiaRequestContextContractsContractIdFullBalance
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdFullBalance({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/full_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/manager_key
class OctezUshuaiaRequestContextContractsContractIdManagerKey
    extends OctezUshuaiaRequest<String?, String> {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdManagerKey({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/manager_key';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String? onResponse(String result) {
    final s = result.replaceAll('"', '').trim();
    if (s.isEmpty || s == 'null') return null;
    return s;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/script
class OctezUshuaiaRequestContextContractsContractIdScript
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextContractsContractIdScript29,
          Map<String, dynamic>
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdScript({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/script';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextContractsContractIdScript29 onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextContractsContractIdScript29.fromJson(
      result,
    );
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/script/normalized
class OctezUshuaiaRequestContextContractsContractIdScriptNormalized
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaN025PsUshuaiScriptedContracts?,
          Map<String, dynamic>?
        > {
  final String contractId;
  final String chainId;
  final String blockId;
  final OctezUshuaiaContextContractsContractIdScriptNormalizedBody requestBody;

  const OctezUshuaiaRequestContextContractsContractIdScriptNormalized({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/script/normalized';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaN025PsUshuaiScriptedContracts? onResponse(
    Map<String, dynamic>? result,
  ) {
    if (result == null) return null;
    return OctezUshuaiaN025PsUshuaiScriptedContracts.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/single_sapling_get_diff
class OctezUshuaiaRequestContextContractsContractIdSingleSaplingGetDiff
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextContractsContractIdSingleSaplingGetDiff,
          Map<String, dynamic>
        > {
  final String contractId;
  final String? offsetCommitment;
  final String? offsetNullifier;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdSingleSaplingGetDiff({
    required this.contractId,
    this.offsetCommitment,
    this.offsetNullifier,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/single_sapling_get_diff';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'offset_commitment': offsetCommitment,
    'offset_nullifier': offsetNullifier,
  };

  @override
  OctezUshuaiaResponseContextContractsContractIdSingleSaplingGetDiff onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextContractsContractIdSingleSaplingGetDiff.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/spendable
class OctezUshuaiaRequestContextContractsContractIdSpendable
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdSpendable({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/spendable';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/spendable_and_frozen_bonds
class OctezUshuaiaRequestContextContractsContractIdSpendableAndFrozenBonds
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdSpendableAndFrozenBonds({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/spendable_and_frozen_bonds';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/staked_balance
class OctezUshuaiaRequestContextContractsContractIdStakedBalance
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaN025PsUshuaiMutez?,
          OctezUshuaiaN025PsUshuaiMutez?
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdStakedBalance({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/staked_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaN025PsUshuaiMutez? onResponse(
    OctezUshuaiaN025PsUshuaiMutez? result,
  ) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/staking_numerator
class OctezUshuaiaRequestContextContractsContractIdStakingNumerator
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdStakingNumerator({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/staking_numerator';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/stez_balance
class OctezUshuaiaRequestContextContractsContractIdStezBalance
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdStezBalance({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/stez_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/stez_redeemed_finalizable_balance
class OctezUshuaiaRequestContextContractsContractIdStezRedeemedFinalizableBalance
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaN025PsUshuaiMutez?,
          OctezUshuaiaN025PsUshuaiMutez?
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdStezRedeemedFinalizableBalance({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/stez_redeemed_finalizable_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaN025PsUshuaiMutez? onResponse(
    OctezUshuaiaN025PsUshuaiMutez? result,
  ) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/stez_redeemed_frozen_balance
class OctezUshuaiaRequestContextContractsContractIdStezRedeemedFrozenBalance
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaN025PsUshuaiMutez?,
          OctezUshuaiaN025PsUshuaiMutez?
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdStezRedeemedFrozenBalance({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/stez_redeemed_frozen_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaN025PsUshuaiMutez? onResponse(
    OctezUshuaiaN025PsUshuaiMutez? result,
  ) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/stez_ticket_balance
class OctezUshuaiaRequestContextContractsContractIdStezTicketBalance
    extends OctezUshuaiaRequest<String, String> {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdStezTicketBalance({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/stez_ticket_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/storage
class OctezUshuaiaRequestContextContractsContractIdStorage
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression,
          dynamic
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdStorage({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/storage';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression onResponse(
    dynamic result,
  ) {
    return OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression.fromJson(
      result,
    );
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/storage/normalized
class OctezUshuaiaRequestContextContractsContractIdStorageNormalized
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression?,
          dynamic
        > {
  final String contractId;
  final String chainId;
  final String blockId;
  final OctezUshuaiaContextBigMapsBigMapIdScriptExprNormalizedBody requestBody;

  const OctezUshuaiaRequestContextContractsContractIdStorageNormalized({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/storage/normalized';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression? onResponse(
    dynamic result,
  ) {
    if (result == null) return null;
    return OctezUshuaiaMicheline025PsUshuaiMichelsonV1Expression.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/storage/paid_space
class OctezUshuaiaRequestContextContractsContractIdStoragePaidSpace
    extends OctezUshuaiaRequest<OctezUshuaiaBignum?, OctezUshuaiaBignum?> {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdStoragePaidSpace({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/storage/paid_space';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaBignum? onResponse(OctezUshuaiaBignum? result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/storage/used_space
class OctezUshuaiaRequestContextContractsContractIdStorageUsedSpace
    extends OctezUshuaiaRequest<OctezUshuaiaBignum?, OctezUshuaiaBignum?> {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdStorageUsedSpace({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/storage/used_space';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaBignum? onResponse(OctezUshuaiaBignum? result) {
    return result;
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/ticket_balance
class OctezUshuaiaRequestContextContractsContractIdTicketBalance
    extends OctezUshuaiaRequest<String, String> {
  final String contractId;
  final String chainId;
  final String blockId;
  final OctezUshuaiaContextContractsContractIdTicketBalanceBody requestBody;

  const OctezUshuaiaRequestContextContractsContractIdTicketBalance({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/ticket_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/unstake_requests
class OctezUshuaiaRequestContextContractsContractIdUnstakeRequests
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextContractsContractIdUnstakeRequests?,
          Map<String, dynamic>?
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdUnstakeRequests({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/unstake_requests';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextContractsContractIdUnstakeRequests? onResponse(
    Map<String, dynamic>? result,
  ) {
    if (result == null) return null;
    return OctezUshuaiaResponseContextContractsContractIdUnstakeRequests.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/unstaked_finalizable_balance
class OctezUshuaiaRequestContextContractsContractIdUnstakedFinalizableBalance
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaN025PsUshuaiMutez?,
          OctezUshuaiaN025PsUshuaiMutez?
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdUnstakedFinalizableBalance({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/unstaked_finalizable_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaN025PsUshuaiMutez? onResponse(
    OctezUshuaiaN025PsUshuaiMutez? result,
  ) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/contracts/{contract_id}/unstaked_frozen_balance
class OctezUshuaiaRequestContextContractsContractIdUnstakedFrozenBalance
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaN025PsUshuaiMutez?,
          OctezUshuaiaN025PsUshuaiMutez?
        > {
  final String contractId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextContractsContractIdUnstakedFrozenBalance({
    required this.contractId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/contracts/$contractId/unstaked_frozen_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaN025PsUshuaiMutez? onResponse(
    OctezUshuaiaN025PsUshuaiMutez? result,
  ) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/dal/commitments_history
class OctezUshuaiaRequestContextDalCommitmentsHistory
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDalCommitmentsHistory?,
          dynamic
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDalCommitmentsHistory({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/dal/commitments_history';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextDalCommitmentsHistory? onResponse(dynamic result) {
    if (result == null) return null;
    return OctezUshuaiaResponseContextDalCommitmentsHistory.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/dal/past_parameters/{block_level}
class OctezUshuaiaRequestContextDalPastParametersBlockLevel
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextConstantsDalParametric,
          Map<String, dynamic>
        > {
  final String blockLevel;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDalPastParametersBlockLevel({
    required this.blockLevel,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/dal/past_parameters/$blockLevel';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextConstantsDalParametric onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextConstantsDalParametric.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/dal/published_slot_headers
class OctezUshuaiaRequestContextDalPublishedSlotHeaders
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseContextDalPublishedSlotHeadersItem>,
          List<dynamic>
        > {
  final String? level;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDalPublishedSlotHeaders({
    this.level,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/dal/published_slot_headers';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'level': level};

  @override
  List<OctezUshuaiaResponseContextDalPublishedSlotHeadersItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseContextDalPublishedSlotHeadersItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/dal/shards
class OctezUshuaiaRequestContextDalShards
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseContextDalShardsItem>,
          List<dynamic>
        > {
  final String? level;
  final String? delegates;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDalShards({
    this.level,
    this.delegates,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/dal/shards';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'level': level,
    'delegates': delegates,
  };

  @override
  List<OctezUshuaiaResponseContextDalShardsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezUshuaiaResponseContextDalShardsItem.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/dal/skip_list_cells_of_level
class OctezUshuaiaRequestContextDalSkipListCellsOfLevel
    extends
        OctezUshuaiaRequest<
          List<
            List<OctezUshuaiaResponseContextDalSkipListCellsOfLevelItemItem>
          >,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDalSkipListCellsOfLevel({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/dal/skip_list_cells_of_level';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<List<OctezUshuaiaResponseContextDalSkipListCellsOfLevelItemItem>>
  onResponse(List<dynamic> result) {
    return result
            .map(
              (e) =>
                  (e as List)
                      .map(
                        (x) =>
                            OctezUshuaiaResponseContextDalSkipListCellsOfLevelItemItem.fromJson(
                              x,
                            ),
                      )
                      .toList(),
            )
            .toList()
        as List<
          List<OctezUshuaiaResponseContextDalSkipListCellsOfLevelItemItem>
        >;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates
class OctezUshuaiaRequestContextDelegates
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaSignaturePublicKeyHash>,
          List<dynamic>
        > {
  final String? active;
  final String? inactive;
  final String? withMinimalStake;
  final String? withoutMinimalStake;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegates({
    this.active,
    this.inactive,
    this.withMinimalStake,
    this.withoutMinimalStake,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/delegates';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'active': active,
    'inactive': inactive,
    'with_minimal_stake': withMinimalStake,
    'without_minimal_stake': withoutMinimalStake,
  };

  @override
  List<OctezUshuaiaSignaturePublicKeyHash> onResponse(List<dynamic> result) {
    return result
        .map((e) => OctezUshuaiaSignaturePublicKeyHash.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}
class OctezUshuaiaRequestContextDelegatesPkh
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDelegatesPkh,
          Map<String, dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkh({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/delegates/$pkh';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextDelegatesPkh onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextDelegatesPkh.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/active_staking_parameters
class OctezUshuaiaRequestContextDelegatesPkhActiveStakingParameters
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDelegatesPkhActiveStakingParameters,
          Map<String, dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhActiveStakingParameters({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/active_staking_parameters';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextDelegatesPkhActiveStakingParameters onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextDelegatesPkhActiveStakingParameters.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/active_stez_parameters
class OctezUshuaiaRequestContextDelegatesPkhActiveStezParameters
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDelegatesPkhActiveStezParameters?,
          Map<String, dynamic>?
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhActiveStezParameters({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/active_stez_parameters';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextDelegatesPkhActiveStezParameters? onResponse(
    Map<String, dynamic>? result,
  ) {
    if (result == null) return null;
    return OctezUshuaiaResponseContextDelegatesPkhActiveStezParameters.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/baking_power
class OctezUshuaiaRequestContextDelegatesPkhBakingPower
    extends OctezUshuaiaRequest<String, String> {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhBakingPower({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/baking_power';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/companion_key
class OctezUshuaiaRequestContextDelegatesPkhCompanionKey
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDelegatesPkhCompanionKey,
          Map<String, dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhCompanionKey({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/companion_key';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextDelegatesPkhCompanionKey onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextDelegatesPkhCompanionKey.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/consensus_key
class OctezUshuaiaRequestContextDelegatesPkhConsensusKey
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDelegatesPkhConsensusKey,
          Map<String, dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhConsensusKey({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/consensus_key';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextDelegatesPkhConsensusKey onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextDelegatesPkhConsensusKey.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/current_baking_power
class OctezUshuaiaRequestContextDelegatesPkhCurrentBakingPower
    extends OctezUshuaiaRequest<String, String> {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhCurrentBakingPower({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/current_baking_power';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/current_frozen_deposits
class OctezUshuaiaRequestContextDelegatesPkhCurrentFrozenDeposits
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhCurrentFrozenDeposits({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/current_frozen_deposits';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/current_voting_power
class OctezUshuaiaRequestContextDelegatesPkhCurrentVotingPower
    extends OctezUshuaiaRequest<String, String> {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhCurrentVotingPower({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/current_voting_power';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/dal_participation
class OctezUshuaiaRequestContextDelegatesPkhDalParticipation
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDelegatesPkhDalParticipation,
          Map<String, dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhDalParticipation({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/dal_participation';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextDelegatesPkhDalParticipation onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextDelegatesPkhDalParticipation.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/deactivated
class OctezUshuaiaRequestContextDelegatesPkhDeactivated
    extends OctezUshuaiaRequest<bool, bool> {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhDeactivated({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/deactivated';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  bool onResponse(bool result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/delegated_balance
class OctezUshuaiaRequestContextDelegatesPkhDelegatedBalance
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhDelegatedBalance({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/delegated_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/delegated_contracts
class OctezUshuaiaRequestContextDelegatesPkhDelegatedContracts
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaN025PsUshuaiContractId>,
          List<dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhDelegatedContracts({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/delegated_contracts';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaN025PsUshuaiContractId> onResponse(List<dynamic> result) {
    return result
        .map((e) => OctezUshuaiaN025PsUshuaiContractId.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/delegators
class OctezUshuaiaRequestContextDelegatesPkhDelegators
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaN025PsUshuaiContractId>,
          List<dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhDelegators({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/delegators';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaN025PsUshuaiContractId> onResponse(List<dynamic> result) {
    return result
        .map((e) => OctezUshuaiaN025PsUshuaiContractId.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/denunciations
class OctezUshuaiaRequestContextDelegatesPkhDenunciations
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseContextDelegatesPkhDenunciationsItem>,
          List<dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhDenunciations({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/denunciations';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseContextDelegatesPkhDenunciationsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseContextDelegatesPkhDenunciationsItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/estimated_shared_pending_slashed_amount
class OctezUshuaiaRequestContextDelegatesPkhEstimatedSharedPendingSlashedAmount
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhEstimatedSharedPendingSlashedAmount({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/estimated_shared_pending_slashed_amount';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/external_delegated
class OctezUshuaiaRequestContextDelegatesPkhExternalDelegated
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhExternalDelegated({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/external_delegated';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/external_staked
class OctezUshuaiaRequestContextDelegatesPkhExternalStaked
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhExternalStaked({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/external_staked';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/frozen_deposits
class OctezUshuaiaRequestContextDelegatesPkhFrozenDeposits
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhFrozenDeposits({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/frozen_deposits';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/frozen_deposits_limit
class OctezUshuaiaRequestContextDelegatesPkhFrozenDepositsLimit
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaN025PsUshuaiMutez?,
          OctezUshuaiaN025PsUshuaiMutez?
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhFrozenDepositsLimit({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/frozen_deposits_limit';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaN025PsUshuaiMutez? onResponse(
    OctezUshuaiaN025PsUshuaiMutez? result,
  ) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/full_balance
class OctezUshuaiaRequestContextDelegatesPkhFullBalance
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhFullBalance({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/full_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/grace_period
class OctezUshuaiaRequestContextDelegatesPkhGracePeriod
    extends OctezUshuaiaRequest<int, int> {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhGracePeriod({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/grace_period';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int onResponse(int result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/is_forbidden
class OctezUshuaiaRequestContextDelegatesPkhIsForbidden
    extends OctezUshuaiaRequest<bool, bool> {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhIsForbidden({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/is_forbidden';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  bool onResponse(bool result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/min_delegated_in_current_cycle
class OctezUshuaiaRequestContextDelegatesPkhMinDelegatedInCurrentCycle
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDelegatesPkhMinDelegatedInCurrentCycle,
          Map<String, dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhMinDelegatedInCurrentCycle({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/min_delegated_in_current_cycle';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextDelegatesPkhMinDelegatedInCurrentCycle onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextDelegatesPkhMinDelegatedInCurrentCycle.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/own_delegated
class OctezUshuaiaRequestContextDelegatesPkhOwnDelegated
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhOwnDelegated({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/own_delegated';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/own_full_balance
class OctezUshuaiaRequestContextDelegatesPkhOwnFullBalance
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhOwnFullBalance({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/own_full_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/own_staked
class OctezUshuaiaRequestContextDelegatesPkhOwnStaked
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhOwnStaked({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/own_staked';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/participation
class OctezUshuaiaRequestContextDelegatesPkhParticipation
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDelegatesPkhParticipation,
          Map<String, dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhParticipation({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/participation';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextDelegatesPkhParticipation onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextDelegatesPkhParticipation.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/pending_staking_parameters
class OctezUshuaiaRequestContextDelegatesPkhPendingStakingParameters
    extends
        OctezUshuaiaRequest<
          List<
            OctezUshuaiaResponseContextDelegatesPkhPendingStakingParametersItem
          >,
          List<dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhPendingStakingParameters({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/pending_staking_parameters';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseContextDelegatesPkhPendingStakingParametersItem>
  onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseContextDelegatesPkhPendingStakingParametersItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/pending_stez_parameters
class OctezUshuaiaRequestContextDelegatesPkhPendingStezParameters
    extends
        OctezUshuaiaRequest<
          List<
            OctezUshuaiaResponseContextDelegatesPkhPendingStezParametersItem
          >,
          List<dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhPendingStezParameters({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/pending_stez_parameters';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseContextDelegatesPkhPendingStezParametersItem>
  onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseContextDelegatesPkhPendingStezParametersItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/stakers
class OctezUshuaiaRequestContextDelegatesPkhStakers
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseContextDelegatesPkhStakersItem>,
          List<dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhStakers({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/stakers';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseContextDelegatesPkhStakersItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) => OctezUshuaiaResponseContextDelegatesPkhStakersItem.fromJson(e),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/staking_balance
class OctezUshuaiaRequestContextDelegatesPkhStakingBalance
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhStakingBalance({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/staking_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/staking_denominator
class OctezUshuaiaRequestContextDelegatesPkhStakingDenominator
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhStakingDenominator({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/staking_denominator';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/stez_registered
class OctezUshuaiaRequestContextDelegatesPkhStezRegistered
    extends OctezUshuaiaRequest<bool, bool> {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhStezRegistered({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/stez_registered';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  bool onResponse(bool result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/stez_staking_power
class OctezUshuaiaRequestContextDelegatesPkhStezStakingPower
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhStezStakingPower({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/stez_staking_power';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/total_delegated
class OctezUshuaiaRequestContextDelegatesPkhTotalDelegated
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhTotalDelegated({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/total_delegated';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/total_delegated_stake
class OctezUshuaiaRequestContextDelegatesPkhTotalDelegatedStake
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhTotalDelegatedStake({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/total_delegated_stake';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/total_staked
class OctezUshuaiaRequestContextDelegatesPkhTotalStaked
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhTotalStaked({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/total_staked';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/total_unstaked_per_cycle
class OctezUshuaiaRequestContextDelegatesPkhTotalUnstakedPerCycle
    extends
        OctezUshuaiaRequest<
          List<
            OctezUshuaiaResponseContextDelegatesPkhTotalUnstakedPerCycleItem
          >,
          List<dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhTotalUnstakedPerCycle({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/total_unstaked_per_cycle';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseContextDelegatesPkhTotalUnstakedPerCycleItem>
  onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseContextDelegatesPkhTotalUnstakedPerCycleItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/unstaked_frozen_deposits
class OctezUshuaiaRequestContextDelegatesPkhUnstakedFrozenDeposits
    extends
        OctezUshuaiaRequest<
          List<
            OctezUshuaiaResponseContextDelegatesPkhTotalUnstakedPerCycleItem
          >,
          List<dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhUnstakedFrozenDeposits({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/unstaked_frozen_deposits';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseContextDelegatesPkhTotalUnstakedPerCycleItem>
  onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseContextDelegatesPkhTotalUnstakedPerCycleItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/voting_info
class OctezUshuaiaRequestContextDelegatesPkhVotingInfo
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDelegatesPkhVotingInfo,
          Map<String, dynamic>
        > {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhVotingInfo({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/voting_info';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextDelegatesPkhVotingInfo onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextDelegatesPkhVotingInfo.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/delegates/{pkh}/voting_power
class OctezUshuaiaRequestContextDelegatesPkhVotingPower
    extends OctezUshuaiaRequest<String, String> {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDelegatesPkhVotingPower({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/delegates/$pkh/voting_power';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/denunciations
class OctezUshuaiaRequestContextDenunciations
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseContextDenunciationsItem>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDenunciations({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/denunciations';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseContextDenunciationsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezUshuaiaResponseContextDenunciationsItem.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/destination/{destination_id}/index
class OctezUshuaiaRequestContextDestinationDestinationIdIndex
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum?,
          OctezUshuaiaPositiveBignum?
        > {
  final String destinationId;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextDestinationDestinationIdIndex({
    required this.destinationId,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/destination/$destinationId/index';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum? onResponse(OctezUshuaiaPositiveBignum? result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/issuance/current_yearly_rate
class OctezUshuaiaRequestContextIssuanceCurrentYearlyRate
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextIssuanceCurrentYearlyRate,
          dynamic
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextIssuanceCurrentYearlyRate({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/issuance/current_yearly_rate';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextIssuanceCurrentYearlyRate onResponse(
    dynamic result,
  ) {
    return OctezUshuaiaResponseContextIssuanceCurrentYearlyRate.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/issuance/current_yearly_rate_details
class OctezUshuaiaRequestContextIssuanceCurrentYearlyRateDetails
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextIssuanceCurrentYearlyRateDetails,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextIssuanceCurrentYearlyRateDetails({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/issuance/current_yearly_rate_details';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextIssuanceCurrentYearlyRateDetails onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextIssuanceCurrentYearlyRateDetails.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/issuance/current_yearly_rate_exact
class OctezUshuaiaRequestContextIssuanceCurrentYearlyRateExact
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextIssuanceCurrentYearlyRateDetailsStatic,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextIssuanceCurrentYearlyRateExact({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/issuance/current_yearly_rate_exact';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextIssuanceCurrentYearlyRateDetailsStatic onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextIssuanceCurrentYearlyRateDetailsStatic.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/issuance/expected_issuance
class OctezUshuaiaRequestContextIssuanceExpectedIssuance
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseContextIssuanceExpectedIssuanceItem>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextIssuanceExpectedIssuance({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/issuance/expected_issuance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseContextIssuanceExpectedIssuanceItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseContextIssuanceExpectedIssuanceItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/issuance/issuance_per_minute
class OctezUshuaiaRequestContextIssuanceIssuancePerMinute
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextIssuanceIssuancePerMinute({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/issuance/issuance_per_minute';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/liquidity_baking/cpmm_address
class OctezUshuaiaRequestContextLiquidityBakingCpmmAddress
    extends OctezUshuaiaRequest<OctezUshuaiaUnistring, dynamic> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextLiquidityBakingCpmmAddress({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/liquidity_baking/cpmm_address';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaUnistring onResponse(dynamic result) {
    return OctezUshuaiaUnistring.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/merkle_tree
class OctezUshuaiaRequestContextMerkleTree
    extends OctezUshuaiaRequest<OctezUshuaiaMerkleTree?, List<dynamic>?> {
  final String? holey;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextMerkleTree({
    this.holey,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/merkle_tree';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'holey': holey};

  @override
  OctezUshuaiaMerkleTree? onResponse(List<dynamic>? result) {
    if (result == null) return null;
    return result
            .map(
              (e) =>
                  (e as List)
                      .map((x) => OctezUshuaiaMerkleTreeItemItem.fromJson(x))
                      .toList(),
            )
            .toList()
        as OctezUshuaiaMerkleTree;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/merkle_tree_v2
class OctezUshuaiaRequestContextMerkleTreeV2
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextMerkleTreeV2?,
          Map<String, dynamic>?
        > {
  final String? holey;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextMerkleTreeV2({
    this.holey,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/merkle_tree_v2';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'holey': holey};

  @override
  OctezUshuaiaResponseContextMerkleTreeV2? onResponse(
    Map<String, dynamic>? result,
  ) {
    if (result == null) return null;
    return OctezUshuaiaResponseContextMerkleTreeV2.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/nonces/{block_level}
class OctezUshuaiaRequestContextNoncesBlockLevel
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextNoncesBlockLevel,
          dynamic
        > {
  final String blockLevel;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextNoncesBlockLevel({
    required this.blockLevel,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/nonces/$blockLevel';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextNoncesBlockLevel onResponse(dynamic result) {
    return OctezUshuaiaResponseContextNoncesBlockLevel.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/protocol/first_level
class OctezUshuaiaRequestContextProtocolFirstLevel
    extends OctezUshuaiaRequest<int, int> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextProtocolFirstLevel({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/protocol/first_level';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int onResponse(int result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/raw/bytes
class OctezUshuaiaRequestContextRawBytes
    extends OctezUshuaiaRequest<OctezUshuaiaRawContext?, dynamic> {
  final String? depth;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextRawBytes({
    this.depth,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/raw/bytes';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'depth': depth};

  @override
  OctezUshuaiaRawContext? onResponse(dynamic result) {
    if (result == null) return null;
    return OctezUshuaiaRawContext.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/sapling/{sapling_state_id}/get_diff
class OctezUshuaiaRequestContextSaplingSaplingStateIdGetDiff
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextContractsContractIdSingleSaplingGetDiff,
          Map<String, dynamic>
        > {
  final String saplingStateId;
  final String? offsetCommitment;
  final String? offsetNullifier;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSaplingSaplingStateIdGetDiff({
    required this.saplingStateId,
    this.offsetCommitment,
    this.offsetNullifier,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/sapling/$saplingStateId/get_diff';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'offset_commitment': offsetCommitment,
    'offset_nullifier': offsetNullifier,
  };

  @override
  OctezUshuaiaResponseContextContractsContractIdSingleSaplingGetDiff onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextContractsContractIdSingleSaplingGetDiff.fromJson(
      result,
    );
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/context/seed
class OctezUshuaiaRequestContextSeed
    extends OctezUshuaiaRequest<String, String> {
  final String chainId;
  final String blockId;
  final OctezUshuaiaContextSeedBody requestBody;

  const OctezUshuaiaRequestContextSeed({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/seed';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/seed_computation
class OctezUshuaiaRequestContextSeedComputation
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextSeedComputation,
          dynamic
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSeedComputation({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/seed_computation';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextSeedComputation onResponse(dynamic result) {
    return OctezUshuaiaResponseContextSeedComputation.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/all
class OctezUshuaiaRequestContextSmartRollupsAll
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaSmartRollupAddress>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsAll({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/all';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaSmartRollupAddress> onResponse(List<dynamic> result) {
    return result
        .map((e) => OctezUshuaiaSmartRollupAddress.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/all/inbox
class OctezUshuaiaRequestContextSmartRollupsAllInbox
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextSmartRollupsAllInbox,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsAllInbox({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/all/inbox';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextSmartRollupsAllInbox onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextSmartRollupsAllInbox.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/commitment/{smart_rollup_commitment_hash}
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressCommitmentSmartRollupCommitmentHash
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressCommitmentSmartRollupCommitmentHash,
          Map<String, dynamic>
        > {
  final String smartRollupAddress;
  final String smartRollupCommitmentHash;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressCommitmentSmartRollupCommitmentHash({
    required this.smartRollupAddress,
    required this.smartRollupCommitmentHash,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/commitment/$smartRollupCommitmentHash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressCommitmentSmartRollupCommitmentHash
  onResponse(Map<String, dynamic> result) {
    return OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressCommitmentSmartRollupCommitmentHash.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/commitment/{smart_rollup_commitment_hash}/can_be_cemented
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressCommitmentSmartRollupCommitmentHashCanBeCemented
    extends OctezUshuaiaRequest<bool, bool> {
  final String smartRollupAddress;
  final String smartRollupCommitmentHash;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressCommitmentSmartRollupCommitmentHashCanBeCemented({
    required this.smartRollupAddress,
    required this.smartRollupCommitmentHash,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/commitment/$smartRollupCommitmentHash/can_be_cemented';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  bool onResponse(bool result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/commitment/{smart_rollup_commitment_hash}/stakers_indexes
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressCommitmentSmartRollupCommitmentHashStakersIndexes
    extends
        OctezUshuaiaRequest<List<OctezUshuaiaPositiveBignum>, List<dynamic>> {
  final String smartRollupAddress;
  final String smartRollupCommitmentHash;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressCommitmentSmartRollupCommitmentHashStakersIndexes({
    required this.smartRollupAddress,
    required this.smartRollupCommitmentHash,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/commitment/$smartRollupCommitmentHash/stakers_indexes';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaPositiveBignum> onResponse(List<dynamic> result) {
    return result.cast<OctezUshuaiaPositiveBignum>().toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/consumed_outputs/{block_level}
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressConsumedOutputsBlockLevel
    extends OctezUshuaiaRequest<List<int>, List<dynamic>> {
  final String smartRollupAddress;
  final String blockLevel;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressConsumedOutputsBlockLevel({
    required this.smartRollupAddress,
    required this.blockLevel,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/consumed_outputs/$blockLevel';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<int> onResponse(List<dynamic> result) {
    return result.cast<int>().toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/genesis_info
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressGenesisInfo
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressGenesisInfo,
          Map<String, dynamic>
        > {
  final String smartRollupAddress;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressGenesisInfo({
    required this.smartRollupAddress,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/genesis_info';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressGenesisInfo
  onResponse(Map<String, dynamic> result) {
    return OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressGenesisInfo.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/inbox_level/{block_level}/commitments
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressInboxLevelBlockLevelCommitments
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaSmartRollupCommitmentHash>?,
          List<dynamic>?
        > {
  final String smartRollupAddress;
  final String blockLevel;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressInboxLevelBlockLevelCommitments({
    required this.smartRollupAddress,
    required this.blockLevel,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/inbox_level/$blockLevel/commitments';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaSmartRollupCommitmentHash>? onResponse(
    List<dynamic>? result,
  ) {
    if (result == null) return null;
    return result
        .map((e) => OctezUshuaiaSmartRollupCommitmentHash.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/kind
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressKind
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressKind,
          dynamic
        > {
  final String smartRollupAddress;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressKind({
    required this.smartRollupAddress,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/kind';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressKind
  onResponse(dynamic result) {
    return OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressKind.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/last_cemented_commitment_hash_with_level
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressLastCementedCommitmentHashWithLevel
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressLastCementedCommitmentHashWithLevel,
          Map<String, dynamic>
        > {
  final String smartRollupAddress;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressLastCementedCommitmentHashWithLevel({
    required this.smartRollupAddress,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/last_cemented_commitment_hash_with_level';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressLastCementedCommitmentHashWithLevel
  onResponse(Map<String, dynamic> result) {
    return OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressLastCementedCommitmentHashWithLevel.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/last_whitelist_update
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressLastWhitelistUpdate
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressLastWhitelistUpdate?,
          Map<String, dynamic>?
        > {
  final String smartRollupAddress;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressLastWhitelistUpdate({
    required this.smartRollupAddress,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/last_whitelist_update';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressLastWhitelistUpdate?
  onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    return OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressLastWhitelistUpdate.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/staker/{pkh}/conflicts
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhConflicts
    extends
        OctezUshuaiaRequest<
          List<
            OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhConflictsItem
          >,
          List<dynamic>
        > {
  final String smartRollupAddress;
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhConflicts({
    required this.smartRollupAddress,
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/staker/$pkh/conflicts';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<
    OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhConflictsItem
  >
  onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhConflictsItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/staker/{pkh}/games
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhGames
    extends
        OctezUshuaiaRequest<
          List<
            OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhGamesItem
          >,
          List<dynamic>
        > {
  final String smartRollupAddress;
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhGames({
    required this.smartRollupAddress,
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/staker/$pkh/games';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<
    OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhGamesItem
  >
  onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhGamesItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/staker/{pkh}/index
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhIndex
    extends OctezUshuaiaRequest<String, String> {
  final String smartRollupAddress;
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhIndex({
    required this.smartRollupAddress,
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/staker/$pkh/index';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/staker/{pkh}/staked_on_commitment
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhStakedOnCommitment
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhStakedOnCommitment?,
          Map<String, dynamic>?
        > {
  final String smartRollupAddress;
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhStakedOnCommitment({
    required this.smartRollupAddress,
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/staker/$pkh/staked_on_commitment';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhStakedOnCommitment?
  onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    return OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStakerPkhStakedOnCommitment.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/staker1/{staker1_pkh}/staker2/{staker2_pkh}/timeout
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStaker1Staker1PkhStaker2Staker2PkhTimeout
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStaker1Staker1PkhStaker2Staker2PkhTimeout?,
          Map<String, dynamic>?
        > {
  final String smartRollupAddress;
  final String staker1Pkh;
  final String staker2Pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStaker1Staker1PkhStaker2Staker2PkhTimeout({
    required this.smartRollupAddress,
    required this.staker1Pkh,
    required this.staker2Pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/staker1/$staker1Pkh/staker2/$staker2Pkh/timeout';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStaker1Staker1PkhStaker2Staker2PkhTimeout?
  onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    return OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStaker1Staker1PkhStaker2Staker2PkhTimeout.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/staker1/{staker1_pkh}/staker2/{staker2_pkh}/timeout_reached
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStaker1Staker1PkhStaker2Staker2PkhTimeoutReached
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStaker1Staker1PkhStaker2Staker2PkhTimeoutReached?,
          dynamic
        > {
  final String smartRollupAddress;
  final String staker1Pkh;
  final String staker2Pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStaker1Staker1PkhStaker2Staker2PkhTimeoutReached({
    required this.smartRollupAddress,
    required this.staker1Pkh,
    required this.staker2Pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/staker1/$staker1Pkh/staker2/$staker2Pkh/timeout_reached';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStaker1Staker1PkhStaker2Staker2PkhTimeoutReached?
  onResponse(dynamic result) {
    if (result == null) return null;
    return OctezUshuaiaResponseContextSmartRollupsSmartRollupSmartRollupAddressStaker1Staker1PkhStaker2Staker2PkhTimeoutReached.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/stakers
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStakers
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaSignaturePublicKeyHash>,
          List<dynamic>
        > {
  final String smartRollupAddress;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressStakers({
    required this.smartRollupAddress,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/stakers';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaSignaturePublicKeyHash> onResponse(List<dynamic> result) {
    return result
        .map((e) => OctezUshuaiaSignaturePublicKeyHash.fromJson(e))
        .toList();
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/ticket_balance
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressTicketBalance
    extends OctezUshuaiaRequest<String, String> {
  final String smartRollupAddress;
  final String chainId;
  final String blockId;
  final OctezUshuaiaContextContractsContractIdTicketBalanceBody requestBody;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressTicketBalance({
    required this.smartRollupAddress,
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/ticket_balance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/smart_rollups/smart_rollup/{smart_rollup_address}/whitelist
class OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressWhitelist
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaSignaturePublicKeyHash>?,
          List<dynamic>?
        > {
  final String smartRollupAddress;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextSmartRollupsSmartRollupSmartRollupAddressWhitelist({
    required this.smartRollupAddress,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/smart_rollups/smart_rollup/$smartRollupAddress/whitelist';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaSignaturePublicKeyHash>? onResponse(List<dynamic>? result) {
    if (result == null) return null;
    return result
        .map((e) => OctezUshuaiaSignaturePublicKeyHash.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/stez/bakers
class OctezUshuaiaRequestContextStezBakers
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseContextStezBakersItem>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextStezBakers({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/stez/bakers';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseContextStezBakersItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezUshuaiaResponseContextStezBakersItem.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/stez/contract_hash
class OctezUshuaiaRequestContextStezContractHash
    extends OctezUshuaiaRequest<OctezUshuaiaUnistring, dynamic> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextStezContractHash({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/stez/contract_hash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaUnistring onResponse(dynamic result) {
    return OctezUshuaiaUnistring.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/stez/exchange_rate
class OctezUshuaiaRequestContextStezExchangeRate
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextIssuanceCurrentYearlyRateDetailsStatic,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextStezExchangeRate({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/stez/exchange_rate';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextIssuanceCurrentYearlyRateDetailsStatic onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextIssuanceCurrentYearlyRateDetailsStatic.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/stez/staking_power
class OctezUshuaiaRequestContextStezStakingPower
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseContextStezStakingPowerItem>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextStezStakingPower({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/stez/staking_power';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseContextStezStakingPowerItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezUshuaiaResponseContextStezStakingPowerItem.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/stez/total_amount_of_tez
class OctezUshuaiaRequestContextStezTotalAmountOfTez
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextStezTotalAmountOfTez({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/stez/total_amount_of_tez';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/stez/total_supply
class OctezUshuaiaRequestContextStezTotalSupply
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextStezTotalSupply({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/stez/total_supply';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/total_currently_staked
class OctezUshuaiaRequestContextTotalCurrentlyStaked
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextTotalCurrentlyStaked,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextTotalCurrentlyStaked({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/total_currently_staked';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextTotalCurrentlyStaked onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextTotalCurrentlyStaked.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/total_frozen_stake
class OctezUshuaiaRequestContextTotalFrozenStake
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextTotalFrozenStake({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/context/total_frozen_stake';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/context/total_supply
class OctezUshuaiaRequestContextTotalSupply
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaPositiveBignum,
          OctezUshuaiaPositiveBignum
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestContextTotalSupply({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/context/total_supply';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaPositiveBignum onResponse(OctezUshuaiaPositiveBignum result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/hash
class OctezUshuaiaRequestHash
    extends OctezUshuaiaRequest<OctezUshuaiaUnistring, String> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHash({this.chainId = 'main', this.blockId = 'head'});

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/hash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaUnistring onResponse(String result) {
    // Node returns a JSON string `"BMxxx"`; string encoding strips outer quotes.
    return OctezUshuaiaUnistring.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/header
class OctezUshuaiaRequestHeader
    extends
        OctezUshuaiaRequest<OctezUshuaiaResponseHeader, Map<String, dynamic>> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHeader({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/header';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseHeader onResponse(Map<String, dynamic> result) {
    return OctezUshuaiaResponseHeader.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/header/protocol_data
class OctezUshuaiaRequestHeaderProtocolData
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHeaderProtocolData,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHeaderProtocolData({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/header/protocol_data';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseHeaderProtocolData onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHeaderProtocolData.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/header/protocol_data/raw
class OctezUshuaiaRequestHeaderProtocolDataRaw
    extends OctezUshuaiaRequest<String, String> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHeaderProtocolDataRaw({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/header/protocol_data/raw';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/header/raw
class OctezUshuaiaRequestHeaderRaw extends OctezUshuaiaRequest<String, String> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHeaderRaw({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/header/raw';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/header/shell
class OctezUshuaiaRequestHeaderShell
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHeaderShell,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHeaderShell({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/header/shell';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseHeaderShell onResponse(Map<String, dynamic> result) {
    return OctezUshuaiaResponseHeaderShell.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/all_bakers_attest_activation_level
class OctezUshuaiaRequestHelpersAllBakersAttestActivationLevel
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDelegatesPkhMinDelegatedInCurrentCycleLevel?,
          Map<String, dynamic>?
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersAllBakersAttestActivationLevel({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/all_bakers_attest_activation_level';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseContextDelegatesPkhMinDelegatedInCurrentCycleLevel?
  onResponse(Map<String, dynamic>? result) {
    if (result == null) return null;
    return OctezUshuaiaResponseContextDelegatesPkhMinDelegatedInCurrentCycleLevel.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/attestation_rights
class OctezUshuaiaRequestHelpersAttestationRights
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseHelpersAttestationRightsItem>,
          List<dynamic>
        > {
  final String? level;
  final String? cycle;
  final String? delegate;
  final String? consensusKey;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersAttestationRights({
    this.level,
    this.cycle,
    this.delegate,
    this.consensusKey,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/attestation_rights';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'level': level,
    'cycle': cycle,
    'delegate': delegate,
    'consensus_key': consensusKey,
  };

  @override
  List<OctezUshuaiaResponseHelpersAttestationRightsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) => OctezUshuaiaResponseHelpersAttestationRightsItem.fromJson(e),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/baking_power_distribution_for_current_cycle
class OctezUshuaiaRequestHelpersBakingPowerDistributionForCurrentCycle
    extends
        OctezUshuaiaRequest<
          List<
            OctezUshuaiaResponseHelpersBakingPowerDistributionForCurrentCycleItem
          >,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersBakingPowerDistributionForCurrentCycle({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/baking_power_distribution_for_current_cycle';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseHelpersBakingPowerDistributionForCurrentCycleItem>
  onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseHelpersBakingPowerDistributionForCurrentCycleItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/baking_rights
class OctezUshuaiaRequestHelpersBakingRights
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseHelpersBakingRightsItem>,
          List<dynamic>
        > {
  final String? level;
  final String? cycle;
  final String? delegate;
  final String? consensusKey;
  final String? maxRound;
  final String? all;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersBakingRights({
    this.level,
    this.cycle,
    this.delegate,
    this.consensusKey,
    this.maxRound,
    this.all,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/helpers/baking_rights';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'level': level,
    'cycle': cycle,
    'delegate': delegate,
    'consensus_key': consensusKey,
    'max_round': maxRound,
    'all': all,
  };

  @override
  List<OctezUshuaiaResponseHelpersBakingRightsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezUshuaiaResponseHelpersBakingRightsItem.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/complete/{prefix}
class OctezUshuaiaRequestHelpersCompletePrefix
    extends OctezUshuaiaRequest<List<OctezUshuaiaUnistring>, List<dynamic>> {
  final String prefix;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersCompletePrefix({
    required this.prefix,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/complete/$prefix';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaUnistring> onResponse(List<dynamic> result) {
    return result.map((e) => OctezUshuaiaUnistring.fromJson(e)).toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/consecutive_round_zero
class OctezUshuaiaRequestHelpersConsecutiveRoundZero
    extends OctezUshuaiaRequest<int, int> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersConsecutiveRoundZero({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/consecutive_round_zero';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int onResponse(int result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/current_level
class OctezUshuaiaRequestHelpersCurrentLevel
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextDelegatesPkhMinDelegatedInCurrentCycleLevel,
          Map<String, dynamic>
        > {
  final String offset;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersCurrentLevel({
    required this.offset,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/helpers/current_level';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'offset': offset};

  @override
  OctezUshuaiaResponseContextDelegatesPkhMinDelegatedInCurrentCycleLevel
  onResponse(Map<String, dynamic> result) {
    return OctezUshuaiaResponseContextDelegatesPkhMinDelegatedInCurrentCycleLevel.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/decode_dal_attestation/{dal_attestation_bitset}
class OctezUshuaiaRequestHelpersDecodeDalAttestationDalAttestationBitset
    extends
        OctezUshuaiaRequest<
          List<
            OctezUshuaiaResponseHelpersDecodeDalAttestationDalAttestationBitsetItem
          >,
          List<dynamic>
        > {
  final String dalAttestationBitset;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersDecodeDalAttestationDalAttestationBitset({
    required this.dalAttestationBitset,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/decode_dal_attestation/$dalAttestationBitset';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseHelpersDecodeDalAttestationDalAttestationBitsetItem>
  onResponse(List<dynamic> result) {
    return result
        .map(
          (e) =>
              OctezUshuaiaResponseHelpersDecodeDalAttestationDalAttestationBitsetItem.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/encode_dal_attestation
class OctezUshuaiaRequestHelpersEncodeDalAttestation
    extends OctezUshuaiaRequest<String, String> {
  final String chainId;
  final String blockId;
  final List<
    OctezUshuaiaResponseHelpersDecodeDalAttestationDalAttestationBitsetItem
  >
  requestBody;

  const OctezUshuaiaRequestHelpersEncodeDalAttestation({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/encode_dal_attestation';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.map((e) => e.toJson()).toList();

  @override
  String onResponse(String result) {
    return result;
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/forge/bls_consensus_operations
class OctezUshuaiaRequestHelpersForgeBlsConsensusOperations
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersForgeBlsConsensusOperations,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersForgeBlsConsensusOperationsBody requestBody;

  const OctezUshuaiaRequestHelpersForgeBlsConsensusOperations({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/forge/bls_consensus_operations';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersForgeBlsConsensusOperations onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersForgeBlsConsensusOperations.fromJson(
      result,
    );
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/forge/operations
class OctezUshuaiaRequestHelpersForgeOperations
    extends OctezUshuaiaRequest<String, String> {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersForgeBlsConsensusOperationsBody requestBody;

  const OctezUshuaiaRequestHelpersForgeOperations({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/forge/operations';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  String onResponse(String result) {
    return result;
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/forge/protocol_data
class OctezUshuaiaRequestHelpersForgeProtocolData
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersForgeProtocolData,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersForgeProtocolDataBody requestBody;

  const OctezUshuaiaRequestHelpersForgeProtocolData({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/forge/protocol_data';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersForgeProtocolData onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersForgeProtocolData.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/forge/signed_operations
class OctezUshuaiaRequestHelpersForgeSignedOperations
    extends OctezUshuaiaRequest<String, String> {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersForgeSignedOperationsBody requestBody;

  const OctezUshuaiaRequestHelpersForgeSignedOperations({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/forge/signed_operations';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  String onResponse(String result) {
    return result;
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/forge_block_header
class OctezUshuaiaRequestHelpersForgeBlockHeader
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersForgeBlockHeader,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersForgeBlockHeaderBody requestBody;

  const OctezUshuaiaRequestHelpersForgeBlockHeader({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/forge_block_header';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersForgeBlockHeader onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersForgeBlockHeader.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/levels_in_current_cycle
class OctezUshuaiaRequestHelpersLevelsInCurrentCycle
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersLevelsInCurrentCycle,
          Map<String, dynamic>
        > {
  final String offset;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersLevelsInCurrentCycle({
    required this.offset,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/levels_in_current_cycle';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'offset': offset};

  @override
  OctezUshuaiaResponseHelpersLevelsInCurrentCycle onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersLevelsInCurrentCycle.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/parse/block
class OctezUshuaiaRequestHelpersParseBlock
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersParseBlock,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersForgeBlockHeaderBody requestBody;

  const OctezUshuaiaRequestHelpersParseBlock({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/helpers/parse/block';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersParseBlock onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersParseBlock.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/parse/operations
class OctezUshuaiaRequestHelpersParseOperations
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaHelpersForgeSignedOperationsBody>,
          List<dynamic>
        > {
  final String? version;
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersParseOperationsBody requestBody;

  const OctezUshuaiaRequestHelpersParseOperations({
    this.version,
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/parse/operations';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'version': version};

  @override
  dynamic body() => requestBody.toJson();

  @override
  List<OctezUshuaiaHelpersForgeSignedOperationsBody> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezUshuaiaHelpersForgeSignedOperationsBody.fromJson(e))
        .toList();
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/preapply/block
class OctezUshuaiaRequestHelpersPreapplyBlock
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersPreapplyBlock,
          Map<String, dynamic>
        > {
  final String? sort;
  final String? timestamp;
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersPreapplyBlockBody requestBody;

  const OctezUshuaiaRequestHelpersPreapplyBlock({
    this.sort,
    this.timestamp,
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/helpers/preapply/block';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {
    'sort': sort,
    'timestamp': timestamp,
  };

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersPreapplyBlock onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersPreapplyBlock.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/preapply/operations
class OctezUshuaiaRequestHelpersPreapplyOperations
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaN025PsUshuaiOperationAlphaOperationWithMetadata>,
          List<dynamic>
        > {
  final String version;
  final String chainId;
  final String blockId;
  final List<OctezUshuaiaNextOperation> requestBody;

  const OctezUshuaiaRequestHelpersPreapplyOperations({
    required this.version,
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/preapply/operations';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String> get queryParameters => {'version': version};

  @override
  dynamic body() => requestBody.map((e) => e.toJson()).toList();

  @override
  List<OctezUshuaiaN025PsUshuaiOperationAlphaOperationWithMetadata> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map(
          (e) =>
              OctezUshuaiaN025PsUshuaiOperationAlphaOperationWithMetadata.fromJson(
                e,
              ),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/round
class OctezUshuaiaRequestHelpersRound extends OctezUshuaiaRequest<int, int> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersRound({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/helpers/round';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int onResponse(int result) {
    return result;
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/entrypoint
class OctezUshuaiaRequestHelpersScriptsEntrypoint
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsEntrypoint,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsEntrypointBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsEntrypoint({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/entrypoint';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsEntrypoint onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsEntrypoint.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/entrypoints
class OctezUshuaiaRequestHelpersScriptsEntrypoints
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextContractsContractIdEntrypoints,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsEntrypointsBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsEntrypoints({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/entrypoints';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseContextContractsContractIdEntrypoints onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseContextContractsContractIdEntrypoints.fromJson(
      result,
    );
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/normalize_data
class OctezUshuaiaRequestHelpersScriptsNormalizeData
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsNormalizeData,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsNormalizeDataBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsNormalizeData({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/normalize_data';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsNormalizeData onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsNormalizeData.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/normalize_script
class OctezUshuaiaRequestHelpersScriptsNormalizeScript
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsNormalizeData,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsNormalizeScriptBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsNormalizeScript({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/normalize_script';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsNormalizeData onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsNormalizeData.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/normalize_stack
class OctezUshuaiaRequestHelpersScriptsNormalizeStack
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsNormalizeStack,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsNormalizeStackBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsNormalizeStack({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/normalize_stack';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsNormalizeStack onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsNormalizeStack.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/normalize_type
class OctezUshuaiaRequestHelpersScriptsNormalizeType
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsNormalizeData,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsNormalizeTypeBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsNormalizeType({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/normalize_type';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsNormalizeData onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsNormalizeData.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/pack_data
class OctezUshuaiaRequestHelpersScriptsPackData
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsPackData,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsPackDataBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsPackData({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/pack_data';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsPackData onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsPackData.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/run_code
class OctezUshuaiaRequestHelpersScriptsRunCode
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsRunCode,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsRunCodeBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsRunCode({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/run_code';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsRunCode onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsRunCode.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/run_instruction
class OctezUshuaiaRequestHelpersScriptsRunInstruction
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsRunInstruction,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsRunInstructionBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsRunInstruction({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/run_instruction';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsRunInstruction onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsRunInstruction.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/run_operation
class OctezUshuaiaRequestHelpersScriptsRunOperation
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsRunOperation,
          dynamic
        > {
  final String? version;
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsRunOperationBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsRunOperation({
    this.version,
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/run_operation';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {'version': version};

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsRunOperation onResponse(dynamic result) {
    return OctezUshuaiaResponseHelpersScriptsRunOperation.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/run_script_view
class OctezUshuaiaRequestHelpersScriptsRunScriptView
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsRunScriptView,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsRunScriptViewBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsRunScriptView({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/run_script_view';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsRunScriptView onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsRunScriptView.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/run_view
class OctezUshuaiaRequestHelpersScriptsRunView
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsRunScriptView,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsRunViewBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsRunView({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/run_view';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsRunScriptView onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsRunScriptView.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/script_size
class OctezUshuaiaRequestHelpersScriptsScriptSize
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsScriptSize,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsScriptSizeBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsScriptSize({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/script_size';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsScriptSize onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsScriptSize.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/simulate_operation
class OctezUshuaiaRequestHelpersScriptsSimulateOperation
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsRunOperation,
          dynamic
        > {
  final String? version;
  final String? successorLevel;
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsSimulateOperationBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsSimulateOperation({
    this.version,
    this.successorLevel,
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/simulate_operation';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {
    'version': version,
    'successor_level': successorLevel,
  };

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsRunOperation onResponse(dynamic result) {
    return OctezUshuaiaResponseHelpersScriptsRunOperation.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/trace_code
class OctezUshuaiaRequestHelpersScriptsTraceCode
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsTraceCode,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsRunCodeBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsTraceCode({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/trace_code';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsTraceCode onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsTraceCode.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/typecheck_code
class OctezUshuaiaRequestHelpersScriptsTypecheckCode
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsTypecheckCode,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsTypecheckCodeBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsTypecheckCode({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/typecheck_code';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsTypecheckCode onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsTypecheckCode.fromJson(result);
  }
}

/// POST /chains/{chain_id}/blocks/{block_id}/helpers/scripts/typecheck_data
class OctezUshuaiaRequestHelpersScriptsTypecheckData
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseHelpersScriptsTypecheckData,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;
  final OctezUshuaiaHelpersScriptsTypecheckDataBody requestBody;

  const OctezUshuaiaRequestHelpersScriptsTypecheckData({
    this.chainId = 'main',
    this.blockId = 'head',
    required this.requestBody,
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/scripts/typecheck_data';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body() => requestBody.toJson();

  @override
  OctezUshuaiaResponseHelpersScriptsTypecheckData onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseHelpersScriptsTypecheckData.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/swrr_credits
class OctezUshuaiaRequestHelpersSwrrCredits
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseHelpersSwrrCreditsItem>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersSwrrCredits({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/helpers/swrr_credits';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseHelpersSwrrCreditsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezUshuaiaResponseHelpersSwrrCreditsItem.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/swrr_selected_bakers
class OctezUshuaiaRequestHelpersSwrrSelectedBakers
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseHelpersSwrrSelectedBakersItem>?,
          List<dynamic>?
        > {
  final String? cycle;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersSwrrSelectedBakers({
    this.cycle,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/swrr_selected_bakers';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'cycle': cycle};

  @override
  List<OctezUshuaiaResponseHelpersSwrrSelectedBakersItem>? onResponse(
    List<dynamic>? result,
  ) {
    if (result == null) return null;
    return result
        .map(
          (e) => OctezUshuaiaResponseHelpersSwrrSelectedBakersItem.fromJson(e),
        )
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/total_baking_power
class OctezUshuaiaRequestHelpersTotalBakingPower
    extends OctezUshuaiaRequest<String, String> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersTotalBakingPower({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/total_baking_power';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/tz4_baker_number_ratio
class OctezUshuaiaRequestHelpersTezos4BakerNumberRatio
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseContextIssuanceCurrentYearlyRate,
          dynamic
        > {
  final String? cycle;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersTezos4BakerNumberRatio({
    this.cycle,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/helpers/tz4_baker_number_ratio';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'cycle': cycle};

  @override
  OctezUshuaiaResponseContextIssuanceCurrentYearlyRate onResponse(
    dynamic result,
  ) {
    return OctezUshuaiaResponseContextIssuanceCurrentYearlyRate.fromJson(
      result,
    );
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/helpers/validators
class OctezUshuaiaRequestHelpersValidators
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseHelpersValidatorsItem>,
          List<dynamic>
        > {
  final String? level;
  final String? delegate;
  final String? consensusKey;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestHelpersValidators({
    this.level,
    this.delegate,
    this.consensusKey,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/helpers/validators';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'level': level,
    'delegate': delegate,
    'consensus_key': consensusKey,
  };

  @override
  List<OctezUshuaiaResponseHelpersValidatorsItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezUshuaiaResponseHelpersValidatorsItem.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/live_blocks
class OctezUshuaiaRequestLiveBlocks
    extends OctezUshuaiaRequest<List<OctezUshuaiaBlockHash>, List<dynamic>> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestLiveBlocks({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/live_blocks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaBlockHash> onResponse(List<dynamic> result) {
    return result.map((e) => OctezUshuaiaBlockHash.fromJson(e)).toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/metadata
class OctezUshuaiaRequestMetadata
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaBlockHeaderMetadata,
          Map<String, dynamic>
        > {
  final String version;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestMetadata({
    required this.version,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/metadata';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'version': version};

  @override
  OctezUshuaiaBlockHeaderMetadata onResponse(Map<String, dynamic> result) {
    return OctezUshuaiaBlockHeaderMetadata.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/metadata_hash
class OctezUshuaiaRequestMetadataHash
    extends OctezUshuaiaRequest<OctezUshuaiaUnistring, dynamic> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestMetadataHash({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/metadata_hash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaUnistring onResponse(dynamic result) {
    return OctezUshuaiaUnistring.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/operation_hashes
class OctezUshuaiaRequestOperationHashes
    extends
        OctezUshuaiaRequest<
          List<List<OctezUshuaiaOperationHash>>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestOperationHashes({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/operation_hashes';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<List<OctezUshuaiaOperationHash>> onResponse(List<dynamic> result) {
    return result
            .map(
              (e) =>
                  (e as List)
                      .map((x) => OctezUshuaiaOperationHash.fromJson(x))
                      .toList(),
            )
            .toList()
        as List<List<OctezUshuaiaOperationHash>>;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/operation_hashes/{list_offset}
class OctezUshuaiaRequestOperationHashesListOffset
    extends
        OctezUshuaiaRequest<List<OctezUshuaiaOperationHash>, List<dynamic>> {
  final String listOffset;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestOperationHashesListOffset({
    required this.listOffset,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/operation_hashes/$listOffset';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaOperationHash> onResponse(List<dynamic> result) {
    return result.map((e) => OctezUshuaiaOperationHash.fromJson(e)).toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/operation_hashes/{list_offset}/{operation_offset}
class OctezUshuaiaRequestOperationHashesListOffsetOperationOffset
    extends OctezUshuaiaRequest<OctezUshuaiaUnistring, dynamic> {
  final String listOffset;
  final String operationOffset;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestOperationHashesListOffsetOperationOffset({
    required this.listOffset,
    required this.operationOffset,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/operation_hashes/$listOffset/$operationOffset';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaUnistring onResponse(dynamic result) {
    return OctezUshuaiaUnistring.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/operation_metadata_hashes
class OctezUshuaiaRequestOperationMetadataHashes
    extends
        OctezUshuaiaRequest<
          List<List<OctezUshuaiaOperationMetadataHash>>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestOperationMetadataHashes({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/operation_metadata_hashes';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<List<OctezUshuaiaOperationMetadataHash>> onResponse(
    List<dynamic> result,
  ) {
    return result
            .map(
              (e) =>
                  (e as List)
                      .map((x) => OctezUshuaiaOperationMetadataHash.fromJson(x))
                      .toList(),
            )
            .toList()
        as List<List<OctezUshuaiaOperationMetadataHash>>;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/operation_metadata_hashes/{list_offset}
class OctezUshuaiaRequestOperationMetadataHashesListOffset
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaOperationMetadataHash>,
          List<dynamic>
        > {
  final String listOffset;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestOperationMetadataHashesListOffset({
    required this.listOffset,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/operation_metadata_hashes/$listOffset';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaOperationMetadataHash> onResponse(List<dynamic> result) {
    return result
        .map((e) => OctezUshuaiaOperationMetadataHash.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/operation_metadata_hashes/{list_offset}/{operation_offset}
class OctezUshuaiaRequestOperationMetadataHashesListOffsetOperationOffset
    extends OctezUshuaiaRequest<OctezUshuaiaUnistring, dynamic> {
  final String listOffset;
  final String operationOffset;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestOperationMetadataHashesListOffsetOperationOffset({
    required this.listOffset,
    required this.operationOffset,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/operation_metadata_hashes/$listOffset/$operationOffset';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaUnistring onResponse(dynamic result) {
    return OctezUshuaiaUnistring.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/operations
class OctezUshuaiaRequestOperations
    extends
        OctezUshuaiaRequest<List<List<OctezUshuaiaOperation>>, List<dynamic>> {
  final String version;
  final String? forceMetadata;
  final String? metadata;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestOperations({
    required this.version,
    this.forceMetadata,
    this.metadata,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/operations';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'version': version,
    'force_metadata': forceMetadata,
    'metadata': metadata,
  };

  @override
  List<List<OctezUshuaiaOperation>> onResponse(List<dynamic> result) {
    return result
            .map(
              (e) =>
                  (e as List)
                      .map((x) => OctezUshuaiaOperation.fromJson(x))
                      .toList(),
            )
            .toList()
        as List<List<OctezUshuaiaOperation>>;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/operations/{list_offset}
class OctezUshuaiaRequestOperationsListOffset
    extends OctezUshuaiaRequest<List<OctezUshuaiaOperation>, List<dynamic>> {
  final String listOffset;
  final String version;
  final String? forceMetadata;
  final String? metadata;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestOperationsListOffset({
    required this.listOffset,
    required this.version,
    this.forceMetadata,
    this.metadata,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/operations/$listOffset';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'version': version,
    'force_metadata': forceMetadata,
    'metadata': metadata,
  };

  @override
  List<OctezUshuaiaOperation> onResponse(List<dynamic> result) {
    return result.map((e) => OctezUshuaiaOperation.fromJson(e)).toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/operations/{list_offset}/{operation_offset}
class OctezUshuaiaRequestOperationsListOffsetOperationOffset
    extends OctezUshuaiaRequest<OctezUshuaiaOperation, dynamic> {
  final String listOffset;
  final String operationOffset;
  final String version;
  final String? forceMetadata;
  final String? metadata;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestOperationsListOffsetOperationOffset({
    required this.listOffset,
    required this.operationOffset,
    required this.version,
    this.forceMetadata,
    this.metadata,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/operations/$listOffset/$operationOffset';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'version': version,
    'force_metadata': forceMetadata,
    'metadata': metadata,
  };

  @override
  OctezUshuaiaOperation onResponse(dynamic result) {
    return OctezUshuaiaOperation.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/operations_metadata_hash
class OctezUshuaiaRequestOperationsMetadataHash
    extends OctezUshuaiaRequest<OctezUshuaiaUnistring, dynamic> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestOperationsMetadataHash({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/operations_metadata_hash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaUnistring onResponse(dynamic result) {
    return OctezUshuaiaUnistring.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/protocols
class OctezUshuaiaRequestProtocols
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseProtocols,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestProtocols({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/protocols';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseProtocols onResponse(Map<String, dynamic> result) {
    return OctezUshuaiaResponseProtocols.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/resulting_context_hash
class OctezUshuaiaRequestResultingContextHash
    extends OctezUshuaiaRequest<OctezUshuaiaUnistring, dynamic> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestResultingContextHash({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/resulting_context_hash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaUnistring onResponse(dynamic result) {
    return OctezUshuaiaUnistring.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/votes/ballot_list
class OctezUshuaiaRequestVotesBallotList
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseVotesBallotListItem>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestVotesBallotList({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/votes/ballot_list';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseVotesBallotListItem> onResponse(
    List<dynamic> result,
  ) {
    return result
        .map((e) => OctezUshuaiaResponseVotesBallotListItem.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/votes/ballots
class OctezUshuaiaRequestVotesBallots
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseVotesBallots,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestVotesBallots({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/votes/ballots';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseVotesBallots onResponse(Map<String, dynamic> result) {
    return OctezUshuaiaResponseVotesBallots.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/votes/current_period
class OctezUshuaiaRequestVotesCurrentPeriod
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseVotesCurrentPeriod,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestVotesCurrentPeriod({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/votes/current_period';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseVotesCurrentPeriod onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseVotesCurrentPeriod.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/votes/current_proposal
class OctezUshuaiaRequestVotesCurrentProposal
    extends OctezUshuaiaRequest<OctezUshuaiaProtocolHash?, dynamic> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestVotesCurrentProposal({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/votes/current_proposal';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaProtocolHash? onResponse(dynamic result) {
    if (result == null) return null;
    return OctezUshuaiaProtocolHash.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/votes/current_quorum
class OctezUshuaiaRequestVotesCurrentQuorum
    extends OctezUshuaiaRequest<int, int> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestVotesCurrentQuorum({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/votes/current_quorum';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int onResponse(int result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/votes/listings
class OctezUshuaiaRequestVotesListings
    extends
        OctezUshuaiaRequest<
          List<OctezUshuaiaResponseVotesListingsItem>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestVotesListings({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/votes/listings';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<OctezUshuaiaResponseVotesListingsItem> onResponse(List<dynamic> result) {
    return result
        .map((e) => OctezUshuaiaResponseVotesListingsItem.fromJson(e))
        .toList();
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/votes/proposal_count/{pkh}
class OctezUshuaiaRequestVotesProposalCountPkh
    extends OctezUshuaiaRequest<int, int> {
  final String pkh;
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestVotesProposalCountPkh({
    required this.pkh,
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/votes/proposal_count/$pkh';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  int onResponse(int result) {
    return result;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/votes/proposals
class OctezUshuaiaRequestVotesProposals
    extends
        OctezUshuaiaRequest<
          List<List<OctezUshuaiaResponseVotesProposalsItemItem>>,
          List<dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestVotesProposals({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/votes/proposals';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  List<List<OctezUshuaiaResponseVotesProposalsItemItem>> onResponse(
    List<dynamic> result,
  ) {
    return result
            .map(
              (e) =>
                  (e as List)
                      .map(
                        (x) =>
                            OctezUshuaiaResponseVotesProposalsItemItem.fromJson(
                              x,
                            ),
                      )
                      .toList(),
            )
            .toList()
        as List<List<OctezUshuaiaResponseVotesProposalsItemItem>>;
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/votes/successor_period
class OctezUshuaiaRequestVotesSuccessorPeriod
    extends
        OctezUshuaiaRequest<
          OctezUshuaiaResponseVotesCurrentPeriod,
          Map<String, dynamic>
        > {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestVotesSuccessorPeriod({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path => '/chains/$chainId/blocks/$blockId/votes/successor_period';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  OctezUshuaiaResponseVotesCurrentPeriod onResponse(
    Map<String, dynamic> result,
  ) {
    return OctezUshuaiaResponseVotesCurrentPeriod.fromJson(result);
  }
}

/// GET /chains/{chain_id}/blocks/{block_id}/votes/total_voting_power
class OctezUshuaiaRequestVotesTotalVotingPower
    extends OctezUshuaiaRequest<String, String> {
  final String chainId;
  final String blockId;

  const OctezUshuaiaRequestVotesTotalVotingPower({
    this.chainId = 'main',
    this.blockId = 'head',
  });

  @override
  String? get path =>
      '/chains/$chainId/blocks/$blockId/votes/total_voting_power';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}
