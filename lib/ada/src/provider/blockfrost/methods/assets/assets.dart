import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of assets. If an asset is completely burned, it will stay on the list with quantity 0 (order of assets is immutable
/// https://blockfrost.dev/api/assets
class BlockfrostRequestAssets extends BlockforestRequestParam<
    List<ADAAssetsResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestAssets({BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// Assets
  @override
  String get method => BlockfrostMethods.assets.url;

  @override
  List<String> get pathParameters => [];

  @override
  List<ADAAssetsResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAAssetsResponse.fromJson(e)).toList();
  }
}
