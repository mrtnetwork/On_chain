class ADAMetadataLabelResponse {
  /// Metadata label
  final String label;

  /// CIP10 defined description
  final String? cip10;

  /// The count of metadata entries with a specific label
  final String count;

  ADAMetadataLabelResponse({
    required this.label,
    this.cip10,
    required this.count,
  });

  factory ADAMetadataLabelResponse.fromJson(Map<String, dynamic> json) {
    return ADAMetadataLabelResponse(
      label: json['label'],
      cip10: json['cip10'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'cip10': cip10,
        'count': count,
      };

  @override
  String toString() {
    return 'ADAMetadataLabelResponse{${toJson()}}';
  }
}
