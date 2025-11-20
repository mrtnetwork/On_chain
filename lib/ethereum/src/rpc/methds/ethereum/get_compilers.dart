import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestGetCompilers extends EthereumRequest<Object?, Object?> {
  EthereumRequestGetCompilers();
  @override
  String get method => EthereumMethods.getCompilers.value;

  @override
  List<dynamic> toJson() {
    return [];
  }
}
