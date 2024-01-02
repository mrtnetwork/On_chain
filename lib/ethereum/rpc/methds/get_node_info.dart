import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns the current client version.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#web3_clientVersion)
class RPCGetNodeInfo extends ETHRPCRequest<String> {
  RPCGetNodeInfo();

  /// web3_clientVersion
  @override
  EthereumMethods get method => EthereumMethods.getNodeInfo;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return "RPCGetNodeInfo{${toJson()}}";
  }
}
