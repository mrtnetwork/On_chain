import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the active stake distribution for the epoch specified by stake pool.
/// https://blockfrost.dev/api/stake-distribution-by-pool
class BlockfrostRequestStakeDistributionByPool extends BlockforestRequestParam<
    List<ADAStakeDistributionResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestStakeDistributionByPool(
      {required this.epoch,
      required this.poolId,
      BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// Number of the epoch
  final int epoch;

  /// Stake pool ID to filter
  final String poolId;

  /// Stake distribution by pool
  @override
  String get method => BlockfrostMethods.stakeDistributionByPool.url;

  @override
  List<String> get pathParameters => [epoch.toString(), poolId];

  @override
  List<ADAStakeDistributionResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADAStakeDistributionResponse.fromJson(e, poolId: poolId))
        .toList();
  }
}
