import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Information about a specific asset.
/// https://blockfrost.dev/api/specific-asset
class BlockfrostRequestSpecificAsset
    extends BlockforestRequestParam<ADAAssetResponse, Map<String, dynamic>> {
  BlockfrostRequestSpecificAsset(this.asset);

  /// Concatenation of the policy_id and hex-encoded asset_name
  final String asset;

  /// Specific asset
  @override
  String get method => BlockfrostMethods.specificAsset.url;

  @override
  List<String> get pathParameters => [asset];

  @override
  ADAAssetResponse onResonse(Map<String, dynamic> result) {
    return ADAAssetResponse.fromJson(result);
  }
}
