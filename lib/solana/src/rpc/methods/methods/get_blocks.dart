import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns a list of confirmed blocks between two slots
/// https://solana.com/docs/rpc/http/getblocks
class SolanaRequestGetBlocks extends SolanaRequest<List<int>, List> {
  const SolanaRequestGetBlocks(
      {required this.startSlot, this.endSlot, super.commitment});

  /// getBlocks
  @override
  String get method => SolanaRequestMethods.getBlocks.value;

  /// start_slot, as u64 integer
  final int startSlot;

  /// end_slot, as u64 integer (must be no more than 500,000 blocks higher than the start_slot)
  final int? endSlot;

  @override
  List<dynamic> toJson() {
    return [
      startSlot,
      endSlot,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
      ])
    ];
  }

  @override
  List<int> onResonse(result) {
    return result.cast<int>();
  }
}
