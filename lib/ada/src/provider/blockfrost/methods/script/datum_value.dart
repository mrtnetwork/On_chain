import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';

/// Query JSON value of a datum by its hash.
/// https://blockfrost.dev/api/datum-value
class BlockfrostRequestDatumValue extends BlockforestRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  BlockfrostRequestDatumValue(this.hash);

  /// Hash of the datum
  final String hash;

  /// Datum value
  @override
  String get method => BlockfrostMethods.datumValue.url;

  @override
  List<String> get pathParameters => [hash];
}
