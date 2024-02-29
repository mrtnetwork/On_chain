import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the number of most recent block..
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_blocknumber)
class RPCGetBlockNumber extends ETHRPCRequest<int> {
  /// eth_blockNumber
  @override
  EthereumMethods get method => EthereumMethods.getBlockNumber;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  int onResonse(dynamic result) {
    return ETHRPCRequest.onIntResponse(result);
  }

  @override
  String toString() {
    return "RPCGetBlockNumber{${toJson()}}";
  }
}
