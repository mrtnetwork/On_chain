import 'package:on_chain/ethereum/src/models/transaction.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestGetPendingTransactions
    extends EthereumRequest<List<TransactionInfo>, List> {
  EthereumRequestGetPendingTransactions();
  @override
  String get method => EthereumMethods.getPendingTransactions.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  List<TransactionInfo> onResponse(result) {
    return result.map((e) => TransactionInfo.fromJson(e)).toList();
  }
}
