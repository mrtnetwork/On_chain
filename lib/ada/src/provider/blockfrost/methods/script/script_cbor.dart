import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// CBOR representation of a plutus script.
/// https://blockfrost.dev/api/script-cbor
class BlockfrostRequestScriptCBOR
    extends BlockFrostRequest<String?, Map<String, dynamic>> {
  BlockfrostRequestScriptCBOR(this.hash);

  /// Hash of the script
  final String hash;

  /// Script CBOR
  @override
  String get method => BlockfrostMethods.scriptCBOR.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  String? onResonse(Map<String, dynamic> result) {
    return result['cbor'];
  }
}
