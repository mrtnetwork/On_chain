// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/blocks/{round}/lightheader/proof
class AlgoRestRequestGetLightBlockHeaderProof
    extends
        AlgoRestRequest<
          AlgoRestTypesLightBlockHeaderProof,
          Map<String, dynamic>
        > {
  final BigInt round;

  const AlgoRestRequestGetLightBlockHeaderProof({required this.round});

  @override
  String get path => '/v2/blocks/$round/lightheader/proof';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesLightBlockHeaderProof onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesLightBlockHeaderProof.fromJson(result);
  }
}
