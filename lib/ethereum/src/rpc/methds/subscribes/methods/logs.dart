import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/ethereum/src/rpc/methds/subscribes/const/constant.dart';

/// https://geth.ethereum.org/docs/interacting-with-geth/rpc/pubsub
class RPCETHSubscribeLogs extends ETHRPCRequest<String> {
  RPCETHSubscribeLogs({this.filter});
  final SubscribeLogsFilter? filter;

  @override
  EthereumMethods get method => EthereumMethods.ethSubscribe;

  @override
  List<dynamic> toJson() {
    return [RPCETHSubscribeConst.logs, if (filter != null) filter!.toJson()];
  }
}

class SubscribeLogsFilter {
  final ETHAddress address;
  final List<String> topics;
  const SubscribeLogsFilter({required this.address, this.topics = const []});
  Map<String, dynamic> toJson() {
    return {"address": address.address, "topics": topics};
  }
}
