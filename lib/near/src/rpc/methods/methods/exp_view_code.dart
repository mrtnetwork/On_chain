import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalViewCode
    extends NearNodeRequest<NearRpcRpcViewCodeResponse, Map<String, dynamic>> {
  final NearRpcRpcViewCodeRequest args;
  const NearNodeRequestExperimentalViewCode(this.args);
  @override
  String get method => "EXPERIMENTAL_view_code";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcViewCodeResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcViewCodeResponse.fromJson(result);
  }
}
