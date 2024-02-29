import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns information about a uncle of a block by number and uncle index position.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getUncleByBlockNumberAndIndex)
class RPCGetUncleByBlockNumberAndIndex
    extends ETHRPCRequest<Map<String, dynamic>?> {
  RPCGetUncleByBlockNumberAndIndex({
    required BlockTagOrNumber blockNumber,
    required this.uncleIndex,
  }) : super(blockNumber: blockNumber);

  /// eth_getUncleByBlockNumberAndIndex
  @override
  EthereumMethods get method => EthereumMethods.getUncleByBlockNumberAndIndex;

  /// the uncle's index position.
  final int uncleIndex;

  @override
  List<dynamic> toJson() {
    return [blockNumber, "0x${uncleIndex.toRadixString(16)}"];
  }

  @override
  String toString() {
    return "RPCGetUncleByBlockNumberAndIndex{${toJson()}}";
  }
}
