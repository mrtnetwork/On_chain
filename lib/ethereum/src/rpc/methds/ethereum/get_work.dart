import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestWork extends EthereumRequest<List<String>, List> {
  EthereumRequestWork();

  /// eth_getWork
  @override
  String get method => EthereumMethods.getWork.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  List<String> onResponse(result) {
    return result.map((e) => e as String).toList();
  }
}
