import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns an estimate of the current price per gas in wei. For example, the Besu client examines the last 100 blocks and returns the median gas unit price by default.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_gasPrice)
class RPCGetGasPrice extends ETHRPCRequest<BigInt> {
  RPCGetGasPrice();

  /// eth_gasPrice
  @override
  EthereumMethods get method => EthereumMethods.getGasPrice;

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
    return "RPCGetGasPrice{${toJson()}}";
  }
}
