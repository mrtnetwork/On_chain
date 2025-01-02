import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the slot that has reached the given or default commitment level
/// https://solana.com/docs/rpc/http/getslot
class SolanaRequestGetSlot extends SolanaRequest<int, int> {
  const SolanaRequestGetSlot({super.commitment, super.minContextSlot});

  /// getSlot
  @override
  String get method => SolanaRequestMethods.getSlot.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRequestUtils.createConfig(
          [commitment?.toJson(), minContextSlot?.toJson()])
    ];
  }
}
