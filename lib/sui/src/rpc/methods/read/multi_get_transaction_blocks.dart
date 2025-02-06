import 'package:on_chain/sui/src/rpc/core/core.dart';
import 'package:on_chain/sui/src/rpc/models/types/types.dart';

/// Returns an ordered list of transaction responses The method will throw an error if
/// the input contains any duplicate or the input size exceeds QUERY_MAX_RESULT_LIMIT
/// [sui documation](https://docs.sui.io/sui-api-ref#sui_multigettransactionblocks)
class SuiRequestMultiGetTransactionBlocks extends SuiRequest<
    List<SuiApiTransactionBlockResponse>, List<Map<String, dynamic>>> {
  const SuiRequestMultiGetTransactionBlocks(
      {required this.digests, this.options});

  /// A list of transaction digests.
  final List<String> digests;

  /// Config options to control which fields to fetch
  final SuiApiTransactionBlockResponseOptions? options;

  @override
  String get method => 'sui_multiGetTransactionBlocks';

  @override
  List<dynamic> toJson() {
    return [digests, options?.toJson()];
  }

  @override
  List<SuiApiTransactionBlockResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => SuiApiTransactionBlockResponse.fromJson(e))
        .toList();
  }
}
