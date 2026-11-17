// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/blocks/{round}/logs
class AlgoRestRequestGetBlockLogs
    extends
        AlgoRestRequest<AlgoRestTypesBlockLogsResponse, Map<String, dynamic>> {
  final BigInt round;

  const AlgoRestRequestGetBlockLogs({required this.round});

  @override
  String get path => '/v2/blocks/$round/logs';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesBlockLogsResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesBlockLogsResponse.fromJson(result);
  }
}
