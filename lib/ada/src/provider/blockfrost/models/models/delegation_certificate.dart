class ADATransactionDelegationCertificateResponse {
  /// Index of the certificate within the transaction
  final int certIndex;

  /// Bech32 delegation stake address
  final String address;

  /// Bech32 ID of delegated stake pool
  final String poolId;

  /// Epoch in which the delegation becomes active
  final int activeEpoch;

  ADATransactionDelegationCertificateResponse({
    required this.certIndex,
    required this.address,
    required this.poolId,
    required this.activeEpoch,
  });

  factory ADATransactionDelegationCertificateResponse.fromJson(
      Map<String, dynamic> json) {
    return ADATransactionDelegationCertificateResponse(
      certIndex: json['cert_index'],
      address: json['address'],
      poolId: json['pool_id'],
      activeEpoch: json['active_epoch'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cert_index': certIndex,
      'address': address,
      'pool_id': poolId,
      'active_epoch': activeEpoch,
    };
  }

  @override
  String toString() {
    return 'ADATransactionDelegationCertificateResponse${toJson()}';
  }
}
