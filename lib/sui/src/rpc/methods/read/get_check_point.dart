import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return a checkpoint
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getcheckpoint)
class SuiRequestGetCheckpoint
    extends SuiRequest<SuiApiCheckPoint, Map<String, dynamic>> {
  const SuiRequestGetCheckpoint(this.checkpointId);
  final String checkpointId;
  @override
  String get method => 'sui_getCheckpoint';

  @override
  List<dynamic> toJson() {
    return [checkpointId];
  }

  @override
  SuiApiCheckPoint onResonse(Map<String, dynamic> result) {
    return SuiApiCheckPoint.fromJson(result);
  }
}
