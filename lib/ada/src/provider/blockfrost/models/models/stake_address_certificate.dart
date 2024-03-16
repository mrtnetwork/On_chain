class ADATransactionStakeAddressCertificateResponse {
  /// Index of the certificate within the transaction
  final int certIndex;

  /// Delegation stake address
  final String address;

  /// Registration boolean, false if deregistration
  final bool registration;

  ADATransactionStakeAddressCertificateResponse({
    required this.certIndex,
    required this.address,
    required this.registration,
  });

  factory ADATransactionStakeAddressCertificateResponse.fromJson(
      Map<String, dynamic> json) {
    return ADATransactionStakeAddressCertificateResponse(
      certIndex: json['cert_index'],
      address: json['address'],
      registration: json['registration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cert_index': certIndex,
      'address': address,
      'registration': registration,
    };
  }
}
