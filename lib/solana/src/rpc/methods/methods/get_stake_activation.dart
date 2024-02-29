import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/stake/stake.dart';
import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Pubkey of stake Account to query, as base-58 encoded string
/// https://solana.com/docs/rpc/http/getstakeactivation
class SolanaRPCGetStakeActivation
    extends SolanaRPCRequest<StakeActivationData> {
  const SolanaRPCGetStakeActivation(
      {required this.account,
      this.epoch,
      Commitment? commitment,
      MinContextSlot? minContextSlot})
      : super(commitment: commitment, minContextSlot: minContextSlot);

  /// getStakeActivation
  @override
  String get method => SolanaRPCMethods.getStakeActivation.value;

  /// Pubkey of stake Account to query, as base-58 encoded string
  final SolAddress account;

  /// epoch for which to calculate activation details.
  /// If parameter not provided, defaults to current epoch. DEPRECATED,
  /// inputs other than the current epoch return an error.
  final int? epoch;

  @override
  List<dynamic> toJson() {
    return [
      account.address,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        minContextSlot?.toJson(),
        {"epoch": epoch}
      ])
    ];
  }

  @override
  StakeActivationData onResonse(result) {
    return StakeActivationData.fromJson(result);
  }
}
