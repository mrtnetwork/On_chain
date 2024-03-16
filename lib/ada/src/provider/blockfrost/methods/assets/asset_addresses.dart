import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of a addresses containing a specific asset.
/// https://blockfrost.dev/api/asset-addresses
class BlockfrostRequestAssetAddresses extends BlockforestRequestParam<
    List<ADAAssetBalanceResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestAssetAddresses(this.asset,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// Concatenation of the policy_id and hex-encoded asset_name
  final String asset;

  /// Asset addresses
  @override
  String get method => BlockfrostMethods.assetAddresses.url;

  @override
  List<String> get pathParameters => [asset];

  @override
  List<ADAAssetBalanceResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAAssetBalanceResponse.fromJson(e)).toList();
  }
}
