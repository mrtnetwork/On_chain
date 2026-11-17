class ADAStakeAccountHistoryResponse {
  /// Epoch in which the stake was active
  final int activeEpoch;

  /// Stake amount in Lovelaces
  final String amount;

  /// Bech32 ID of pool being delegated to
  final String poolId;

  ADAStakeAccountHistoryResponse({
    required this.activeEpoch,
    required this.amount,
    required this.poolId,
  });

  factory ADAStakeAccountHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ADAStakeAccountHistoryResponse(
      activeEpoch: json['active_epoch'],
      amount: json['amount'],
      poolId: json['pool_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active_epoch'] = activeEpoch;
    data['amount'] = amount;
    data['pool_id'] = poolId;
    return data;
  }
}
