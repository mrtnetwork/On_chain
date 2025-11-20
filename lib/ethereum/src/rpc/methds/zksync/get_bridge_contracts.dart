import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/types/zks.dart';

/// Retrieves the addresses of canonical bridge contracts for ZKsync.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_getbridgecontracts)
class ZKSRequestGetBridgeContracts
    extends EthereumRequest<ZkSyncBridgeContracts, Map<String, dynamic>> {
  const ZKSRequestGetBridgeContracts();
  @override
  String get method => "zks_getbridgecontracts";
  @override
  List<dynamic> toJson() {
    return [];
  }

  @override
  ZkSyncBridgeContracts onResonse(Map<String, dynamic> result) {
    return ZkSyncBridgeContracts.fromJson(result);
  }
}
