import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestSubmitHashrate extends EthereumRequest<Object?, Object?> {
  EthereumRequestSubmitHashrate({required this.id, required this.hashRate});

  /// eth_submitHashrate
  @override
  String get method => EthereumMethods.submitHashrate.value;
  final String id;
  final String hashRate;
  @override
  List<dynamic> toJson() {
    return [hashRate, id];
  }

  @override
  String toString() {
    return 'EthereumRequestSubmitHashrate{${toJson()}}';
  }
}
