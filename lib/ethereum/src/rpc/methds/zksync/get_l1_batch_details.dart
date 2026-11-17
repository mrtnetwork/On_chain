import 'package:on_chain/ethereum/src/rpc/core/core.dart';

/// Retrieves details for a given L1 batch.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_getl1batchdetails)
class ZKSRequestGetL1BatchDetails
    extends EthereumRequest<Map<String, dynamic>, Map<String, dynamic>> {
  const ZKSRequestGetL1BatchDetails();
  @override
  String get method => "zks_getl1batchdetails";
  @override
  List<dynamic> toJson() {
    return [];
  }
}
