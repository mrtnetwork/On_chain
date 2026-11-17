import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalViewAccount
    extends
        NearNodeRequest<NearRpcRpcViewAccountResponse, Map<String, dynamic>> {
  final NearRpcRpcViewAccountRequest args;
  const NearNodeRequestExperimentalViewAccount(this.args);
  @override
  String get method => "EXPERIMENTAL_view_account";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcViewAccountResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcViewAccountResponse.fromJson(result);
  }
}
