import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the client coinbase address.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_coinbase)
class EthereumRequestGetCoinbase extends EthereumRequest<String, String> {
  EthereumRequestGetCoinbase();

  /// eth_coinbase
  @override
  String get method => EthereumMethods.getCoinbase.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return 'EthereumRequestGetCoinbase{${toJson()}}';
  }
}
