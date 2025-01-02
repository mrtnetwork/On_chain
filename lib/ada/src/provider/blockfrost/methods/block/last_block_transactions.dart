import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the transactions within the latest block.
/// https://blockfrost.dev/api/latest-block-transactions
class BlockfrostRequestLastBlockTransactions
    extends BlockFrostRequest<List<String>, List<dynamic>> {
  BlockfrostRequestLastBlockTransactions(
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// Latest block transactions
  @override
  String get method => BlockfrostMethods.lastBlockTransactions.url;

  @override
  List<String> get pathParameters => [];

  @override
  List<String> onResonse(List result) {
    return result.cast();
  }
}
