import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// Creates new message call transaction or a contract creation, if the data field contains code, and signs it using the account specified in from.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_sendTransaction)
class EthereumRequestSendTransaction extends EthereumRequest<Object?, Object?> {
  EthereumRequestSendTransaction({required this.transaction});

  /// eth_sendTransaction
  @override
  String get method => EthereumMethods.sendTransaction.value;

  final String transaction;

  @override
  List<dynamic> toJson() {
    return [transaction];
  }

  @override
  String toString() {
    return 'EthereumRequestSendTransaction{${toJson()}}';
  }
}
