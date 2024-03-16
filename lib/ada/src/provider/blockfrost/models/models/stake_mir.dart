class ADAStakeAccountMIRHistoryResponse {
  /// Hash of the transaction containing the MIR
  final String txHash;

  /// MIR amount in Lovelaces
  final String amount;

  const ADAStakeAccountMIRHistoryResponse({
    required this.txHash,
    required this.amount,
  });

  factory ADAStakeAccountMIRHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ADAStakeAccountMIRHistoryResponse(
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
    return "ADAStakeAccountMIRHistoryResponse${toJson()}";
  }
}
