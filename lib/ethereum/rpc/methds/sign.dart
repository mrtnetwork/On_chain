import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// The sign method calculates an Ethereum specific signature with: sign(keccak256("\x19Ethereum Signed Message:\n" + len(message) + message))).
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sign)
class RPCSign extends ETHRPCRequest<dynamic> {
  RPCSign({required this.address, required this.message});

  /// eth_sign
  @override
  EthereumMethods get method => EthereumMethods.sign;

  /// address
  final String address;

  /// message to sign
  final String message;
  @override
  List<dynamic> toJson() {
    return [address, message];
  }

  @override
  String toString() {
    return "ETHRPCRequest{${toJson()}}";
  }
}
