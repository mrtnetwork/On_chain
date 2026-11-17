import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestClientConfig
    extends
        NearNodeRequest<NearRpcRpcClientConfigResponse, Map<String, dynamic>> {
  const NearNodeRequestClientConfig();
  @override
  String get method => "client_config";

  @override
  dynamic params() => null;

  @override
  NearRpcRpcClientConfigResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcClientConfigResponse.fromJson(result);
  }
}
