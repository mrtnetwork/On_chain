import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestReguestAccounts extends EthereumRequest<Object?, Object?> {
  EthereumRequestReguestAccounts();

  /// eth_requestAccounts
  @override
  String get method => EthereumMethods.requestAccounts.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  String toString() {
    return 'EthereumRequestReguestAccounts{${toJson()}}';
  }
}
