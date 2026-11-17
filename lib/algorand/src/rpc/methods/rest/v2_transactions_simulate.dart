// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/rpc/core/core.dart';
import 'package:on_chain/algorand/src/rpc/models/types.dart';

/// POST /v2/transactions/simulate
class AlgoRestRequestSimulateTransaction
    extends
        AlgoRestRequest<AlgoRestTypesSimulateResponse, Map<String, dynamic>> {
  final AlgoRestTypesSimulateRequest simulate;

  const AlgoRestRequestSimulateTransaction({required this.simulate});

  @override
  String get path => '/v2/transactions/simulate';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, String?> get queryParameters => {};

  @override
  List<int> body() {
    final data = MsgPackAnyLayout().serialize(simulate.toJson());
    return data;
  }

  @override
  AlgoRestTypesSimulateResponse onResponse(Map<String, dynamic> result) {
    return AlgoRestTypesSimulateResponse.fromJson(result);
  }
}
