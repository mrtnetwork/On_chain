import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the slot that has reached the given or default commitment level
/// https://solana.com/docs/rpc/http/getslot
class SolanaRPCGetSlot extends SolanaRPCRequest<int> {
  const SolanaRPCGetSlot(
      {Commitment? commitment, MinContextSlot? minContextSlot})
      : super(commitment: commitment, minContextSlot: minContextSlot);

  /// getSlot
  @override
  String get method => SolanaRPCMethods.getSlot.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRPCUtils.createConfig(
          [commitment?.toJson(), minContextSlot?.toJson()])
    ];
  }
}
