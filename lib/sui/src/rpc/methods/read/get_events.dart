import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return transaction events.
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_getevents)
class SuiRequestGetEvents
    extends SuiRequest<List<SuiApiEvent>, List<Map<String, dynamic>>> {
  const SuiRequestGetEvents({required this.transactionDigest});

  /// The event query criteria.
  final String transactionDigest;
  @override
  String get method => 'sui_getEvents';

  @override
  List<dynamic> toJson() {
    return [transactionDigest];
  }

  @override
  List<SuiApiEvent> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => SuiApiEvent.fromJson(e)).toList();
  }
}
