import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalProtocolConfig
    extends NearNodeRequest<NearRpcRpcProtocolConfigResponse, Map<String, dynamic>> {
  final NearRpcRpcProtocolConfigRequest args;
  const NearNodeRequestExperimentalProtocolConfig(this.args);
  @override
  String get method => "EXPERIMENTAL_protocol_config";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcProtocolConfigResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcProtocolConfigResponse.fromJson(result);
  }
}
