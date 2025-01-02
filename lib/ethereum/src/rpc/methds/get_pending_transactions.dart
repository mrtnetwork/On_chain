import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestGetPendingTransactions
    extends EthereumRequest<List<dynamic>, List> {
  EthereumRequestGetPendingTransactions();
  @override
  String get method => EthereumMethods.getPendingTransactions.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
