import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/models/latest_block_transaction_with_cbor_data.dart';

/// Return the transactions within the block, including CBOR representations.
class BlockfrostRequestBlockTransactionWithCborData extends BlockFrostRequest<
    List<LatestBlockTransactionWithCborDataResponse>,
    List<Map<String, dynamic>>> {
  BlockfrostRequestBlockTransactionWithCborData(this.hashOrNumber,
      {super.filter});

  /// 64-character case-sensitive hexadecimal string or block number
  final String hashOrNumber;

  /// Specific transaction
  @override
  String get method => BlockfrostMethods.blockTransactionsWithCborData.url;

  @override
  List<String> get pathParameters => [hashOrNumber];

  @override
  List<LatestBlockTransactionWithCborDataResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => LatestBlockTransactionWithCborDataResponse.fromJson(e))
        .toList();
  }
}
