import 'package:on_chain/ethereum/rpc/core/core.dart';
import 'package:on_chain/ethereum/rpc/core/methods.dart';

class RPCWork extends ETHRPCRequest<dynamic> {
  RPCWork();

  /// eth_getWork
  @override
  EthereumMethods get method => EthereumMethods.getWork;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
