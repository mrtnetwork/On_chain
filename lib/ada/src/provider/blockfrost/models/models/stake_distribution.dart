class ADAStakeDistributionResponse {
  /// Stake address
  final String stakeAddress;

  /// Bech32 prefix of the pool delegated to
  final String poolId;

  /// Amount of active delegated stake in Lovelaces
  final String amount;

  ADAStakeDistributionResponse({
    required this.stakeAddress,
    required this.poolId,
    required this.amount,
  });

  factory ADAStakeDistributionResponse.fromJson(Map<String, dynamic> json,
      {String? poolId}) {
    return ADAStakeDistributionResponse(
      stakeAddress: json['stake_address'],
      poolId: poolId ?? json['pool_id'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'stake_address': stakeAddress,
        'pool_id': poolId,
        'amount': amount,
      };

  @override
  String toString() {
    return 'ADAStakeDistributionResponse${toJson()}';
  }
}
