import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalViewAccessKeyList
    extends
        NearNodeRequest<
          NearRpcRpcViewAccessKeyListResponse,
          Map<String, dynamic>
        > {
  final NearRpcRpcViewAccessKeyListRequest args;
  const NearNodeRequestExperimentalViewAccessKeyList(this.args);
  @override
  String get method => "EXPERIMENTAL_view_access_key_list";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcViewAccessKeyListResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcViewAccessKeyListResponse.fromJson(result);
  }
}
