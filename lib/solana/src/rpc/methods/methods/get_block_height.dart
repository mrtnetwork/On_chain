import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the current block height of the node
/// https://solana.com/docs/rpc/http/getblockheight
class SolanaRequestGetBlockHeight extends SolanaRequest<int, int> {
  const SolanaRequestGetBlockHeight({super.commitment, super.minContextSlot});

  /// getBlockHeight
  @override
  String get method => SolanaRequestMethods.getBlockHeight.value;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
      ])
    ];
  }
}
