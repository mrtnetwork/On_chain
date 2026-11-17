// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// GET /v2/transactions/params
class AlgoRestRequestTransactionParams
    extends
        AlgoRestRequest<
          AlgoRestTypesTransactionParametersResponse,
          Map<String, dynamic>
        > {
  const AlgoRestRequestTransactionParams();

  @override
  String get path => '/v2/transactions/params';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AlgoRestTypesTransactionParametersResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return AlgoRestTypesTransactionParametersResponse.fromJson(result);
  }
}
