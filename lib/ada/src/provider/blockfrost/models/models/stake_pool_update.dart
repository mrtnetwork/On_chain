class ADAStakePoolUpdateResponse {
  /// Transaction ID
  final String txHash;

  /// Certificate within the transaction
  final int certIndex;

  /// Action in the certificate
  /// Possible values: [registered, deregistered]
  final String action;

  ADAStakePoolUpdateResponse({
    required this.txHash,
    required this.certIndex,
    required this.action,
  });

  factory ADAStakePoolUpdateResponse.fromJson(Map<String, dynamic> json) {
    return ADAStakePoolUpdateResponse(
      txHash: json['tx_hash'],
      certIndex: json['cert_index'],
      action: json['action'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tx_hash': txHash,
      'cert_index': certIndex,
      'action': action,
    };
  }

  @override
  String toString() {
    return 'ADAStakePoolUpdateResponse${toJson()}';
  }
}
