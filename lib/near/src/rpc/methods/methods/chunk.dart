import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestChunk
    extends NearNodeRequest<NearRpcRpcChunkResponse, Map<String, dynamic>> {
  final NearRpcRpcChunkRequest args;
  const NearNodeRequestChunk(this.args);
  @override
  String get method => "chunk";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcChunkResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcChunkResponse.fromJson(result);
  }
}
