import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestWork extends EthereumRequest<Object?, Object?> {
  EthereumRequestWork();

  /// eth_getWork
  @override
  String get method => EthereumMethods.getWork.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
