import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the list of epochs preceding a specific epoch.
/// https://blockfrost.dev/api/listing-of-previous-epochs
class BlockfrostRequestListingOfPreviousEpoches extends BlockforestRequestParam<
    List<ADAEpochInfoResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestListingOfPreviousEpoches(this.epoch,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// Number of the epoch
  final int epoch;

  /// Listing of previous epochs
  @override
  String get method => BlockfrostMethods.listingOfPreviousEpoches.url;

  @override
  List<String> get pathParameters => [epoch.toString()];

  @override
  List<ADAEpochInfoResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAEpochInfoResponse.fromJson(e)).toList();
  }
}
