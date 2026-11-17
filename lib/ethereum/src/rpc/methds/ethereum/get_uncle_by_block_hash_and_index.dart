import 'package:blockchain_utils/helper/helper.dart';
import 'package:on_chain/ethereum/src/models/block.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns information about a uncle of a block by hash and uncle index position.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getUncleByBlockHashAndIndex)
class EthereumRequestGetUncleByBlockHashAndIndex
    extends EthereumRequest<BlockDetails?, Map<String, dynamic>?> {
  EthereumRequestGetUncleByBlockHashAndIndex({
    required this.blockHash,
    required this.uncleIndex,
  });

  /// eth_getUncleByBlockHashAndIndex
  @override
  String get method => EthereumMethods.getUncleByBlockHashAndIndex.value;

  /// The uncle's index position.
  final int uncleIndex;

  /// The hash of a block.
  final String blockHash;

  @override
  List<dynamic> toJson() {
    return [blockHash, uncleIndex.toHexaDecimal];
  }

  @override
  BlockDetails? onResponse(result) {
    if (result == null) return null;
    return BlockDetails.fromJson(result);
  }

  @override
  String toString() {
    return 'EthereumRequestGetUncleByBlockHashAndIndex{${toJson()}}';
  }
}
