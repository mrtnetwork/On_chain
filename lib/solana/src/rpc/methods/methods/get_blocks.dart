import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns a list of confirmed blocks between two slots
/// https://solana.com/docs/rpc/http/getblocks
class SolanaRPCGetBlocks extends SolanaRPCRequest<List<int>> {
  const SolanaRPCGetBlocks(
      {required this.startSlot, this.endSlot, Commitment? commitment})
      : super(commitment: commitment);

  /// getBlocks
  @override
  String get method => SolanaRPCMethods.getBlocks.value;

  /// start_slot, as u64 integer
  final int startSlot;

  /// end_slot, as u64 integer (must be no more than 500,000 blocks higher than the start_slot)
  final int? endSlot;

  @override
  List<dynamic> toJson() {
    return [
      startSlot,
      endSlot,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
      ])
    ];
  }

  @override
  List<int> onResonse(result) {
    return (result as List).cast();
  }
}
