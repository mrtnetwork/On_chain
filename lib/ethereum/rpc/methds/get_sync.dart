import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns an object with data about the sync status or false.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_syncing)
class RPCGetSyncing extends ETHRPCRequest<String> {
  RPCGetSyncing();

  /// eth_syncing
  @override
  EthereumMethods get method => EthereumMethods.getSyncing;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return "RPCGetSyncing{${toJson()}}";
  }
}
