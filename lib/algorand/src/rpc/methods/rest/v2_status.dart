// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/status
class AlgoRestRequestGetStatus
    extends
        AlgoRestRequest<AlgoRestTypesNodeStatusResponse, Map<String, dynamic>> {
  const AlgoRestRequestGetStatus();

  @override
  String get path => '/v2/status';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesNodeStatusResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesNodeStatusResponse.fromJson(result);
  }
}
