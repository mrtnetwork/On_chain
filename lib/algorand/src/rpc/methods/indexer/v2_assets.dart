// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/assets
class AlgoIndexerRequestSearchForAssets
    extends
        AlgoIndexerRequest<AlgoRestTypesAssetsResponse, Map<String, dynamic>> {
  final bool? includeAll;
  final int? limit;
  final String? next;
  final String? creator;
  final String? name;
  final String? unit;
  final int? assetId;

  const AlgoIndexerRequestSearchForAssets({
    this.includeAll,
    this.limit,
    this.next,
    this.creator,
    this.name,
    this.unit,
    this.assetId,
  });

  @override
  String get path => '/v2/assets';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'include-all': includeAll?.toString(),
    'limit': limit?.toString(),
    'next': next,
    'creator': creator,
    'name': name,
    'unit': unit,
    'asset-id': assetId?.toString(),
  };

  @override
  AlgoRestTypesAssetsResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesAssetsResponse.fromJson(result);
  }
}

/// GET /v2/assets/{asset-id}
class AlgoIndexerRequestLookupAssetByID
    extends AlgoIndexerRequest<AlgoRestTypesAsset, Map<String, dynamic>> {
  final int assetId;
  final bool? includeAll;

  const AlgoIndexerRequestLookupAssetByID({
    required this.assetId,
    this.includeAll,
  });

  @override
  String get path => '/v2/assets/$assetId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'include-all': includeAll?.toString(),
  };

  @override
  AlgoRestTypesAsset onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesAsset.fromJson(result);
  }
}
