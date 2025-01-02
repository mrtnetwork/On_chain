import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class EthereumRequestCompileSerpent extends EthereumRequest<Object?, Object?> {
  EthereumRequestCompileSerpent({
    required this.code,
  });
  @override
  String get method => EthereumMethods.compileSerpent.value;

  final String code;

  @override
  List<dynamic> toJson() {
    return [code];
  }
}
