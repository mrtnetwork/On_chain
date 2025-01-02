import 'package:on_chain/ada/src/provider/blockfrost/core/blockfrost.dart';
import 'package:on_chain/ada/src/provider/blockfrost/core/core.dart';
import 'package:on_chain/ada/src/provider/blockfrost/models/response_model.dart';

/// Return the latest block available to the backends, also known as the tip of the blockchain.
/// https://blockfrost.dev/api/latest-block
class BlockfrostRequestLatestBlock
    extends BlockFrostRequest<ADABlockResponse, Map<String, dynamic>> {
  BlockfrostRequestLatestBlock();

  /// Latest block
  @override
  String get method => BlockfrostMethods.latestBlock.url;

  @override
  List<String> get pathParameters => [];

  @override
  ADABlockResponse onResonse(Map<String, dynamic> result) {
    return ADABlockResponse.fromJson(result);
  }
}
