import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns the client coinbase address.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_coinbase)
class RPCGetCoinbase extends ETHRPCRequest<String> {
  RPCGetCoinbase();

  /// eth_coinbase
  @override
  EthereumMethods get method => EthereumMethods.getCoinbase;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return "RPCGetCoinbase{${toJson()}}";
  }
}
