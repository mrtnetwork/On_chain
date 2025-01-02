class ADAAssetsResponse {
  /// Asset identifier (Concatenation of the policy_id and hex-encoded asset_name)
  final String assetId;

  /// Current asset quantity
  final String quantity;

  ADAAssetsResponse({
    required this.assetId,
    required this.quantity,
  });

  factory ADAAssetsResponse.fromJson(Map<String, dynamic> json) {
    return ADAAssetsResponse(
      assetId: json['asset'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() => {
        'asset': assetId,
        'quantity': quantity,
      };
  @override
  String toString() {
    return 'ADAAssetResponse${toJson()}';
  }
}
