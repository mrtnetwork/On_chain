import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalViewAccessKey
    extends NearNodeRequest<NearRpcRpcViewAccessKeyResponse, Map<String, dynamic>> {
  final NearRpcRpcViewAccessKeyRequest args;
  const NearNodeRequestExperimentalViewAccessKey(this.args);
  @override
  String get method => "EXPERIMENTAL_view_access_key";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcViewAccessKeyResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcViewAccessKeyResponse.fromJson(result);
  }
}
