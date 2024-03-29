import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class RPCCompileSerpent extends ETHRPCRequest<dynamic> {
  RPCCompileSerpent({
    required this.code,
  });
  @override
  EthereumMethods get method => EthereumMethods.compileSerpent;

  final String code;

  @override
  List<dynamic> toJson() {
    return [code];
  }
}
