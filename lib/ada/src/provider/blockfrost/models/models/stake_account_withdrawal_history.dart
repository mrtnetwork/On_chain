class ADAStakeAccountWithdrawalHistoryResponse {
  /// Hash of the transaction containing the withdrawal
  final String txHash;

  /// Withdrawal amount in Lovelaces
  final String amount;

  ADAStakeAccountWithdrawalHistoryResponse({
    required this.txHash,
    required this.amount,
  });

  factory ADAStakeAccountWithdrawalHistoryResponse.fromJson(
      Map<String, dynamic> json) {
    return ADAStakeAccountWithdrawalHistoryResponse(
      txHash: json['tx_hash'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tx_hash': txHash,
        'amount': amount,
      };
  @override
  String toString() {
    return "ADAStakeAccountWithdrawalHistoryResponse${toJson()}";
  }
}
