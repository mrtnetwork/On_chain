import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/vote/types/types.dart';
import 'package:on_chain/solana/src/rpc/core/rpc.dart';
import 'package:on_chain/solana/src/rpc/utils/solana_rpc_utils.dart';

/// Returns the account info and associated stake for all the voting accounts in the current bank.
/// https://solana.com/docs/rpc/http/getvoteaccounts
class SolanaRequestGetVoteAccounts
    extends SolanaRequest<VoteAccountStatus, Map<String, dynamic>> {
  const SolanaRequestGetVoteAccounts(
      {this.votePubkey,
      this.keepUnstakedDelinquents,
      this.delinquentSlotDistance,
      super.commitment});

  /// getVoteAccounts
  @override
  String get method => SolanaRequestMethods.getVoteAccounts.value;

  /// Only return results for this validator vote address (base-58 encoded)
  final SolAddress? votePubkey;

  /// Do not filter out delinquent validators with no stake
  final bool? keepUnstakedDelinquents;

  /// Specify the number of slots behind the tip that a validator must fall to be considered delinquent.
  /// NOTE: For the sake of consistency between ecosystem products,
  /// it is not recommended that this argument be specified.
  final int? delinquentSlotDistance;

  @override
  List<dynamic> toJson() {
    return [
      SolanaRequestUtils.createConfig([
        commitment?.toJson(),
        {'votePubkey': votePubkey?.address},
        {'keepUnstakedDelinquents': keepUnstakedDelinquents},
        {'delinquentSlotDistance': delinquentSlotDistance}
      ]),
    ];
  }

  @override
  VoteAccountStatus onResonse(Map<String, dynamic> result) {
    return VoteAccountStatus.fromJson(result);
  }
}
