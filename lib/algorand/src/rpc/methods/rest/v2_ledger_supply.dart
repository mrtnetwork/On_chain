// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/ledger/supply
class AlgoRestRequestGetSupply
    extends AlgoRestRequest<AlgoRestTypesSupplyResponse, Map<String, dynamic>> {
  const AlgoRestRequestGetSupply();

  @override
  String get path => '/v2/ledger/supply';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesSupplyResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesSupplyResponse.fromJson(result);
  }
}
