import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return list of events for a specified query criteria.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_queryevents)
class SuiRequestQueryEvents
    extends SuiRequest<SuiApiQueryEventsRepose, Map<String, dynamic>> {
  const SuiRequestQueryEvents(
      {required this.query, this.cursor, this.limit, this.descendingOrder});

  /// The event query criteria.
  final SuiApiEventFilter query;

  /// Optional paging cursor
  final SuiApiEventId? cursor;

  /// Maximum number of items per page
  final int? limit;

  /// Query result ordering, default to false (ascending order), oldest record first.
  final bool? descendingOrder;

  @override
  String get method => 'suix_queryEvents';

  @override
  List<dynamic> toJson() {
    return [query.toJson(), cursor?.toJson(), limit, descendingOrder];
  }

  @override
  SuiApiQueryEventsRepose onResonse(Map<String, dynamic> result) {
    return SuiApiQueryEventsRepose.fromJson(result);
  }
}
