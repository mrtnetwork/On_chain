import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// JSON representation of a timelock script
/// https://blockfrost.dev/api/script-json
class BlockfrostRequestScriptJson
    extends BlockFrostRequest<Map<String, dynamic>, Map<String, dynamic>> {
  BlockfrostRequestScriptJson(this.hash);

  /// Hash of the script
  final String hash;

  /// Script JSON
  @override
  String get method => BlockfrostMethods.scriptJson.url;

  @override
  List<String> get pathParameters => [hash];
}
