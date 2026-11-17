import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalChanges
    extends
        NearNodeRequest<
          NearRpcRpcStateChangesInBlockResponse,
          Map<String, dynamic>
        > {
  final NearRpcRpcStateChangesInBlockByTypeRequest args;
  const NearNodeRequestExperimentalChanges(this.args);
  @override
  String get method => "EXPERIMENTAL_changes";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcStateChangesInBlockResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return NearRpcRpcStateChangesInBlockResponse.fromJson(result);
  }
}
