import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the number of hashes per second that the node is mining with.
/// This can only return true for proof-of-work networks and may not be available in some clients since The Merge.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_hashrate)
class RPCGetHashRate extends ETHRPCRequest<String> {
  RPCGetHashRate();

  /// eth_hashrate
  @override
  EthereumMethods get method => EthereumMethods.getHashRate;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return "RPCGetHashRate{${toJson()}}";
  }
}
