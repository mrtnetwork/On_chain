import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class RPCReguestAccounts extends ETHRPCRequest<dynamic> {
  RPCReguestAccounts();

  /// eth_requestAccounts
  @override
  EthereumMethods get method => EthereumMethods.requestAccounts;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return "RPCReguestAccounts{${toJson()}}";
  }
}
