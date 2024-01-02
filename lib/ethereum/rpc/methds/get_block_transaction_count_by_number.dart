import 'package:on_chain/ethereum/models/block_tag.dart';
import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns the number of transactions in a block matching the given block number.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getBlockTransactionCountByNumber)
class RPCGetBlockTransactionCountByNumber extends ETHRPCRequest<int> {
  RPCGetBlockTransactionCountByNumber({
    BlockTagOrNumber tag = BlockTagOrNumber.finalized,
  }) : super(blockNumber: tag);

  /// eth_getBlockTransactionCountByNumber
  @override
  EthereumMethods get method =>
      EthereumMethods.getBlockTransactionCountByNumber;

  @override
  List<dynamic> toJson() {
    return [blockNumber];
  }

  @override
  int onResonse(result) {
    return ETHRPCRequest.onIntResponse(result);
  }

  @override
  String toString() {
    return "RPCGetBlockTransactionCountByNumber{${toJson()}}";
  }
}
