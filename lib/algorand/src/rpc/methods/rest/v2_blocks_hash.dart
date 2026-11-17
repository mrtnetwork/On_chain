// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/blocks/{round}/hash
class AlgoRestRequestGetBlockHash
    extends
        AlgoRestRequest<AlgoRestTypesBlockHashResponse, Map<String, dynamic>> {
  final BigInt round;

  const AlgoRestRequestGetBlockHash({required this.round});

  @override
  String get path => '/v2/blocks/$round/hash';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesBlockHashResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesBlockHashResponse.fromJson(result);
  }
}
