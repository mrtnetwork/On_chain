import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of current stake pools delegators.
/// https://blockfrost.dev/api/stake-pool-delegators
class BlockfrostRequestStakePoolDelegators extends BlockforestRequestParam<
    List<ADAPoolDelegatorInfoResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestStakePoolDelegators(this.poolId,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// Bech32 or hexadecimal pool ID.
  final String poolId;

  /// Stake pool delegators
  @override
  String get method => BlockfrostMethods.stakePoolDelegators.url;

  @override
  List<String> get pathParameters => [poolId];

  @override
  List<ADAPoolDelegatorInfoResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAPoolDelegatorInfoResponse.fromJson(e)).toList();
  }
}
