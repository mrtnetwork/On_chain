import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class RPCSubmitHashrate extends ETHRPCRequest<dynamic> {
  RPCSubmitHashrate({required this.id, required this.hashRate});

  /// eth_submitHashrate
  @override
  EthereumMethods get method => EthereumMethods.submitHashrate;
  final String id;
  final String hashRate;
  @override
  List<dynamic> toJson() {
    return [hashRate, id];
  }

  @override
  String toString() {
    return "RPCSubmitHashrate{${toJson()}}";
  }
}
