import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestReguestAccounts
    extends EthereumRequest<List<String>, List> {
  EthereumRequestReguestAccounts();

  /// eth_requestAccounts
  @override
  String get method => EthereumMethods.requestAccounts.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  List<String> onResponse(result) {
    return result.map((e) => e as String).toList();
  }

  @override
  String toString() {
    return 'EthereumRequestReguestAccounts{${toJson()}}';
  }
}
