import 'package:on_chain/ethereum/src/rpc/core/core.dart';

/// Returns the scaled gas per pubdata limit for the currently open batch. Available since node version 28.7.0.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_gasPerPubdata)
class ZKSRequestGasPerPubdata extends EthereumRequest<BigInt, String> {
  @override
  String get method => "zks_gasPerPubdata";
  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  BigInt onResonse(String result) {
    return EthereumRequest.onBigintResponse(result);
  }
}
