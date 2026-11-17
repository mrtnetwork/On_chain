import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Creates new message call transaction or a contract creation for signed transactions.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sendRawTransaction)
class EthereumRequestSendRawTransaction
    extends EthereumRequest<String, String> {
  EthereumRequestSendRawTransaction({required this.transaction});

  /// eth_sendRawTransaction
  @override
  String get method => EthereumMethods.sendRawTransaction.value;

  /// The signed transaction data.
  final String transaction;

  @override
  List<dynamic> toJson() {
    return [transaction];
  }

  @override
  String toString() {
    return 'EthereumRequestSendRawTransaction{${toJson()}}';
  }
}
