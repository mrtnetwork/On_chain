import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalReceipt
    extends NearNodeRequest<NearRpcRpcReceiptResponse, Map<String, dynamic>> {
  final NearRpcRpcReceiptRequest args;
  const NearNodeRequestExperimentalReceipt(this.args);
  @override
  String get method => "EXPERIMENTAL_receipt";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcReceiptResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcReceiptResponse.fromJson(result);
  }
}
