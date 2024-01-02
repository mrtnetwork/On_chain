import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Returns the chain ID used for signing replay-protected transactions.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_chainId)
class RPCGetChainId extends ETHRPCRequest<BigInt> {
  RPCGetChainId();

  /// eth_chainId
  @override
  EthereumMethods get method => EthereumMethods.getChainId;

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
    return "RPCGetChainId{${toJson()}}";
  }
}
