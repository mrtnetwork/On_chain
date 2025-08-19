import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/models/latest_block_transaction_with_cbor_data.dart';

/// Return content of the requested transaction.
/// https://blockfrost.dev/api/specific-transaction
class BlockfrostRequestLatestBlockTransactionWithCborData
    extends BlockFrostRequest<List<LatestBlockTransactionWithCborDataResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestLatestBlockTransactionWithCborData({super.filter});

  /// Specific transaction
  @override
  String get method =>
      BlockfrostMethods.latestBlockTransactionsWithCborData.url;

  @override
  List<String> get pathParameters => [];

  @override
  List<LatestBlockTransactionWithCborDataResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => LatestBlockTransactionWithCborDataResponse.fromJson(e))
        .toList();
  }
}
