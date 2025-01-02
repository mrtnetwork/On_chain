class ADAMetadataCBORResponse {
  /// Transaction hash that contains the specific metadata
  final String txHash;

  /// Content of the CBOR metadata
  final String? cborMetadata;

  /// Content of the CBOR metadata in hex
  final String metadata;

  ADAMetadataCBORResponse({
    required this.txHash,
    this.cborMetadata,
    required this.metadata,
  });

  factory ADAMetadataCBORResponse.fromJson(Map<String, dynamic> json) {
    return ADAMetadataCBORResponse(
      txHash: json['tx_hash'],
      cborMetadata: json['cbor_metadata'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tx_hash': txHash,
        'cbor_metadata': cborMetadata,
        'metadata': metadata,
      };

  @override
  String toString() {
    return 'ADAMetadataCBORResponse${toJson()}';
  }
}
