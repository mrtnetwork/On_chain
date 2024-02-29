import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the current Ethereum protocol version. Note that this method is not available in Geth
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_protocolVersion)
class RPCGetProtocolVersion extends ETHRPCRequest<String> {
  RPCGetProtocolVersion();

  /// eth_protocolVersion
  @override
  EthereumMethods get method => EthereumMethods.getProtocolVersion;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return "RPCGetProtocolVersion{${toJson()}}";
  }
}
