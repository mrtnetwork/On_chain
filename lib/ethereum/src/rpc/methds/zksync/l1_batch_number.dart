import 'package:on_chain/ethereum/src/rpc/core/core.dart';

/// Retrieves the current L1 batch number.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_l1batchnumber)
class ZKSRequestL1BatchNumber extends EthereumRequest<BigInt, String> {
  @override
  String get method => "zks_l1batchnumber";
  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  BigInt onResonse(String result) {
    return EthereumRequest.onBigintResponse(result);
  }
}
