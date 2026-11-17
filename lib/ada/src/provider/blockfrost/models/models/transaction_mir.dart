class ADATransactionMIRResponse {
  /// Source of MIR funds
  /// Possible values: [reserve, treasury]
  final String pot;

  /// Index of the certificate within the transaction
  final int certIndex;

  /// Bech32 stake address
  final String address;

  /// MIR amount in Lovelaces
  final String amount;

  ADATransactionMIRResponse({
    required this.pot,
    required this.certIndex,
    required this.address,
    required this.amount,
  });

  factory ADATransactionMIRResponse.fromJson(Map<String, dynamic> json) {
    return ADATransactionMIRResponse(
      pot: json['pot'],
      certIndex: json['cert_index'],
      address: json['address'],
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pot': pot,
      'cert_index': certIndex,
      'address': address,
      'amount': amount,
    };
  }

  @override
  String toString() {
    return 'ADATransactionMIRResponse${toJson()}';
  }
}
