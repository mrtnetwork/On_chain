import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// History of stake pool parameters over epochs.
/// https://blockfrost.dev/api/stake-pool-history
class BlockfrostRequestStakePoolHistory extends BlockFrostRequest<
    List<ADAPoolEpochInfoResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestStakePoolHistory(this.poolId,
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// Bech32 or hexadecimal pool ID.
  final String poolId;

  /// Stake pool history
  @override
  String get method => BlockfrostMethods.stakePoolHistory.url;

  @override
  List<String> get pathParameters => [poolId];

  @override
  List<ADAPoolEpochInfoResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAPoolEpochInfoResponse.fromJson(e)).toList();
  }
}
