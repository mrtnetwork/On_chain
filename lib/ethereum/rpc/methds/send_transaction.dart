import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

/// Creates new message call transaction or a contract creation, if the data field contains code, and signs it using the account specified in from.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sendTransaction)
class RPCSendTransaction extends ETHRPCRequest<dynamic> {
  RPCSendTransaction({required this.transaction});

  /// eth_sendTransaction
  @override
  EthereumMethods get method => EthereumMethods.sendTransaction;

  final String transaction;

  @override
  List<dynamic> toJson() {
    return [transaction];
  }

  @override
  String toString() {
    return "RPCSendTransaction{${toJson()}}";
  }
}
