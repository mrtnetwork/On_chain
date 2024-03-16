class ADABlockAddressTransactionsResponse {
  /// Address that was affected in the specified block
  final String address;

  /// List of transactions containing the address either in their inputs or outputs
  final List<String> transactions;

  ADABlockAddressTransactionsResponse({
    required this.address,
    required this.transactions,
  });

  factory ADABlockAddressTransactionsResponse.fromJson(
      Map<String, dynamic> json) {
    var transactionsList = json['transactions'] as List;
    List<String> transactions =
        transactionsList.map((item) => item['tx_hash'] as String).toList();

    return ADABlockAddressTransactionsResponse(
      address: json['address'],
      transactions: transactions,
    );
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'transactions':
            transactions.map((txHash) => {'tx_hash': txHash}).toList(),
      };
  @override
  String toString() {
    return "ADABlockAddressTransactionsResponse${toJson()}";
  }
}
