import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// List of stake pools blocks.
/// https://blockfrost.dev/api/stake-pool-blocks
class BlockfrostRequestStakePoolBlocks
    extends BlockFrostRequest<List<String>, List<dynamic>> {
  BlockfrostRequestStakePoolBlocks(this.poolId);

  /// Bech32 or hexadecimal pool ID.
  final String poolId;

  /// Stake pool blocks
  @override
  String get method => BlockfrostMethods.stakePoolBlocks.url;

  @override
  List<String> get pathParameters => [poolId];

  @override
  List<String> onResonse(List result) {
    return result.cast();
  }
}
