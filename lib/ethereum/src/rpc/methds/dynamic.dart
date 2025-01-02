import 'package:on_chain/ethereum/src/rpc/core/core.dart';

class EthereumRequestDynamic<T> extends EthereumRequest<T, Object?> {
  EthereumRequestDynamic({required this.methodName, this.params = const []});
  final String methodName;
  final List<dynamic> params;
  @override
  String get method => methodName;

  @override
  List<dynamic> toJson() {
    return params;
  }
}
