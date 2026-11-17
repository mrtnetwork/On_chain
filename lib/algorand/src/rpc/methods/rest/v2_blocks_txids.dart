// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/blocks/{round}/txids
class AlgoRestRequestGetBlockTxids
    extends
        AlgoRestRequest<AlgoRestTypesBlockTxidsResponse, Map<String, dynamic>> {
  final BigInt round;

  const AlgoRestRequestGetBlockTxids({required this.round});

  @override
  String get path => '/v2/blocks/$round/txids';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesBlockTxidsResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesBlockTxidsResponse.fromJson(result);
  }
}
