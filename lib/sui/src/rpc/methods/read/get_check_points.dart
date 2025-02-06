import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return paginated list of checkpoints
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getcheckpoints)
class SuiRequestGetCheckpoints extends SuiRequest<
    SuiApiPaginatedCheckPointResponse, Map<String, dynamic>> {
  const SuiRequestGetCheckpoints(
      {required this.descendingOrder,
      required SuiApiRequestPagination super.pagination});
  final bool descendingOrder;
  @override
  String get method => 'sui_getCheckpoints';

  @override
  List<dynamic> toJson() {
    return [...super.pagination?.toJson() ?? [], descendingOrder];
  }

  @override
  SuiApiPaginatedCheckPointResponse onResonse(Map<String, dynamic> result) {
    return SuiApiPaginatedCheckPointResponse.fromJson(result);
  }
}
