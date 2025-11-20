import 'package:on_chain/ethereum/src/rpc/core/core.dart';

/// Retrieves the current L1 gas price.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_getl1gasprice)
class ZKSRequestGetL1GasPrice extends EthereumRequest<BigInt, String> {
  @override
  String get method => "zks_getl1gasprice";
  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  BigInt onResonse(String result) {
    return EthereumRequest.onBigintResponse(result);
  }
}
