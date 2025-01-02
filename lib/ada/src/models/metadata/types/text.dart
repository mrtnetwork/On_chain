import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/types/types.dart';
import 'package:on_chain/ada/src/models/metadata/core/meta_data.dart';

/// Represents transaction metadata containing text data.
class TransactionMetadataText extends TransactionMetadata<String> {
  /// The text value of the metadata.
  @override
  final String value;

  /// Constructs a TransactionMetadataText object.
  const TransactionMetadataText({required this.value});

  /// Deserializes a TransactionMetadataText object from CBOR.
  factory TransactionMetadataText.deserialize(CborStringValue cbor) {
    return TransactionMetadataText(value: cbor.value);
  }
  factory TransactionMetadataText.fromJson(Map<String, dynamic> json) {
    return TransactionMetadataText(value: json['string']);
  }
  TransactionMetadataText copyWith({String? value}) {
    return TransactionMetadataText(value: value ?? this.value);
  }

  /// Returns the type of the metadata.
  @override
  TransactionMetadataType get type => TransactionMetadataType.metadataText;

  /// Converts the metadata to JSON.
  @override
  Map<String, dynamic> toJson() {
    return {'string': value};
  }

  @override
  Object toJsonSchema(
      {MetadataSchemaConfig config = const MetadataSchemaConfig(
          jsonSchema: MetadataJsonSchema.noConversions)}) {
    if (config.jsonSchema == MetadataJsonSchema.detailedSchema) {
      return {'string': value};
    }
    return value;
  }

  /// Converts the metadata to CBOR.
  @override
  CborObject toCbor() {
    return CborStringValue(value);
  }

  /// Compares this metadata text with another metadata text.
  @override
  int compareTo(TransactionMetadata other) {
    if (other is! TransactionMetadata<String>) {
      return super.compareTo(other);
    }
    return value.compareTo(other.value);
  }
}
