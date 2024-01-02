import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Creates a filter in the node, to notify when a new block arrives. To check if the state has changed, call eth_getFilterChanges.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_newBlockFilter)
class RPCNewBlockFilter extends ETHRPCRequest<BigInt> {
  RPCNewBlockFilter();

  /// eth_newBlockFilter
  @override
  EthereumMethods get method => EthereumMethods.newBlockFilter;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  BigInt onResonse(result) {
    return ETHRPCRequest.onBigintResponse(result);
  }

  @override
  String toString() {
    return "RPCNewBlockFilter{${toJson()}}";
  }
}
