// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/assets/{asset-id}
class AlgoRestRequestGetAssetByID
    extends AlgoRestRequest<AlgoRestTypesAsset, Map<String, dynamic>> {
  final int assetId;

  const AlgoRestRequestGetAssetByID({required this.assetId});

  @override
  String get path => '/v2/assets/$assetId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesAsset onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesAsset.fromJson(result);
  }
}
