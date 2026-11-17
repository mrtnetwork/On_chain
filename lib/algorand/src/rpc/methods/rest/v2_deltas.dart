// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';

import 'package:on_chain/algorand/src/types/types.dart';

/// GET /v2/deltas/{round}
class AlgoRestRequestGetLedgerStateDelta
    extends AlgoRestRequest<AlgoTypesLedgerStateDelta, Map<String, dynamic>> {
  final BigInt round;
  @override
  final RequestFormat responseFormat = RequestFormat.msgpack;

  const AlgoRestRequestGetLedgerStateDelta({required this.round});

  @override
  String get path => '/v2/deltas/$round';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'format': responseFormat.name};

  @override
  AlgoTypesLedgerStateDelta onResponse(Map<String, dynamic> result) {
    return AlgoTypesLedgerStateDelta.fromJson(result);
  }
}
