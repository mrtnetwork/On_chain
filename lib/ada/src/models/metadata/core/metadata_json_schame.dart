/// Enum representing different JSON schemas for metadata.
class MetadataJsonSchema {
  /// The integer value representing the JSON schema.
  final int value;

  /// The name of the JSON schema.
  final String name;

  /// Constructs a MetadataJsonSchema with the given value and name.
  const MetadataJsonSchema._(this.value, this.name);

  /// No conversions JSON schema.
  static const MetadataJsonSchema noConversions =
      MetadataJsonSchema._(0, "NoConversions");

  /// Basic conversions JSON schema.
  static const MetadataJsonSchema basicConversions =
      MetadataJsonSchema._(1, "BasicConversions");

  /// Detailed schema JSON schema.
  static const MetadataJsonSchema detailedSchema =
      MetadataJsonSchema._(2, "DetailedSchema");

  static const List<MetadataJsonSchema> values = [
    noConversions,
    basicConversions,
    detailedSchema
  ];

  @override
  String toString() {
    return "MetadataJsonSchema.$name";
  }
}
