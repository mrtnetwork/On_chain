import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the inflation / staking reward for a list of addresses for an epoch
/// https://solana.com/docs/rpc/http/getinflationreward
class SolanaRequestGetInflationReward
    extends SolanaRequest<List<InflationReward?>, List> {
  const SolanaRequestGetInflationReward(
      {this.addresses, this.epoch, super.commitment, super.minContextSlot});

  /// getInflationReward
  @override
  String get method => SolanaRequestMethods.getInflationReward.value;

  /// An array of addresses to query, as base-58 encoded strings
  final List<String>? addresses;

  /// An epoch for which the reward occurs. If omitted, the previous epoch will be used
  final int? epoch;

  @override
  List<dynamic> toJson() {
    return [
      addresses,
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        {'epoch': epoch},
        minContextSlot?.toJson(),
      ]),
    ];
  }

  @override
  List<InflationReward?> onResonse(List result) {
    return result
        .map((e) => e == null ? null : InflationReward.fromJson(e))
        .toList();
  }
}
