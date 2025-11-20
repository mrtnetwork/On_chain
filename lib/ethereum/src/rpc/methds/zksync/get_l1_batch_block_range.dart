import 'package:on_chain/ethereum/src/rpc/core/core.dart';

/// Returns the range of blocks contained within a batch given by the batch number.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_getl1batchblockrange)
class ZKSRequestGetL1BatchBlockRange
    extends EthereumRequest<List<String>, List<String>> {
  final int l1BatchNumber;
  const ZKSRequestGetL1BatchBlockRange(this.l1BatchNumber);
  @override
  String get method => "zks_getl1batchblockrange";
  @override
  List<dynamic> toJson() {
    return [l1BatchNumber];
  }
}
