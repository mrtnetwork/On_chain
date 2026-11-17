import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalLightClientBlockProof
    extends
        NearNodeRequest<
          NearRpcRpcLightClientBlockProofResponse,
          Map<String, dynamic>
        > {
  final NearRpcRpcLightClientBlockProofRequest args;
  const NearNodeRequestExperimentalLightClientBlockProof(this.args);
  @override
  String get method => "EXPERIMENTAL_light_client_block_proof";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcLightClientBlockProofResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return NearRpcRpcLightClientBlockProofResponse.fromJson(result);
  }
}
