import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// List of redeemers of a specific script.
/// https://blockfrost.dev/api/redeemers-of-a-specific-script
class BlockfrostRequestRedeemersOfASpecificScript
    extends BlockforestRequestParam<List<ADAScriptRedeemerInfoResponse>,
        List<Map<String, dynamic>>> {
  BlockfrostRequestRedeemersOfASpecificScript(this.hash,
      {BlockforestRequestFilterParams? filter})
      : super(filter: filter);

  /// Hash of the script
  final String hash;

  /// Redeemers of a specific script
  @override
  String get method => BlockfrostMethods.redeemersOfASpecificScript.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  List<ADAScriptRedeemerInfoResponse> onResonse(List<Map<String, dynamic>> result) {
    return result.map((e) => ADAScriptRedeemerInfoResponse.fromJson(e)).toList();
  }
}
