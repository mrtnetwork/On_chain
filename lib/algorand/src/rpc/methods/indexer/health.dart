// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /health
class AlgoIndexerRequestMakeHealthCheck
    extends AlgoIndexerRequest<AlgoRestTypesHealthCheck, Map<String, dynamic>> {
  const AlgoIndexerRequestMakeHealthCheck();

  @override
  String get path => '/health';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesHealthCheck onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesHealthCheck.fromJson(result);
  }
}
