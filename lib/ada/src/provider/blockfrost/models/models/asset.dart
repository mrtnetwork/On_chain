class ADAAssetResponse {
  /// Hex-encoded asset full name
  final String asset;

  /// Policy ID of the asset
  final String policyId;

  /// Hex-encoded asset name of the asset
  final String? assetName;

  /// CIP14 based user-facing fingerprint
  final String fingerprint;

  /// Current asset quantity
  final String quantity;

  /// ID of the initial minting transaction
  final String initialMintTxHash;

  /// Count of mint and burn transactions
  final int mintOrBurnCount;

  /// On-chain metadata
  final ADAOnchainMetadata? onchainMetadata;

  /// Off-chain metadata
  final ADAOffchainMetadata? metadata;

  ADAAssetResponse({
    required this.asset,
    required this.policyId,
    this.assetName,
    required this.fingerprint,
    required this.quantity,
    required this.initialMintTxHash,
    required this.mintOrBurnCount,
    required this.onchainMetadata,
    required this.metadata,
  });

  factory ADAAssetResponse.fromJson(Map<String, dynamic> json) {
    return ADAAssetResponse(
      asset: json['asset'],
      policyId: json['policy_id'],
      assetName: json['asset_name'],
      fingerprint: json['fingerprint'],
      quantity: json['quantity'],
      initialMintTxHash: json['initial_mint_tx_hash'],
      mintOrBurnCount: json['mint_or_burn_count'],
      onchainMetadata: json['onchain_metadata'] != null
          ? ADAOnchainMetadata.fromJson(json['onchain_metadata'])
          : null,
      metadata: json['metadata'] == null
          ? null
          : ADAOffchainMetadata.fromJson(json['metadata']),
    );
  }

  Map<String, dynamic> toJson() => {
        'asset': asset,
        'policy_id': policyId,
        'asset_name': assetName,
        'fingerprint': fingerprint,
        'quantity': quantity,
        'initial_mint_tx_hash': initialMintTxHash,
        'mint_or_burn_count': mintOrBurnCount,
        'onchain_metadata': onchainMetadata?.toJson(),
        'metadata': metadata?.toJson(),
      };
  @override
  String toString() {
    return 'ADAAssetResponse${toJson()}';
  }
}

class ADAOnchainMetadata {
  final dynamic propertyName;
  final String? onchainMetadataStandard;
  final String? onchainMetadataExtra;

  ADAOnchainMetadata({
    required this.propertyName,
    required this.onchainMetadataStandard,
    required this.onchainMetadataExtra,
  });

  factory ADAOnchainMetadata.fromJson(Map<String, dynamic> json) {
    return ADAOnchainMetadata(
      propertyName: json['property_name'],
      onchainMetadataStandard: json['onchain_metadata_standard'],
      onchainMetadataExtra: json['onchain_metadata_extra'],
    );
  }

  Map<String, dynamic> toJson() => {
        'property_name': propertyName,
        'onchain_metadata_standard': onchainMetadataStandard,
        'onchain_metadata_extra': onchainMetadataExtra,
      };
  @override
  String toString() {
    return 'ADAOnchainMetadata${toJson()}';
  }
}

class ADAOffchainMetadata {
  /// Asset name
  final String name;

  /// Asset description
  final String description;

  /// Asset ticker
  final String? ticker;

  /// Asset website
  final String? url;

  /// Base64 encoded logo of the asset
  final String? logo;

  /// Number of decimal places of the asset unit
  final int? decimals;

  ADAOffchainMetadata({
    required this.name,
    required this.description,
    this.ticker,
    this.url,
    this.logo,
    this.decimals,
  });

  factory ADAOffchainMetadata.fromJson(Map<String, dynamic> json) {
    return ADAOffchainMetadata(
      name: json['name'],
      description: json['description'],
      ticker: json['ticker'],
      url: json['url'],
      logo: json['logo'],
      decimals: json['decimals'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'ticker': ticker,
        'url': url,
        'logo': logo,
        'decimals': decimals,
      };

  @override
  String toString() {
    return 'ADAOffchainMetadata${toJson()}';
  }
}
