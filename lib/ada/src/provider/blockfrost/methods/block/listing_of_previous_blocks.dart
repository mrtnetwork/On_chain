import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the list of blocks preceding a specific block.
/// https://blockfrost.dev/api/listing-of-previous-blocks
class BlockfrostRequestListingOfPreviousBlocks extends BlockFrostRequest<
    List<ADABlockResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestListingOfPreviousBlocks(this.hashOrNumber,
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// 64-character case-sensitive hexadecimal string or block number.
  final dynamic hashOrNumber;

  /// Listing of previous blocks
  @override
  String get method => BlockfrostMethods.listingOfPreviousBlocks.url;

  @override
  List<String> get pathParameters => [hashOrNumber];

  @override
  List<ADABlockResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADABlockResponse.fromJson(e)).toList();
  }
}
