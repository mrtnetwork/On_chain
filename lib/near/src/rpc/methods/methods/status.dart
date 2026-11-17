import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestStatus
    extends NearNodeRequest<NearRpcRpcStatusResponse, Map<String, dynamic>> {
  const NearNodeRequestStatus();
  @override
  String get method => "status";

  @override
  dynamic params() => null;

  @override
  NearRpcRpcStatusResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcStatusResponse.fromJson(result);
  }
}
