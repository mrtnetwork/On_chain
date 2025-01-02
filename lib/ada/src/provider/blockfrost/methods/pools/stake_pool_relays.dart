import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Relays of a stake pool.
/// https://blockfrost.dev/api/stake-pool-relays
class BlockfrostRequestStakePoolRelays extends BlockFrostRequest<
    List<ADAStakePoolRelayInfoResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestStakePoolRelays(this.poolId);

  /// Bech32 or hexadecimal pool ID.
  final String poolId;

  /// Stake pool relays
  @override
  String get method => BlockfrostMethods.stakePoolRelays.url;

  @override
  List<String> get pathParameters => [poolId];

  @override
  List<ADAStakePoolRelayInfoResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result
        .map((e) => ADAStakePoolRelayInfoResponse.fromJson(e))
        .toList();
  }
}
