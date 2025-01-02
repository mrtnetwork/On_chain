import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the latest blockhash
/// https://solana.com/docs/rpc/http/getlatestblockhash
class SolanaRequestGetLatestBlockhash extends SolanaRequest<
    BlockhashWithExpiryBlockHeight, Map<String, dynamic>> {
  const SolanaRequestGetLatestBlockhash(
      {super.commitment = Commitment.finalized, super.minContextSlot});

  /// getLatestBlockhash
  @override
  String get method => SolanaRequestMethods.getLatestBlockhash.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRequestUtils.createConfig(
          [commitment?.toJson(), minContextSlot?.toJson()])
    ];
  }

  @override
  BlockhashWithExpiryBlockHeight onResonse(Map<String, dynamic> result) {
    return BlockhashWithExpiryBlockHeight.fromJson(result);
  }
}
