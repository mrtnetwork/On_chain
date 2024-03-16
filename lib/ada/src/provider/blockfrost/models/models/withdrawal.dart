class ADATransactionWithdrawalResponse {
  /// Bech32 withdrawal address
  final String address;

  /// Withdrawal amount in Lovelaces
  final String amount;

  ADATransactionWithdrawalResponse({
    required this.address,
    required this.amount,
  });

  factory ADATransactionWithdrawalResponse.fromJson(Map<String, dynamic> json) {
    return ADATransactionWithdrawalResponse(
      address: json['address'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return "ADATransactionWithdrawalResponse${toJson()}";
  }
}
