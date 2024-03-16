import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the list of blocks following a specific block.
/// https://blockfrost.dev/api/listing-of-next-blocks
class BlockfrostRequestListingOfNextBlocks extends BlockforestRequestParam<
    List<ADABlockResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestListingOfNextBlocks(this.hashOrNumber,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// 64-character case-sensitive hexadecimal string or block number.
  final dynamic hashOrNumber;

  /// Listing of next blocks
  @override
  String get method => BlockfrostMethods.listingOfNextBlocks.url;

  @override
  List<String> get pathParameters => [hashOrNumber];

  @override
  List<ADABlockResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADABlockResponse.fromJson(e)).toList();
  }
}
