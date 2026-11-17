import 'package:blockchain_utils/service/models/params.dart';
import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestExperimentalMaintenanceWindows
    extends NearNodeRequest<List<NearRpcRangeOfUint64>, List<Map<String, dynamic>>> {
  final NearRpcRpcMaintenanceWindowsRequest args;
  const NearNodeRequestExperimentalMaintenanceWindows(this.args);
  @override
  String get method => "EXPERIMENTAL_maintenance_windows";

  @override
  dynamic params() => args.toJson();

  @override
  List<NearRpcRangeOfUint64> onResponse(List<Map<String, dynamic>> result) {
    return result.map((e) => NearRpcRangeOfUint64.fromJson(e)).toList();
  }

  @override
  ServiceReponseEncoding get responseEncoding =>
      ServiceReponseEncoding.listOfMap;
}
