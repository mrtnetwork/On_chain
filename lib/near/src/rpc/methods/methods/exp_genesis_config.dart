import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalGenesisConfig
    extends NearNodeRequest<NearRpcGenesisConfig, Map<String, dynamic>> {
  const NearNodeRequestExperimentalGenesisConfig();
  @override
  String get method => "EXPERIMENTAL_genesis_config";

  @override
  dynamic params() => null;

  @override
  NearRpcGenesisConfig onResponse(Map<String, dynamic> result) {
    return NearRpcGenesisConfig.fromJson(result);
  }
}
