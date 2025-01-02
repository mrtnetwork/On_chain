import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the block minted for the epoch specified by stake pool.
/// https://blockfrost.dev/api/block-distribution-by-pool
class BlockfrostRequestBlockDistributionByPool
    extends BlockFrostRequest<List<String>, List<dynamic>> {
  BlockfrostRequestBlockDistributionByPool(
      {required this.epoch,
      required this.poolId,
      BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// Number of the epoch
  final int epoch;

  /// Stake pool ID to filter
  final String poolId;

  /// Block distribution by pool
  @override
  String get method => BlockfrostMethods.blockDistributionByPool.url;

  @override
  List<String> get pathParameters => [epoch.toString(), poolId];

  @override
  List<String> onResonse(List result) {
    return result.cast();
  }
}
