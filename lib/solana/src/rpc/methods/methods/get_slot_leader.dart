import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/rpc.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the current slot leader
/// https://solana.com/docs/rpc/http/getslotleader
class SolanaRequestGetSlotLeader extends SolanaRequest<SolAddress, String> {
  const SolanaRequestGetSlotLeader({super.commitment, super.minContextSlot});

  /// getSlotLeader
  @override
  String get method => SolanaRequestMethods.getSlotLeader.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRequestUtils.createConfig(
          [commitment?.toJson(), minContextSlot?.toJson()])
    ];
  }

  @override
  SolAddress onResonse(String result) {
    return SolAddress.uncheckCurve(result);
  }
}
