class ADADeriveAddressResponse {
  /// Script hash
  final String xpub;

  /// Account role
  final int role;

  /// Address index
  final int index;

  /// Derived address
  final String address;

  ADADeriveAddressResponse({
    required this.xpub,
    required this.role,
    required this.index,
    required this.address,
  });

  factory ADADeriveAddressResponse.fromJson(Map<String, dynamic> json) {
    return ADADeriveAddressResponse(
      xpub: json['xpub'],
      role: json['role'],
      index: json['index'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'xpub': xpub,
      'role': role,
      'index': index,
      'address': address,
    };
  }

  @override
  String toString() {
    return 'ADADeriveAddressResponse${toJson()}';
  }
}
