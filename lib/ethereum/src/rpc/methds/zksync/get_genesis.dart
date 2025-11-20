import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/types/zks.dart';

/// Returns the details about genesis deployment, including the initial contracts deployed,
/// additional storage, the execution version used, and the expected root hash of the genesis state.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_getgenesis)
class ZKSRequestGetGenesis
    extends EthereumRequest<JKSGenesis, Map<String, dynamic>> {
  ZKSRequestGetGenesis() : super();

  @override
  String get method => "zks_getgenesis";

  @override
  JKSGenesis onResonse(Map<String, dynamic> result) {
    return JKSGenesis.fromJson(result);
  }

  @override
  List<dynamic> toJson() {
    return [];
  }
}
