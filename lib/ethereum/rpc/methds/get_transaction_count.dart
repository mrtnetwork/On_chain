import 'package:on_chain/ethereum/models/block_tag.dart';
import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns the number of transactions sent from an address.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getTransactionCount)
class RPCGetTransactionCount extends ETHRPCRequest<int> {
  RPCGetTransactionCount({
    required this.address,
    BlockTagOrNumber? tag = BlockTagOrNumber.latest,
  }) : super(blockNumber: tag);

  /// eth_getTransactionCount
  @override
  EthereumMethods get method => EthereumMethods.getTransactionCount;

  /// address
  final String address;

  @override
  List<dynamic> toJson() {
    return [address, blockNumber];
  }

  @override
  int onResonse(result) {
    return ETHRPCRequest.onIntResponse(result);
  }

  @override
  String toString() {
    return "RPCGetTransactionCount{${toJson()}}";
  }
}
