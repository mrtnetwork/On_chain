import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Creates a filter in the node, to notify when a new block arrives. To check if the state has changed, call eth_getFilterChanges.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_newBlockFilter)
class EthereumRequestNewBlockFilter extends EthereumRequest<BigInt, Object> {
  EthereumRequestNewBlockFilter();

  /// eth_newBlockFilter
  @override
  String get method => EthereumMethods.newBlockFilter.value;

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
    return 'EthereumRequestNewBlockFilter{${toJson()}}';
  }
}
