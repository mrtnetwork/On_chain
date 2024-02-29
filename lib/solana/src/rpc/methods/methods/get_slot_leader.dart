import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/rpc/core/rpc.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the current slot leader
/// https://solana.com/docs/rpc/http/getslotleader
class SolanaRPCGetSlotLeader extends SolanaRPCRequest<SolAddress> {
  const SolanaRPCGetSlotLeader(
      {Commitment? commitment, MinContextSlot? minContextSlot})
      : super(commitment: commitment, minContextSlot: minContextSlot);

  /// getSlotLeader
  @override
  String get method => SolanaRPCMethods.getSlotLeader.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRPCUtils.createConfig(
          [commitment?.toJson(), minContextSlot?.toJson()])
    ];
  }

  @override
  SolAddress onResonse(result) {
    return SolAddress.uncheckCurve(result);
  }
}
