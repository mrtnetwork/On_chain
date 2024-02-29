import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class RPCCompileSolidity extends ETHRPCRequest<dynamic> {
  RPCCompileSolidity({
    required this.code,
  });
  @override
  EthereumMethods get method => EthereumMethods.compileSolidity;

  final String code;

  @override
  List<dynamic> toJson() {
    return [code];
  }
}
