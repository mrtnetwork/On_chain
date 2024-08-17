import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/ethereum/src/rpc/methds/subscribes/const/constant.dart';

/// https://geth.ethereum.org/docs/interacting-with-geth/rpc/pubsub
class RPCETHSubscribeNewHeads extends ETHRPCRequest<String> {
  RPCETHSubscribeNewHeads();

  @override
  EthereumMethods get method => EthereumMethods.ethSubscribe;

  @override
  List<dynamic> toJson() {
    return [RPCETHSubscribeConst.newHeads];
  }
}
