import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// History of a specific asset.
/// https://blockfrost.dev/api/asset-history
class BlockfrostRequestAssetHistory extends BlockFrostRequest<
    List<ADAAssetActionResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestAssetHistory(this.asset,
      {BlockFrostRequestFilterParams? filter})
      : super(filter: filter);

  /// Concatenation of the policy_id and hex-encoded asset_name
  final String asset;

  /// Asset history
  @override
  String get method => BlockfrostMethods.assetHistory.url;

  @override
  List<String> get pathParameters => [asset];

  @override
  List<ADAAssetActionResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAAssetActionResponse.fromJson(e)).toList();
  }
}
