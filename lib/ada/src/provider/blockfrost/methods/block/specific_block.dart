import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the content of a requested block.
/// https://blockfrost.dev/api/specific-block
class BlockfrostRequestSpecificBlock
    extends BlockforestRequestParam<ADABlockResponse, Map<String, dynamic>> {
  BlockfrostRequestSpecificBlock(this.hashOrNumber);

  /// Hash or number of the requested block.
  final dynamic hashOrNumber;

  /// Specific block
  @override
  String get method => BlockfrostMethods.specificBlock.url;

  @override
  List<String> get pathParameters => [hashOrNumber];

  @override
  ADABlockResponse onResonse(Map<String, dynamic> result) {
    return ADABlockResponse.fromJson(result);
  }
}
