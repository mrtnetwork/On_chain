class ADAAssetBalanceResponse {
  /// Address containing the specific asset
  final String address;

  /// Asset quantity on the specific address
  final String quantity;

  ADAAssetBalanceResponse({
    required this.address,
    required this.quantity,
  });

  factory ADAAssetBalanceResponse.fromJson(Map<String, dynamic> json) {
    return ADAAssetBalanceResponse(
      address: json['address'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
        'address': address,
        'quantity': quantity,
      };

  @override
  String toString() {
    return 'ADAAssetBalanceResponse${toJson()}';
  }
}
