// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /genesis
class AlgoRestRequestGetGenesis
    extends AlgoRestRequest<AlgoRestTypesGenesis, Map<String, dynamic>> {
  const AlgoRestRequestGetGenesis();

  @override
  String get path => '/genesis';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesGenesis onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesGenesis.fromJson(result);
  }
}
