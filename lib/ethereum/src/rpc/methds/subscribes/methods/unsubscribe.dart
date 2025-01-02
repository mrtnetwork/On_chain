import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

/// https://geth.ethereum.org/docs/interacting-with-geth/rpc/pubsub
class EthereumRequestETHUnsubscribe extends EthereumRequest<bool, bool> {
  final String subscriptionId;
  EthereumRequestETHUnsubscribe(this.subscriptionId);
  @override
  String get method => EthereumMethods.ethUnsubscribe.value;

  @override
  List<dynamic> toJson() {
    return [subscriptionId];
  }
}
