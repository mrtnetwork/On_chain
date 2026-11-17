// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';

/// GET /swagger.json
class AlgoRestRequestSwaggerJSON extends AlgoRestRequest<String, String> {
  const AlgoRestRequestSwaggerJSON();

  @override
  String get path => '/swagger.json';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}
