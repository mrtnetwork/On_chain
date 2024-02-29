import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class RPCGetPendingTransactions extends ETHRPCRequest<List<dynamic>> {
  RPCGetPendingTransactions();
  @override
  EthereumMethods get method => EthereumMethods.getPendingTransactions;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
