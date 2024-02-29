import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns a list of confirmed blocks starting at the given slot
/// https://solana.com/docs/rpc/http/getblockswithlimit
class SolanaRPCGetBlocksWithLimit extends SolanaRPCRequest<List<int>> {
  const SolanaRPCGetBlocksWithLimit(
      {required this.startSlot, required this.limit, Commitment? commitment})
      : super(commitment: commitment);

  /// getBlocksWithLimit
  @override
  String get method => SolanaRPCMethods.getBlocksWithLimit.value;

  /// start_slot, as u64 integer
  final int startSlot;

  /// limit, as u64 integer (must be no more than 500,000 blocks higher than the start_slot)
  final int limit;

  @override
  List<dynamic> toJson() {
    return [
      startSlot,
      limit,
      SolanaRPCUtils.createConfig([commitment?.toJson()])
    ];
  }

  @override
  List<int> onResonse(result) {
    return (result as List).cast();
  }
}
