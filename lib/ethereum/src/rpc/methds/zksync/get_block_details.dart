import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/types/zks.dart';

/// Retrieves details for a given block.
/// committed: The batch is closed and the state transition it creates exists on layer 1.
/// proven: The batch proof has been created, submitted, and accepted on layer 1.
/// executed: The batch state transition has been executed on L1; meaning the root state has been updated.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_getblockdetails)
class ZKSRequestGetBlockDetails
    extends EthereumRequest<ZkSyncBlockDetails, Map<String, dynamic>> {
  final int block;
  const ZKSRequestGetBlockDetails(this.block);
  @override
  String get method => "zks_getBlockDetails";
  @override
  List<dynamic> toJson() {
    return [block];
  }

  @override
  ZkSyncBlockDetails onResonse(Map<String, dynamic> result) {
    return ZkSyncBlockDetails.fromJson(result);
  }
}
