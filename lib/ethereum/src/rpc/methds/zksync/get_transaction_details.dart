import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/types/zks.dart';

/// Retrieves details for a given transaction.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_gettransactiondetails)
class ZKSRequestGetTransactionDetails
    extends EthereumRequest<ZkSyncTransactionDetails, Map<String, dynamic>> {
  final String hash;
  const ZKSRequestGetTransactionDetails(this.hash);
  @override
  String get method => "zks_gettransactiondetails";
  @override
  List<dynamic> toJson() {
    return [hash];
  }

  @override
  ZkSyncTransactionDetails onResonse(Map<String, dynamic> result) {
    return ZkSyncTransactionDetails.fromJson(result);
  }
}
