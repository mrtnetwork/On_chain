// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/accounts/{address}/assets
class AlgoRestRequestAccountAssetsInformation
    extends
        AlgoRestRequest<
          AlgoRestTypesAccountAssetsInformationResponse,
          Map<String, dynamic>
        > {
  final String address;
  final int? limit;
  final String? next;

  const AlgoRestRequestAccountAssetsInformation({
    required this.address,
    this.limit,
    this.next,
  });

  @override
  String get path => '/v2/accounts/$address/assets';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit?.toString(),
    'next': next,
  };

  @override
  AlgoRestTypesAccountAssetsInformationResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return AlgoRestTypesAccountAssetsInformationResponse.fromJson(result);
  }
}

/// GET /v2/accounts/{address}/assets/{asset-id}
class AlgoRestRequestAccountAssetInformation
    extends
        AlgoRestRequest<
          AlgoRestTypesAccountAssetResponse,
          Map<String, dynamic>
        > {
  final String address;
  final BigInt assetId;
  @override
  final RequestFormat? responseFormat;

  const AlgoRestRequestAccountAssetInformation({
    required this.address,
    required this.assetId,
    this.responseFormat,
  });

  @override
  String get path => '/v2/accounts/$address/assets/$assetId';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'format': responseFormat?.name};

  @override
  AlgoRestTypesAccountAssetResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesAccountAssetResponse.fromJson(result);
  }
}
