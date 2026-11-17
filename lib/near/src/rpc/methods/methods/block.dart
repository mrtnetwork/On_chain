import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestBlock
    extends NearNodeRequest<NearRpcRpcBlockResponse, Map<String, dynamic>> {
  final NearRpcRpcBlockRequest args;
  const NearNodeRequestBlock(this.args);
  @override
  String get method => "block";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcBlockResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcBlockResponse.fromJson(result);
  }
}
