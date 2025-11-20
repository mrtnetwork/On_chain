import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Creates a filter in the node, to notify when new pending transactions arrive. To check if the state has changed, call eth_getFilterChanges.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_newPendingTransactionFilter)
class EthereumRequestNewPendingTransactionFilter
    extends EthereumRequest<BigInt, Object> {
  EthereumRequestNewPendingTransactionFilter();

  /// eth_newPendingTransactionFilter
  @override
  String get method => EthereumMethods.newPendingTransactionFilter.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  BigInt onResonse(result) {
    return EthereumRequest.onBigintResponse(result);
  }

  @override
  String toString() {
    return 'EthereumRequestNewPendingTransactionFilter{${toJson()}}';
  }
}
