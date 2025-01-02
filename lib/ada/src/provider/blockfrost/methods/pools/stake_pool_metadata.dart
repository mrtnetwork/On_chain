import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Stake pool registration metadata.
/// https://blockfrost.dev/api/stake-pool-metadata
class BlockfrostRequestStakePoolMetadata
    extends BlockFrostRequest<ADAPoolMetadataResponse, Map<String, dynamic>> {
  BlockfrostRequestStakePoolMetadata(this.poolId);

  final String poolId;

  /// Stake pool metadata
  @override
  String get method => BlockfrostMethods.stakePoolMetadata.url;

  @override
  List<String> get pathParameters => [poolId];

  @override
  ADAPoolMetadataResponse onResonse(Map<String, dynamic> result) {
    return ADAPoolMetadataResponse.fromJson(result);
  }
}
