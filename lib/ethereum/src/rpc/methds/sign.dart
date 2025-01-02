import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// The sign method calculates an Ethereum specific signature with: sign(keccak256("\x19Ethereum Signed Message:\n" + len(message) + message))).
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sign)
class EthereumRequestSign extends EthereumRequest<Object?, Object?> {
  EthereumRequestSign({required this.address, required this.message});

  /// eth_sign
  @override
  String get method => EthereumMethods.sign.value;

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
    return 'EthereumRequest{${toJson()}}';
  }
}
