import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalViewState
    extends NearNodeRequest<NearRpcRpcViewStateResponse, Map<String, dynamic>> {
  final NearRpcRpcViewStateRequest args;
  const NearNodeRequestExperimentalViewState(this.args);
  @override
  String get method => "EXPERIMENTAL_view_state";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcViewStateResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcViewStateResponse.fromJson(result);
  }
}
