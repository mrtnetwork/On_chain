import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestValidators
    extends NearNodeRequest<NearRpcRpcValidatorResponse, Map<String, dynamic>> {
  final NearRpcRpcValidatorRequest args;
  const NearNodeRequestValidators(this.args);
  @override
  String get method => "validators";

  @override
  dynamic params() {
    return {"latest": null};
  }

  @override
  NearRpcRpcValidatorResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcValidatorResponse.fromJson(result);
  }
}
