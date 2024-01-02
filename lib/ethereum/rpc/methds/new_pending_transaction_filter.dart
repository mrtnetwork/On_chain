import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Creates a filter in the node, to notify when new pending transactions arrive. To check if the state has changed, call eth_getFilterChanges.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_newPendingTransactionFilter)
class RPCNewPendingTransactionFilter extends ETHRPCRequest<BigInt> {
  RPCNewPendingTransactionFilter();

  /// eth_newPendingTransactionFilter
  @override
  EthereumMethods get method => EthereumMethods.newPendingTransactionFilter;

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
    return "RPCNewPendingTransactionFilter{${toJson()}}";
  }
}
