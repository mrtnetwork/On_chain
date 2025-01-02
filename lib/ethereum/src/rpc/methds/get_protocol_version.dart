import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the current Ethereum protocol version. Note that this method is not available in Geth
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_protocolVersion)
class EthereumRequestGetProtocolVersion
    extends EthereumRequest<String, String> {
  EthereumRequestGetProtocolVersion();

  /// eth_protocolVersion
  @override
  String get method => EthereumMethods.getProtocolVersion.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return 'EthereumRequestGetProtocolVersion{${toJson()}}';
  }
}
