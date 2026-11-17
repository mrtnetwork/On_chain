import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalSplitStorageInfo
    extends NearNodeRequest<NearRpcRpcSplitStorageInfoResponse, Map<String, dynamic>> {
  final NearRpcRpcSplitStorageInfoRequest args;
  const NearNodeRequestExperimentalSplitStorageInfo(this.args);
  @override
  String get method => "EXPERIMENTAL_split_storage_info";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcSplitStorageInfoResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcSplitStorageInfoResponse.fromJson(result);
  }
}
