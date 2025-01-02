import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns information about a uncle of a block by hash and uncle index position.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getUncleByBlockHashAndIndex)
class EthereumRequestGetUncleByBlockHashAndIndex
    extends EthereumRequest<Map<String, dynamic>?, Map<String, dynamic>?> {
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
    return [blockHash, '0x${uncleIndex.toRadixString(16)}'];
  }

  @override
  String toString() {
    return 'EthereumRequestGetUncleByBlockHashAndIndex{${toJson()}}';
  }
}
