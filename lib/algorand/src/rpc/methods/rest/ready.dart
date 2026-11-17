// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';

class AlgoRestRequestGetReady extends AlgoRestRequest<String, String> {
  const AlgoRestRequestGetReady();

  @override
  String get path => '/ready';

  @override
  RequestMethod get requestMethod => RequestMethod.get;
}
