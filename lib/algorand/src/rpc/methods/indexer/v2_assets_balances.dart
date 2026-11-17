// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/assets/{asset-id}/balances
class AlgoIndexerRequestLookupAssetBalances
    extends
        AlgoIndexerRequest<
          AlgoRestTypesAssetBalancesResponse,
          Map<String, dynamic>
        > {
  final bool? includeAll;
  final int? limit;
  final String? next;
  final int? currencyGreaterThan;
  final int? currencyLessThan;
  final int assetId;

  const AlgoIndexerRequestLookupAssetBalances({
    this.includeAll,
    this.limit,
    this.next,
    this.currencyGreaterThan,
    this.currencyLessThan,
    required this.assetId,
  });

  @override
  String get path => '/v2/assets/$assetId/balances';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'include-all': includeAll?.toString(),
    'limit': limit?.toString(),
    'next': next,
    'currency-greater-than': currencyGreaterThan?.toString(),
    'currency-less-than': currencyLessThan?.toString(),
  };

  @override
  AlgoRestTypesAssetBalancesResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesAssetBalancesResponse.fromJson(result);
  }
}
