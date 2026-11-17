// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/types/types.dart';

/// GET /v2/deltas/txn/group/{id}
class AlgoRestRequestGetLedgerStateDeltaForTransactionGroup
    extends AlgoRestRequest<AlgoTypesLedgerStateDelta, Map<String, dynamic>> {
  final String id;

  const AlgoRestRequestGetLedgerStateDeltaForTransactionGroup({
    required this.id,
  });
  @override
  final RequestFormat responseFormat = RequestFormat.msgpack;
  @override
  String get path => '/v2/deltas/txn/group/$id';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {'format': responseFormat.name};

  @override
  AlgoTypesLedgerStateDelta onResponse(Map<String, dynamic> result) {
    return AlgoTypesLedgerStateDelta.fromJson(result);
  }
}

/// GET /v2/deltas/txn/group/{id}
class AlgoRestRequestGetLedgerStateDeltaForRound
    extends AlgoRestRequest<AlgoTypesLedgerStateDelta, Map<String, dynamic>> {
  final BigInt round;

  const AlgoRestRequestGetLedgerStateDeltaForRound({required this.round});

  @override
  String get path => '/v2/deltas/$round/txn/group';

  @override
  RequestMethod get requestMethod => RequestMethod.get;
  @override
  final RequestFormat responseFormat = RequestFormat.msgpack;

  @override
  Map<String, String?> get queryParameters => {'format': responseFormat.name};

  @override
  AlgoTypesLedgerStateDelta onResponse(Map<String, dynamic> result) {
    return AlgoTypesLedgerStateDelta.fromJson(result);
  }
}
