import 'package:on_chain/ethereum/models/block_tag.dart';
import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns information about a transaction by block number and transaction index position.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getTransactionByBlockNumberAndIndex)
class RPCGetTransactionByBlockNumberAndIndex
    extends ETHRPCRequest<Map<String, dynamic>?> {
  RPCGetTransactionByBlockNumberAndIndex(
      {required BlockTagOrNumber blockNumber, required this.index})
      : super(blockNumber: blockNumber);

  /// eth_getTransactionByBlockNumberAndIndex
  @override
  EthereumMethods get method =>
      EthereumMethods.getTransactionByBlockNumberAndIndex;

  /// the transaction index position.
  final int index;

  @override
  List<dynamic> toJson() {
    return [blockNumber, "0x${index.toRadixString(16)}"];
  }

  @override
  String toString() {
    return "RPCGetTransactionByBlockNumberAndIndex{${toJson()}}";
  }
}
