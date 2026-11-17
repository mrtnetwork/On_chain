import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestNextLightClientBlock
    extends
        NearNodeRequest<
          NearRpcRpcLightClientNextBlockResponse,
          Map<String, dynamic>
        > {
  final NearRpcRpcLightClientNextBlockRequest args;
  const NearNodeRequestNextLightClientBlock(this.args);
  @override
  String get method => "next_light_client_block";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcLightClientNextBlockResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return NearRpcRpcLightClientNextBlockResponse.fromJson(result);
  }
}
