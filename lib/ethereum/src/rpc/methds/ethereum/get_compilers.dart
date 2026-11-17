import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestGetCompilers extends EthereumRequest<List<String>, List> {
  EthereumRequestGetCompilers();
  @override
  String get method => EthereumMethods.getCompilers.value;

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  List<String> onResponse(result) {
    return result.map((e) => e as String).toList();
  }
}
