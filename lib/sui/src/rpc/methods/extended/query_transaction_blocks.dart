import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Return list of transactions for a specified query criteria.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_querytransactionblocks)
class SuiRequestQueryTransactionBlocks extends SuiRequest<
    SuiApiPaginatedTransactionResponse, Map<String, dynamic>> {
  const SuiRequestQueryTransactionBlocks(
      {required this.query, this.cursor, this.limit, this.descendingOrder});

  /// The event query criteria.
  final SuiApiTransactionBlockResponseQuery query;

  /// An optional paging cursor. If provided, the query will start from the
  /// next item after the specified cursor. Default to start from the first item if not specified.
  final String? cursor;

  /// Maximum number of items per page
  final int? limit;

  /// Query result ordering, default to false (ascending order), oldest record first.
  final bool? descendingOrder;

  @override
  String get method => 'suix_queryTransactionBlocks';

  @override
  List<dynamic> toJson() {
    return [query.toJson(), cursor, limit, descendingOrder];
  }

  @override
  SuiApiPaginatedTransactionResponse onResonse(Map<String, dynamic> result) {
    return SuiApiPaginatedTransactionResponse.fromJson(result);
  }
}
