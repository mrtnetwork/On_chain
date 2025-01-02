class ADAStakeAccountResponse {
  final String stakeAddress;
  final bool active;
  final int? activeEpoch;
  final String controlledAmount;
  final String rewardsSum;
  final String withdrawalsSum;
  final String reservesSum;
  final String treasurySum;
  final String withdrawableAmount;
  final String? poolId;

  ADAStakeAccountResponse({
    required this.stakeAddress,
    required this.active,
    this.activeEpoch,
    required this.controlledAmount,
    required this.rewardsSum,
    required this.withdrawalsSum,
    required this.reservesSum,
    required this.treasurySum,
    required this.withdrawableAmount,
    this.poolId,
  });

  factory ADAStakeAccountResponse.fromJson(Map<String, dynamic> json) {
    return ADAStakeAccountResponse(
      stakeAddress: json['stake_address'],
      active: json['active'],
      activeEpoch: json['active_epoch'],
      controlledAmount: json['controlled_amount'],
      rewardsSum: json['rewards_sum'],
      withdrawalsSum: json['withdrawals_sum'],
      reservesSum: json['reserves_sum'],
      treasurySum: json['treasury_sum'],
      withdrawableAmount: json['withdrawable_amount'],
      poolId: json['pool_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stake_address'] = stakeAddress;
    data['active'] = active;
    data['active_epoch'] = activeEpoch;
    data['controlled_amount'] = controlledAmount;
    data['rewards_sum'] = rewardsSum;
    data['withdrawals_sum'] = withdrawalsSum;
    data['reserves_sum'] = reservesSum;
    data['treasury_sum'] = treasurySum;
    data['withdrawable_amount'] = withdrawableAmount;
    data['pool_id'] = poolId;
    return data;
  }

  @override
  String toString() {
    return 'ADAStakeAccountResponse${toJson()}';
  }
}
