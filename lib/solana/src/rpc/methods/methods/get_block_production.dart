import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns recent block production information from the current or previous epoch.
/// https://solana.com/docs/rpc/http/getblockproduction
class SolanaRPCGetBlockProduction extends SolanaRPCRequest<BlockProduction> {
  const SolanaRPCGetBlockProduction(
      {this.identity, this.range, Commitment? commitment})
      : super(
          commitment: commitment,
        );

  /// getBlockProduction
  @override
  String get method => SolanaRPCMethods.getBlockProduction.value;

  /// Only return results for this validator identity (base-58 encoded)
  final String? identity;

  /// Slot range to return block production for.
  /// If parameter not provided, defaults to current epoch.
  final RPCBlockRangeConfig? range;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        {"identity": identity},
        range?.toJson(),
      ])
    ];
  }

  @override
  BlockProduction onResonse(result) {
    return BlockProduction.fromJson(result);
  }
}
