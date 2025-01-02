import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns a list of confirmed blocks starting at the given slot
/// https://solana.com/docs/rpc/http/getblockswithlimit
class SolanaRequestGetBlocksWithLimit extends SolanaRequest<List<int>, List> {
  const SolanaRequestGetBlocksWithLimit(
      {required this.startSlot, required this.limit, super.commitment});

  /// getBlocksWithLimit
  @override
  String get method => SolanaRequestMethods.getBlocksWithLimit.value;

  /// start_slot, as u64 integer
  final int startSlot;

  /// limit, as u64 integer (must be no more than 500,000 blocks higher than the start_slot)
  final int limit;

  @override
  List<dynamic> toJson() {
    return [
      startSlot,
      limit,
      SolanaRequestUtils.createConfig([commitment?.toJson()])
    ];
  }

  @override
  List<int> onResonse(List result) {
    return result.cast<int>();
  }
}
