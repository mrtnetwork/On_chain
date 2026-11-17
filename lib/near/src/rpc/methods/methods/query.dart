import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestQuery
    extends NearNodeRequest<NearRpcRpcQueryResponse, Map<String, dynamic>> {
  final NearRpcRpcQueryRequest args;
  const NearNodeRequestQuery(this.args);
  @override
  String get method => "query";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcQueryResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcQueryResponse.fromJson(result);
  }
}
