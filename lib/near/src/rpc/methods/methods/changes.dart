import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestChanges
    extends
        NearNodeRequest<NearRpcRpcStateChangesInBlockResponse, Map<String, dynamic>> {
  final NearRpcRpcStateChangesInBlockByTypeRequest args;
  const NearNodeRequestChanges(this.args);
  @override
  String get method => "changes";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcStateChangesInBlockResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcStateChangesInBlockResponse.fromJson(result);
  }
}
