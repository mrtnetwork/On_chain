import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class RPCGetCompilers extends ETHRPCRequest<dynamic> {
  RPCGetCompilers();
  @override
  EthereumMethods get method => EthereumMethods.getCompilers;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
