import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return list of addresses affected in the specified block with additional
/// information, sorted by the bech32 address, ascending.
/// https://blockfrost.dev/api/addresses-affected-in-a-specific-block
class BlockfrostRequestAddressesAffectedInASpecificBlock
    extends BlockforestRequestParam<List<ADABlockAddressTransactionsResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestAddressesAffectedInASpecificBlock(this.hashOrBlock,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// 64-character case-sensitive hexadecimal string or block number.
  final dynamic hashOrBlock;

  /// Addresses affected in a specific block
  @override
  String get method => BlockfrostMethods.addressesAffectedInASpecificBlock.url;

  @override
  List<String> get pathParameters => [hashOrBlock.toString()];

  @override
  List<ADABlockAddressTransactionsResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADABlockAddressTransactionsResponse.fromJson(e))
        .toList();
  }
}
