import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Pool information.
/// https://blockfrost.dev/api/specific-stake-pool
class BlockfrostRequestSpecificStakePool extends BlockforestRequestParam<
    ADAStakePoolInfoResponse, Map<String, dynamic>> {
  BlockfrostRequestSpecificStakePool(this.poolId);

  /// Bech32 or hexadecimal pool ID.
  final String poolId;

  /// Specific stake pool
  @override
  String get method => BlockfrostMethods.specificStakePool.url;

  @override
  List<String> get pathParameters => [poolId];

  @override
  ADAStakePoolInfoResponse onResonse(Map<String, dynamic> result) {
    return ADAStakePoolInfoResponse.fromJson(result);
  }
}
