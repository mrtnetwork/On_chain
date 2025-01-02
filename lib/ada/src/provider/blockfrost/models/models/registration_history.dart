class ADAStakeAccountRegistrationHistoryResponse {
  /// Hash of the transaction containing the (de)registration certificate
  final String txHash;

  /// Action in the certificate. Possible values: [registered, deregistered]
  final String action;

  ADAStakeAccountRegistrationHistoryResponse({
    required this.txHash,
    required this.action,
  });

  factory ADAStakeAccountRegistrationHistoryResponse.fromJson(
      Map<String, dynamic> json) {
    return ADAStakeAccountRegistrationHistoryResponse(
      txHash: json['tx_hash'],
      action: json['action'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tx_hash': txHash,
        'action': action,
      };

  @override
  String toString() {
    return 'ADAStakeAccountRegistrationHistoryResponse${toJson()}';
  }
}
