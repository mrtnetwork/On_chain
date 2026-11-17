import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestLightClientProof
    extends
        NearNodeRequest<
          NearRpcRpcLightClientExecutionProofResponse,
          Map<String, dynamic>
        > {
  final NearRpcRpcLightClientExecutionProofRequest args;
  const NearNodeRequestLightClientProof(this.args);
  @override
  String get method => "light_client_proof";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcLightClientExecutionProofResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return NearRpcRpcLightClientExecutionProofResponse.fromJson(result);
  }
}
