import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalCallFunction
    extends NearNodeRequest<NearRpcRpcCallFunctionResponse, Map<String, dynamic>> {
  final NearRpcRpcCallFunctionRequest args;
  const NearNodeRequestExperimentalCallFunction(this.args);
  @override
  String get method => "EXPERIMENTAL_call_function";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcCallFunctionResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcCallFunctionResponse.fromJson(result);
  }
}
