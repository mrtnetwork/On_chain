class ADAStakeAccountDelegationHistoryResponse {
  /// Epoch in which the delegation becomes active
  final int activeEpoch;

  /// Hash of the transaction containing the delegation
  final String txHash;

  /// Rewards for given epoch in Lovelaces
  final String amount;

  /// Bech32 ID of pool being delegated to
  final String poolId;

  ADAStakeAccountDelegationHistoryResponse({
    required this.activeEpoch,
    required this.txHash,
    required this.amount,
    required this.poolId,
  });

  factory ADAStakeAccountDelegationHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ADAStakeAccountDelegationHistoryResponse(
      activeEpoch: json['active_epoch'],
      txHash: json['tx_hash'],
      amount: json['amount'],
      poolId: json['pool_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'active_epoch': activeEpoch,
        'tx_hash': txHash,
        'amount': amount,
        'pool_id': poolId,
      };

  @override
  String toString() {
    return "ADAStakeAccountDelegationHistoryResponse${toJson()}";
  }
}
