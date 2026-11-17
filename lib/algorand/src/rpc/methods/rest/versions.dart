// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /versions
class AlgoRestRequestGetVersion
    extends AlgoRestRequest<AlgoRestTypesVersion, Map<String, dynamic>> {
  const AlgoRestRequestGetVersion();

  @override
  String get path => '/versions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesVersion onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesVersion.fromJson(result);
  }
}
