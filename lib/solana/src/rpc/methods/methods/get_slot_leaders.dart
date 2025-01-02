import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';

/// Returns the slot leaders for a given slot range
/// https://solana.com/docs/rpc/http/getslotleaders
class SolanaRequestGetSlotLeaders
    extends SolanaRequest<List<SolAddress>, List> {
  const SolanaRequestGetSlotLeaders(
      {required this.startSlot, required this.limit});

  /// getSlotLeaders
  @override
  String get method => SolanaRequestMethods.getSlotLeaders.value;

  /// Start slot, as u64 integer
  final int startSlot;

  /// Limit, as u64 integer (between 1 and 5,000)
  final int limit;
  @override
  List<dynamic> toJson() {
    return [startSlot, limit];
  }

  @override
  List<SolAddress> onResonse(result) {
    return result.map((e) => SolAddress.uncheckCurve(e)).toList();
  }
}
