import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns information about a uncle of a block by hash and uncle index position.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getUncleByBlockHashAndIndex)
class RPCGetUncleByBlockHashAndIndex
    extends ETHRPCRequest<Map<String, dynamic>?> {
  RPCGetUncleByBlockHashAndIndex({
    required this.blockHash,
    required this.uncleIndex,
  });

  /// eth_getUncleByBlockHashAndIndex
  @override
  EthereumMethods get method => EthereumMethods.getUncleByBlockHashAndIndex;

  /// The uncle's index position.
  final int uncleIndex;

  /// The hash of a block.
  final String blockHash;

  @override
  List<dynamic> toJson() {
    return [blockHash, "0x${uncleIndex.toRadixString(16)}"];
  }

  @override
  String toString() {
    return "RPCGetUncleByBlockHashAndIndex{${toJson()}}";
  }
}
