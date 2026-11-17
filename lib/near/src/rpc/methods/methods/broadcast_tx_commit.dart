import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestBroadcastTxCommit
    extends
        NearNodeRequest<NearRpcRpcTransactionResponse, Map<String, dynamic>> {
  final NearRpcRpcSendTransactionRequest args;
  const NearNodeRequestBroadcastTxCommit(this.args);
  @override
  String get method => "broadcast_tx_commit";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcTransactionResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcTransactionResponse.fromJson(result);
  }
}
