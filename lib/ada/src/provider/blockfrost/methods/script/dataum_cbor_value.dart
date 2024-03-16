import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// Query CBOR serialised datum by its hash.
/// https://blockfrost.dev/api/datum-cbor-value
class BlockfrostRequestDataumCBORValue
    extends BlockforestRequestParam<String, Map<String, dynamic>> {
  BlockfrostRequestDataumCBORValue(this.hash);

  /// Hash of the datum
  final String hash;

  /// Datum CBOR value
  @override
  String get method => BlockfrostMethods.dataumCBORValue.url;

  @override
  List<String> get pathParameters => [hash];

  @override
  String onResonse(Map<String, dynamic> result) {
    // TODO: implement onResonse
    return result["cbor"];
  }
}
