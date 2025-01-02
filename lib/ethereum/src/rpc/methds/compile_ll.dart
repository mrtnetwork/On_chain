import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestompileLLL extends EthereumRequest<Object?, Object?> {
  EthereumRequestompileLLL({
    required this.code,
  });
  @override
  String get method => EthereumMethods.compileLLL.value;

  final String code;

  @override
  List<dynamic> toJson() {
    return [code];
  }
}
