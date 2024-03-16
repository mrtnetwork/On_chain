import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the transactions within the block.
/// https://blockfrost.dev/api/block-transactions
class BlockfrostRequestBlockTransactions
    extends BlockforestRequestParam<List<String>, List<dynamic>> {
  BlockfrostRequestBlockTransactions(this.hashOrNumber,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// 64-character case-sensitive hexadecimal string or block number.
  final dynamic hashOrNumber;

  /// Block transactions
  @override
  String get method => BlockfrostMethods.blockTransactions.url;

  @override
  List<String> get pathParameters => [hashOrNumber.toString()];

  @override
  List<String> onResonse(List result) {
    return result.cast();
  }
}
