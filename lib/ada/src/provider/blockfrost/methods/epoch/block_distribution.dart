import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the blocks minted for the epoch specified.
/// https://blockfrost.dev/api/block-distribution
class BlockfrostRequestBlockDistribution
    extends BlockFrostRequest<List<String>, List<dynamic>> {
  BlockfrostRequestBlockDistribution(this.epoch,
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// Number of the epoch
  final int epoch;

  /// Block distribution
  @override
  String get method => BlockfrostMethods.blockDistribution.url;

  @override
  List<String> get pathParameters => [epoch.toString()];

  @override
  List<String> onResonse(List result) {
    return result.cast();
  }
}
