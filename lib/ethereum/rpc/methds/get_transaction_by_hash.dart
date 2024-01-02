import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';
import 'package:on_chain/ethereum/models/transaction.dart';

/// Returns the information about a transaction requested by transaction hash.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getTransactionByHash)
class RPCGetTransactionByHash extends ETHRPCRequest<TransactionInfo?> {
  RPCGetTransactionByHash({
    required this.transactionHash,
  });

  /// eth_getTransactionByHash
  @override
  EthereumMethods get method => EthereumMethods.getTransactionByHash;

  /// hash of a transaction
  final String transactionHash;

  @override
  List<dynamic> toJson() {
    return [transactionHash];
  }

  @override
  TransactionInfo? onResonse(result) {
    if (result == null) return null;
    return TransactionInfo.fromJson(result);
  }

  @override
  String toString() {
    return "RPCGetTransactionByHash{${toJson()}}";
  }
}
