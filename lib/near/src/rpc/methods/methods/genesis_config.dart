import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestGenesisConfig
    extends NearNodeRequest<NearRpcGenesisConfig, Map<String, dynamic>> {
  const NearNodeRequestGenesisConfig();
  @override
  String get method => "genesis_config";

  @override
  dynamic params() => null;

  @override
  NearRpcGenesisConfig onResponse(Map<String, dynamic> result) {
    return NearRpcGenesisConfig.fromJson(result);
  }
}
