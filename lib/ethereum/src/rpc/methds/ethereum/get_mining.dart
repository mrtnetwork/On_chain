import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns true if client is actively mining new blocks.
/// This can only return true for proof-of-work networks and may not be available in some clients since The Merge.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_mining)
class EthereumRequestGetMining extends EthereumRequest<bool, bool> {
  EthereumRequestGetMining();

  /// eth_mining
  @override
  String get method => EthereumMethods.getMining.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return 'EthereumRequestGetMining{${toJson()}}';
  }
}
