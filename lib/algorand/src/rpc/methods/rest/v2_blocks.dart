// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/types/types.dart';

/// GET /v2/blocks/{round}
class AlgoRestRequestGetBlock
    extends AlgoRestRequest<AlgoTypesBlock, Map<String, dynamic>> {
  final BigInt round;
  final bool? headerOnly;
  @override
  final RequestFormat responseFormat = RequestFormat.msgpack;

  const AlgoRestRequestGetBlock({required this.round, this.headerOnly});

  @override
  String get path => '/v2/blocks/$round';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'header-only': headerOnly?.toString(),
    'format': responseFormat.name,
  };

  @override
  AlgoTypesBlock onResponse(Map<String, dynamic> result) {
    return AlgoTypesBlock.deserializeJson(result.valueEnsureAsMap("block"));
  }
}
