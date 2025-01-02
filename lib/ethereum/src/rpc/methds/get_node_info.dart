import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Returns the current client version.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#web3_clientVersion)
class EthereumRequestGetNodeInfo extends EthereumRequest<String, String> {
  EthereumRequestGetNodeInfo();

  /// web3_clientVersion
  @override
  String get method => EthereumMethods.getNodeInfo.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return 'EthereumRequestGetNodeInfo{${toJson()}}';
  }
}
