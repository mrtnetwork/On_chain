import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalCongestionLevel
    extends
        NearNodeRequest<
          NearRpcRpcCongestionLevelResponse,
          Map<String, dynamic>
        > {
  final NearRpcRpcCongestionLevelRequest args;
  const NearNodeRequestExperimentalCongestionLevel(this.args);
  @override
  String get method => "EXPERIMENTAL_congestion_level";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcCongestionLevelResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcCongestionLevelResponse.fromJson(result);
  }
}
