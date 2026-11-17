// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/stateproofs/{round}
class AlgoRestRequestGetStateProof
    extends AlgoRestRequest<AlgoRestTypesStateProof, Map<String, dynamic>> {
  final BigInt round;

  const AlgoRestRequestGetStateProof({required this.round});

  @override
  String get path => '/v2/stateproofs/$round';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesStateProof onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesStateProof.fromJson(result);
  }
}
