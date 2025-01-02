import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';
import 'package:on_chain/ethereum/src/rpc/methds/subscribes/const/constant.dart';

/// https://geth.ethereum.org/docs/interacting-with-geth/rpc/pubsub
class EthereumRequestETHSubscribeLogs extends EthereumRequest<String, String> {
  EthereumRequestETHSubscribeLogs({this.filter});
  final SubscribeLogsFilter? filter;

  @override
  String get method => EthereumMethods.ethSubscribe.value;

  @override
  List<dynamic> toJson() {
    return [
      EthereumRequestETHSubscribeConst.logs,
      if (filter != null) filter!.toJson()
    ];
  }
}

class SubscribeLogsFilter {
  final ETHAddress address;
  final List<String> topics;
  const SubscribeLogsFilter({required this.address, this.topics = const []});
  Map<String, dynamic> toJson() {
    return {'address': address.address, 'topics': topics};
  }
}
