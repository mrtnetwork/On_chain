import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalTxStatus
    extends
        NearNodeRequest<NearRpcRpcTransactionResponse, Map<String, dynamic>> {
  final NearRpcRpcTransactionStatusRequest args;
  const NearNodeRequestExperimentalTxStatus(this.args);
  @override
  String get method => "EXPERIMENTAL_tx_status";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcTransactionResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcTransactionResponse.fromJson(result);
  }
}
