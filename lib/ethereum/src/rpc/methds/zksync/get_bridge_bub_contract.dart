import 'package:on_chain/ethereum/src/rpc/core/core.dart';

/// Retrieves the bridge hub contract address.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_getbridgehubcontract)
class ZKSRequestGetBridgeHubContract extends EthereumRequest<String, String> {
  ZKSRequestGetBridgeHubContract() : super();

  @override
  String get method => "zks_getBridgehubContract";

  @override
  List<dynamic> toJson() {
    return [];
  }
}
