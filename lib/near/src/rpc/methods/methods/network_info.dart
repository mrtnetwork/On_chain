import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestNetworkInfo
    extends NearNodeRequest<NearRpcRpcNetworkInfoResponse, Map<String, dynamic>> {
  const NearNodeRequestNetworkInfo();
  @override
  String get method => "network_info";

  @override
  dynamic params() => null;

  @override
  NearRpcRpcNetworkInfoResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcNetworkInfoResponse.fromJson(result);
  }
}
