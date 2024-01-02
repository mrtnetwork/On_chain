import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';
import 'package:on_chain/ethereum/models/transaction_receipt.dart';

/// Returns the receipt of a transaction by transaction hash.
/// That the receipt is not available for pending transactions.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getTransactionReceipt)
class RPCGetTransactionReceipt extends ETHRPCRequest<TransactionReceipt?> {
  RPCGetTransactionReceipt({required this.transactionHash});

  /// eth_getTransactionReceipt
  @override
  EthereumMethods get method => EthereumMethods.getTransactionReceipt;

  /// hash of a transaction
  final String transactionHash;

  @override
  List<dynamic> toJson() {
    return [transactionHash];
  }

  @override
  TransactionReceipt? onResonse(result) {
    if (result == null) return null;
    return TransactionReceipt.fromJson(result);
  }

  @override
  String toString() {
    return "RPCGetTransactionReceipt{${toJson()}}";
  }
}
