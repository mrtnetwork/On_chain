import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Creates new message call transaction or a contract creation for signed transactions.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sendRawTransaction)
class RPCSendRawTransaction extends ETHRPCRequest<String> {
  RPCSendRawTransaction({required this.transaction});

  /// eth_sendRawTransaction
  @override
  EthereumMethods get method => EthereumMethods.sendRawTransaction;

  /// The signed transaction data.
  final String transaction;

  @override
  List<dynamic> toJson() {
    return [transaction];
  }

  @override
  String toString() {
    return "RPCSendRawTransaction{${toJson()}}";
  }
}
