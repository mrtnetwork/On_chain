import 'package:on_chain/ethereum/src/rpc/core/core.dart';

/// Retrieves the current fee parameters.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_getfeeparams)
class ZKSRequestGetFeeParams
    extends EthereumRequest<Map<String, dynamic>, Map<String, dynamic>> {
  const ZKSRequestGetFeeParams();
  @override
  String get method => "zks_getfeeparams";
  @override
  List<dynamic> toJson() {
    return [];
  }
}
