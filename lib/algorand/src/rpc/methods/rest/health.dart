// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';

class AlgoRestRequestHealthCheck extends AlgoRestRequest<dynamic, dynamic> {
  const AlgoRestRequestHealthCheck();

  @override
  String get path => '/health';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}
