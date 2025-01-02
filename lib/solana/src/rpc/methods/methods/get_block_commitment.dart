import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns commitment for particular block
/// https://solana.com/docs/rpc/http/getblockcommitment
class SolanaRequestGetBlockCommitment
    extends SolanaRequest<Map<String, dynamic>, Map<String, dynamic>> {
  const SolanaRequestGetBlockCommitment({required this.blockNumber});

  /// getBlockCommitment
  @override
  String get method => SolanaRequestMethods.getBlockCommitment.value;

  /// block number, identified by Slot
  final int blockNumber;

  @override
  List<dynamic> toJson() {
    return [blockNumber];
  }
}
