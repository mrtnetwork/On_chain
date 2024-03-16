class ADATransactionPoolRetirementCertificateResponse {
  /// Index of the certificate within the transaction
  final int certIndex;

  /// Bech32 encoded pool ID
  final String poolId;

  /// Epoch in which the pool becomes retired
  final int retiringEpoch;

  ADATransactionPoolRetirementCertificateResponse({
    required this.certIndex,
    required this.poolId,
    required this.retiringEpoch,
  });

  factory ADATransactionPoolRetirementCertificateResponse.fromJson(
      Map<String, dynamic> json) {
    return ADATransactionPoolRetirementCertificateResponse(
      certIndex: json['cert_index'],
      poolId: json['pool_id'],
      retiringEpoch: json['retiring_epoch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cert_index': certIndex,
      'pool_id': poolId,
      'retiring_epoch': retiringEpoch,
    };
  }
}
