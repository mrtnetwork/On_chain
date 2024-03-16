class ADATransactionMetadataCBORResponse {
  /// Metadata label
  final String label;

  /// Content of the CBOR metadata in hex
  final String metadata;

  ADATransactionMetadataCBORResponse({
    required this.label,
    required this.metadata,
  });

  factory ADATransactionMetadataCBORResponse.fromJson(Map<String, dynamic> json) {
    return ADATransactionMetadataCBORResponse(
      label: json['label'],
      metadata: json['metadata'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'metadata': metadata,
    };
  }

  @override
  String toString() {
    return "ADATransactionMetadataCBORResponse${toJson()}";
  }
}
