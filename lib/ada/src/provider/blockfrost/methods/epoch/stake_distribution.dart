import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the active stake distribution for the specified epoch.
/// https://blockfrost.dev/api/stake-distribution
class BlockfrostRequestStakeDistribution extends BlockforestRequestParam<
    List<ADAStakeDistributionResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestStakeDistribution(this.epoch,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// Number of the epoch
  final int epoch;

  /// Stake distribution
  @override
  String get method => BlockfrostMethods.stakeDistribution.url;

  @override
  List<String> get pathParameters => [epoch.toString()];

  @override
  List<ADAStakeDistributionResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result.map((e) => ADAStakeDistributionResponse.fromJson(e)).toList();
  }
}
