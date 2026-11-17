import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalLightClientProof
    extends
        NearNodeRequest<
          NearRpcRpcLightClientExecutionProofResponse,
          Map<String, dynamic>
        > {
  final NearRpcRpcLightClientExecutionProofRequest args;
  const NearNodeRequestExperimentalLightClientProof(this.args);
  @override
  String get method => "EXPERIMENTAL_light_client_proof";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcLightClientExecutionProofResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return NearRpcRpcLightClientExecutionProofResponse.fromJson(result);
  }
}
