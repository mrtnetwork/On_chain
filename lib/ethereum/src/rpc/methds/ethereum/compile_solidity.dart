import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestCompileSolidity extends EthereumRequest<Object?, Object?> {
  EthereumRequestCompileSolidity({
    required this.code,
  });
  @override
  String get method => EthereumMethods.compileSolidity.value;

  final String code;

  @override
  List<dynamic> toJson() {
    return [code];
  }
}
