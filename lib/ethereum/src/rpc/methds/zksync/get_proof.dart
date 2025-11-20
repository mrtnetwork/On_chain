import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/types/zks.dart';

/// This method generates Merkle proofs for one or more storage values associated with a specific account,
/// accompanied by a proof of their authenticity. It verifies that these values remain unaltered.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_getProof)
class ZKSRequestGetProof
    extends EthereumRequest<ZkSyncProof, Map<String, dynamic>> {
  /// account address to fetch storage values and proofs for.
  final String address;

  /// the keys in the account.
  final List<String> keys;

  /// Number of the L1 batch specifying the point in time at which the requested values are returned.
  final int total;

  const ZKSRequestGetProof(
      {required this.address, required this.keys, required this.total});
  @override
  String get method => "zks_getProof";
  @override
  List<dynamic> toJson() {
    return [address, keys, total];
  }

  @override
  ZkSyncProof onResonse(Map<String, dynamic> result) {
    return ZkSyncProof.fromJson(result);
  }
}
