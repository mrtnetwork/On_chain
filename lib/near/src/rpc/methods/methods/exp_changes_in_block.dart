import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalChangesInBlock
    extends
        NearNodeRequest<
          NearRpcRpcStateChangesInBlockByTypeResponse,
          Map<String, dynamic>
        > {
  final NearRpcRpcStateChangesInBlockRequest args;
  const NearNodeRequestExperimentalChangesInBlock(this.args);
  @override
  String get method => "EXPERIMENTAL_changes_in_block";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcStateChangesInBlockByTypeResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcStateChangesInBlockByTypeResponse.fromJson(result);
  }
}
