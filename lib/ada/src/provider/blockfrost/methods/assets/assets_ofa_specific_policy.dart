import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of asset minted under a specific policy.
/// https://blockfrost.dev/api/assets-of-a-specific-policy
class BlockfrostRequestAssetsOfaSpecificPolicy extends BlockforestRequestParam<
    List<ADAAssetsResponse>, List<Map<String, dynamic>>> {
  BlockfrostRequestAssetsOfaSpecificPolicy(this.policyId,
      {BlockforestRequestFilterParams? filter});

  /// Specific policy_id
  final String policyId;

  /// Assets of a specific policy
  @override
  String get method => BlockfrostMethods.assetsOfaSpecificPolicy.url;

  @override
  List<String> get pathParameters => [policyId];

  @override
  List<ADAAssetsResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAAssetsResponse.fromJson(e)).toList();
  }
}
