import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestBroadcastTxAsync extends NearNodeRequest<String, String> {
  final NearRpcRpcSendTransactionRequest args;
  const NearNodeRequestBroadcastTxAsync(this.args);
  @override
  String get method => "broadcast_tx_async";

  @override
  dynamic params() => args.toJson();

  @override
  ServiceReponseEncoding get responseEncoding => ServiceReponseEncoding.string;
}
