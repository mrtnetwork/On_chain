import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// https://geth.ethereum.org/docs/interacting-with-geth/rpc/pubsub
class RPCETHUnsubscribe extends ETHRPCRequest<bool> {
  final String subscriptionId;
  RPCETHUnsubscribe(this.subscriptionId);
  @override
  EthereumMethods get method => EthereumMethods.ethUnsubscribe;

  @override
  List<dynamic> toJson() {
    return [subscriptionId];
  }
}
