import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestTx
    extends
        NearNodeRequest<NearRpcRpcTransactionResponse, Map<String, dynamic>> {
  final NearRpcRpcTransactionStatusRequest args;
  const NearNodeRequestTx(this.args);
  @override
  String get method => "tx";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcTransactionResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcTransactionResponse.fromJson(result);
  }
}
