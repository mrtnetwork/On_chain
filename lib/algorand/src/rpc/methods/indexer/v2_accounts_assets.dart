// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/accounts/{account-id}/assets
class AlgoIndexerRequestLookupAccountAssets
    extends
        AlgoIndexerRequest<
          AlgoRestTypesAssetHoldingsResponse,
          Map<String, dynamic>
        > {
  final String accountId;
  final int? assetId;
  final bool? includeAll;
  final int? limit;
  final String? next;

  const AlgoIndexerRequestLookupAccountAssets({
    required this.accountId,
    this.assetId,
    this.includeAll,
    this.limit,
    this.next,
  });

  @override
  String get path => '/v2/accounts/$accountId/assets';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'asset-id': assetId?.toString(),
    'include-all': includeAll?.toString(),
    'limit': limit?.toString(),
    'next': next,
  };

  @override
  AlgoRestTypesAssetHoldingsResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesAssetHoldingsResponse.fromJson(result);
  }
}
