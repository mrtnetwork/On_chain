/// The inflation reward for an epoch
class InflationReward {
  /// epoch for which the reward occurs
  final int epoch;

  /// the slot in which the rewards are effective
  final int effectiveSlot;

  /// reward amount in lamports
  final int amount;

  /// post balance of the account in lamports
  final int postBalance;

  /// vote account commission when the reward was credited
  final int? commission;
  const InflationReward(
      {required this.epoch,
      required this.effectiveSlot,
      required this.amount,
      required this.postBalance,
      required this.commission});
  factory InflationReward.fromJson(Map<String, dynamic> json) {
    return InflationReward(
        epoch: json['epoch'],
        effectiveSlot: json['effectiveSlot'],
        amount: json['amount'],
        postBalance: json['postBalance'],
        commission: json['commission']);
  }
}
