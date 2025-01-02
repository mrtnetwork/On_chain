import 'package:on_chain/solana/src/address/sol_address.dart';

/// Information describing a vote account
class VoteAccountInfo {
  const VoteAccountInfo(
      {required this.votePubkey,
      required this.nodePubkey,
      required this.activatedStake,
      required this.epochVoteAccount,
      required this.epochCredits,
      required this.commission,
      required this.lastVote});
  factory VoteAccountInfo.fromJson(Map<String, dynamic> json) {
    return VoteAccountInfo(
        votePubkey: SolAddress.uncheckCurve(json['votePubkey']),
        nodePubkey: SolAddress.uncheckCurve(json['nodePubkey']),
        activatedStake: json['activatedStake'],
        epochVoteAccount: json['epochVoteAccount'],
        epochCredits: (json['epochCredits'] as List)
            .map<List<int>>((e) => (e as List).cast())
            .toList(),
        commission: json['commission'],
        lastVote: json['lastVote']);
  }

  /// Public key of the vote account
  final SolAddress votePubkey;

  /// Identity public key of the node voting with this account
  final SolAddress nodePubkey;

  /// The stake, in lamports, delegated to this vote account and activated
  final int activatedStake;

  /// Whether the vote account is staked for this epoch
  final bool epochVoteAccount;

  /// Recent epoch voting credit history for this voter
  final List<List<int>> epochCredits;

  /// A percentage (0-100) of rewards payout owed to the voter
  final int commission;

  /// Most recent slot voted on by this vote account
  final int lastVote;
}
