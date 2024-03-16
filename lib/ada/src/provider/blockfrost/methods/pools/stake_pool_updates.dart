import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of certificate updates to the stake pool.
/// https://blockfrost.dev/api/stake-pool-updates
class BlockfrostRequestStakePoolUpdates extends BlockforestRequestParam<
    List<ADAStakePoolUpdateResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestStakePoolUpdates(this.poolId,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// Bech32 or hexadecimal pool ID.
  final String poolId;

  /// Stake pool updates
  @override
  String get method => BlockfrostMethods.stakePoolUpdates.url;

  @override
  List<String> get pathParameters => [poolId];

  @override
  List<ADAStakePoolUpdateResponse> onResonse(
      List<Map<String, dynamic>> result) {
    return result.map((e) => ADAStakePoolUpdateResponse.fromJson(e)).toList();
  }
}
