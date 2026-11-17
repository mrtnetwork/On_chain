import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestSendTx
    extends NearNodeRequest<NearRpcRpcTransactionResponse, Map<String, dynamic>> {
  final NearRpcRpcSendTransactionRequest args;
  const NearNodeRequestSendTx(this.args);
  @override
  String get method => "send_tx";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcTransactionResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcTransactionResponse.fromJson(result);
  }
}
