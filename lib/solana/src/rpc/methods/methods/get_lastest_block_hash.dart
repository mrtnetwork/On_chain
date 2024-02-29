import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the latest blockhash
/// https://solana.com/docs/rpc/http/getlatestblockhash
class SolanaRPCGetLatestBlockhash
    extends SolanaRPCRequest<BlockhashWithExpiryBlockHeight> {
  const SolanaRPCGetLatestBlockhash(
      {Commitment? commitment = Commitment.finalized,
      MinContextSlot? minContextSlot})
      : super(commitment: commitment, minContextSlot: minContextSlot);

  /// getLatestBlockhash
  @override
  String get method => SolanaRPCMethods.getLatestBlockhash.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRPCUtils.createConfig(
          [commitment?.toJson(), minContextSlot?.toJson()])
    ];
  }

  @override
  BlockhashWithExpiryBlockHeight onResonse(result) {
    return BlockhashWithExpiryBlockHeight.fromJson(result);
  }
}
