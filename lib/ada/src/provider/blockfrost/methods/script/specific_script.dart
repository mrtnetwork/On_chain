import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Information about a specific script.
/// https://blockfrost.dev/api/specific-script
class BlockfrostRequestSpecificScript
    extends BlockFrostRequest<ADAScriptInfoResponse, Map<String, dynamic>> {
  BlockfrostRequestSpecificScript(this.script);

  /// Hash of the script
  final String script;

  /// Specific script
  @override
  String get method => BlockfrostMethods.specificScript.url;

  @override
  List<String> get pathParameters => [script];

  @override
  ADAScriptInfoResponse onResonse(Map<String, dynamic> result) {
    return ADAScriptInfoResponse.fromJson(result);
  }
}
