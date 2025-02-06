import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:on_chain/sui/src/rpc/core/core.dart';

/// Return the reference gas price for the network.
/// [sui documation](https://docs.sui.io/sui-api-ref#suix_getreferencegasprice)
class SuiRequestGetReferenceGasPrice extends SuiRequest<BigInt, String> {
  const SuiRequestGetReferenceGasPrice();

  @override
  String get method => 'suix_getReferenceGasPrice';

  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  BigInt onResonse(String result) {
    return BigintUtils.parse(result);
  }
}
