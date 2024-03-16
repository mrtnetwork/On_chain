class ADAAmountResponse {
  /// The unit of the value
  final String unit;

  /// The quantity of the unit
  final String quantity;

  /// Number of decimal places of the asset unit
  final int? decimals;

  /// True if the latest minting transaction includes metadata
  final bool? hasNftOnchainMetadata;

  ADAAmountResponse({
    required this.unit,
    required this.quantity,
    this.decimals,
    this.hasNftOnchainMetadata,
  });

  factory ADAAmountResponse.fromJson(Map<String, dynamic> json) {
    return ADAAmountResponse(
      unit: json['unit'],
      quantity: json['quantity'],
      decimals: json['decimals'],
      hasNftOnchainMetadata: json['has_nft_onchain_metadata'],
    );
  }

  Map<String, dynamic> toJson() => {
        'unit': unit,
        'quantity': quantity,
        'decimals': decimals,
        'hasNftOnchainMetadata': hasNftOnchainMetadata
      };

  @override
  String toString() {
    return "ADAAmountResponse${toJson()}";
  }
}
