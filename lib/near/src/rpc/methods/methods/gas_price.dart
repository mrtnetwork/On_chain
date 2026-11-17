import 'package:on_chain/near/src/rpc/core/core.dart';
import 'package:on_chain/near/src/rpc/models/types/types.dart';

class NearNodeRequestGasPrice
    extends NearNodeRequest<NearRpcRpcGasPriceResponse, Map<String, dynamic>> {
  final NearRpcRpcGasPriceRequest args;
  const NearNodeRequestGasPrice(this.args);
  @override
  String get method => "gas_price";

  @override
  dynamic params() => args.toJson();

  @override
  NearRpcRpcGasPriceResponse onResponse(Map<String, dynamic> result) {
    return NearRpcRpcGasPriceResponse.fromJson(result);
  }
}
