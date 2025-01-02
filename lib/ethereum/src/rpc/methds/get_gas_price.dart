import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns an estimate of the current price per gas in wei. For example, the Besu client examines the last 100 blocks and returns the median gas unit price by default.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_gasPrice)
class EthereumRequestGetGasPrice extends EthereumRequest<BigInt, Object> {
  EthereumRequestGetGasPrice();

  /// eth_gasPrice
  @override
  String get method => EthereumMethods.getGasPrice.value;

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
    return 'EthereumRequestGetGasPrice{${toJson()}}';
  }
}
