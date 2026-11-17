import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestBlockEffects
    extends
        NearNodeRequest<
          NearRpcRpcStateChangesInBlockByTypeResponse,
          Map<String, dynamic>
        > {
  final NearRpcRpcStateChangesInBlockRequest args;
  const NearNodeRequestBlockEffects(this.args);
  @override
  String get method => "block_effects";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcStateChangesInBlockByTypeResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcStateChangesInBlockByTypeResponse.fromJson(result);
  }
}
