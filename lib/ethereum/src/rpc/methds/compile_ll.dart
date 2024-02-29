import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/core/methods.dart';

class RPCompileLLL extends ETHRPCRequest<dynamic> {
  RPCompileLLL({
    required this.code,
  });
  @override
  EthereumMethods get method => EthereumMethods.compileLLL;

  final String code;

  @override
  List<dynamic> toJson() {
    return [code];
  }
}
