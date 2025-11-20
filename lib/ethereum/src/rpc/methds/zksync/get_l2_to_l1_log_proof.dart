import 'package:on_chain/ethereum/src/rpc/core/core.dart';
import 'package:on_chain/ethereum/src/rpc/types/zks.dart';

/// Retrieves the log proof for an L2 to L1 transaction.
/// [zksync.io](https://docs.zksync.io/zksync-protocol/api/zks-rpc#zks_getl2tol1logproof)
class ZKSRequestGetL2ToL1LogProof
    extends EthereumRequest<Getl2tol1logproof, Map<String, dynamic>> {
  /// transaction hash.
  final String transactionHash;

  /// index of the log. Optional for EraVM chains.
  final int? logIndex;
  ZKSRequestGetL2ToL1LogProof({required this.transactionHash, this.logIndex})
      : super();

  @override
  String get method => "zks_getl2tol1logproof";

  @override
  Getl2tol1logproof onResonse(Map<String, dynamic> result) {
    return Getl2tol1logproof.fromJson(result);
  }

  @override
  List<dynamic> toJson() {
    return [transactionHash, logIndex];
  }
}
