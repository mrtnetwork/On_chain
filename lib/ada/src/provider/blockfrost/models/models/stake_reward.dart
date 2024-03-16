class ADARewardHistoryResponse {
  /// Epoch of the associated reward
  final int epoch;

  /// Rewards for given epoch in Lovelaces
  final String amount;

  /// Bech32 pool ID being delegated to
  final String poolId;

  /// Type of the reward. Possible values: [leader, member, pool_deposit_refund]
  final String type;

  ADARewardHistoryResponse({
    required this.epoch,
    required this.amount,
    required this.poolId,
    required this.type,
  });

  factory ADARewardHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ADARewardHistoryResponse(
      epoch: json['epoch'],
      amount: json['amount'],
      poolId: json['pool_id'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['epoch'] = epoch;
    data['amount'] = amount;
    data['pool_id'] = poolId;
    data['type'] = type;
    return data;
  }

  @override
  String toString() {
    return "ADARewardHistoryResponse${toJson()}";
  }
}
