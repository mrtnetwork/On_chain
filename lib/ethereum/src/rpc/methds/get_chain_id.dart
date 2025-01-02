import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the chain ID used for signing replay-protected transactions.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_chainId)
class EthereumRequestGetChainId extends EthereumRequest<BigInt, Object> {
  EthereumRequestGetChainId();

  /// eth_chainId
  @override
  String get method => EthereumMethods.getChainId.value;

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
    return 'EthereumRequestGetChainId{${toJson()}}';
  }
}
