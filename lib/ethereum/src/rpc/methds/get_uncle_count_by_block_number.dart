import 'package:on_chain/ethereum/src/models/block_tag.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the number of uncles in a block from a block matching the given block number.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getUncleCountByBlockNumber)
class RPCGetUncleCountByBlockNumber extends ETHRPCRequest<int> {
  RPCGetUncleCountByBlockNumber({
    BlockTagOrNumber tag = BlockTagOrNumber.finalized,
  }) : super(blockNumber: tag);

  /// eth_getUncleCountByBlockNumber
  @override
  EthereumMethods get method => EthereumMethods.getUncleCountByBlockNumber;

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
    return "RPCGetUncleCountByBlockNumber{${toJson()}}";
  }
}
