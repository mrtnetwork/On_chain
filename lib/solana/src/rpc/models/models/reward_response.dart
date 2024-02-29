import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';

class RewardResponse {
  const RewardResponse(
      {required this.pubkey,
      required this.lamports,
      required this.postBalance,
      required this.rewardType,
      required this.commission});
  factory RewardResponse.fromJson(Map<String, dynamic> json) {
    return RewardResponse(
        pubkey: SolAddress.uncheckCurve(json["pubkey"]),
        lamports: BigintUtils.parse(json["lamports"]),
        postBalance: BigintUtils.tryParse(json["postBalance"]),
        rewardType: json["rewardType"],
        commission: json["commission"]);
  }

  /// Public key of reward recipient
  final SolAddress pubkey;

  /// Reward value in lamports
  final BigInt lamports;

  /// Account balance after reward is applied
  final BigInt? postBalance;

  /// Type of reward received
  final String? rewardType;

  /// Vote account commission when the reward was credited, only present for voting and staking rewards
  final int? commission;
}
