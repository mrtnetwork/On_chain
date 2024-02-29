import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the current block height of the node
/// https://solana.com/docs/rpc/http/getblockheight
class SolanaRPCGetBlockHeight extends SolanaRPCRequest<int> {
  const SolanaRPCGetBlockHeight(
      {Commitment? commitment, MinContextSlot? minContextSlot})
      : super(
          commitment: commitment,
          minContextSlot: minContextSlot,
        );

  /// getBlockHeight
  @override
  String get method => SolanaRPCMethods.getBlockHeight.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
      ])
    ];
  }
}
