import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/ethereum/src/models/transaction.dart';

/// Returns the information about a transaction requested by transaction hash.
/// [ethereum.org](https://ethereum.org/en/developers/docs/apis/json-rpc/#eth_getTransactionByHash)
class EthereumRequestGetTransactionByHash
    extends EthereumRequest<TransactionInfo?, Map<String, dynamic>?> {
  EthereumRequestGetTransactionByHash({
    required this.transactionHash,
  });

  /// eth_getTransactionByHash
  @override
  String get method => EthereumMethods.getTransactionByHash.value;

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
    return 'EthereumRequestGetTransactionByHash{${toJson()}}';
  }
}
