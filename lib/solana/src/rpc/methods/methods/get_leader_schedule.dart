import 'package:on_chain/solana/src/rpc/core/core.dart';
import 'package:on_chain/solana/src/rpc/core/methods.dart';
import 'package:on_chain/solana/src/rpc/models/rpc_models.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the leader schedule for an epoch
/// https://solana.com/docs/rpc/http/getleaderschedule
class SolanaRPCGetLeaderSchedule extends SolanaRPCRequest<LeaderSchedule> {
  const SolanaRPCGetLeaderSchedule(
      {this.slot, this.identity, Commitment? commitment})
      : super(commitment: commitment);

  /// getLeaderSchedule
  @override
  String get method => SolanaRPCMethods.getLeaderSchedule.value;

  /// Fetch the leader schedule for the epoch that corresponds to the provided slot.
  /// If unspecified, the leader schedule for the current epoch is fetched
  final int? slot;

  /// Only return results for this validator identity (base-58 encoded)
  final String? identity;

  @override
  List<dynamic> toJson() {
    return [
      slot,
      SolanaRPCUtils.createConfig([
        commitment?.toJson(),
        {"identity": identity}
      ]),
    ];
  }

  @override
  LeaderSchedule onResonse(result) {
    return LeaderSchedule.fromJson(result);
  }
}
