import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the list of epochs following a specific epoch.
/// https://blockfrost.dev/api/listing-of-next-epochs
class BlockfrostRequestListingOfNextEpoches extends BlockFrostRequest<
    List<ADAEpochInfoResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestListingOfNextEpoches(this.epoch,
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// Number of the requested epoch.
  final int epoch;

  /// Listing of next epochs
  @override
  String get method => BlockfrostMethods.listingOfNextEpoches.url;

  @override
  List<String> get pathParameters => [epoch.toString()];

  @override
  List<ADAEpochInfoResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAEpochInfoResponse.fromJson(e)).toList();
  }
}
