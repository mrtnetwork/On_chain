import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the number of transactions in a block from a block matching the given block hash.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getBlockTransactionCountByHash)
class RPCGetGetBlockTransactionCountByHash extends ETHRPCRequest<int> {
  RPCGetGetBlockTransactionCountByHash({
    required this.blockHash,
  });

  /// eth_getBlockTransactionCountByHash
  @override
  EthereumMethods get method => EthereumMethods.getBlockTransactionCountByHash;

  /// hash of a block
  final String blockHash;

  @override
  List<dynamic> toJson() {
    return [blockHash];
  }

  @override
  int onResonse(result) {
    return ETHRPCRequest.onIntResponse(result);
  }

  @override
  String toString() {
    return "RPCGetGetBlockTransactionCountByHash{${toJson()}}";
  }
}
