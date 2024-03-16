import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/metadata/core/meta_data.dart';

/// Represents transaction metadata containing bytes.
class TransactionMetadataBytes extends TransactionMetadata<List<int>> {
  /// The bytes value of the metadata.
  @override
  final List<int> value;

  /// Constructs a TransactionMetadataBytes object.
  TransactionMetadataBytes({required List<int> value})
      : value = BytesUtils.toBytes(value, unmodifiable: true);

  /// Deserializes a TransactionMetadataBytes object from CBOR.
  factory TransactionMetadataBytes.deserialize(CborBytesValue cbor) {
    return TransactionMetadataBytes(value: cbor.value);
  }
  factory TransactionMetadataBytes.fromJson(Map<String, dynamic> json) {
    return TransactionMetadataBytes(
        value: BytesUtils.fromHexString(json["bytes"]));
  }
  TransactionMetadataBytes copyWith({List<int>? value}) {
    return TransactionMetadataBytes(value: value ?? this.value);
  }

  /// Returns the type of the metadata.
  @override
  TransactionMetadataType get type => TransactionMetadataType.metadataBytes;

  /// Converts the metadata to JSON.
  @override
  Map<String, dynamic> toJson() {
    return {"bytes": BytesUtils.toHexString(value)};
  }

  @override
  toJsonSchema(
      {MetadataSchemaConfig config = const MetadataSchemaConfig(
          jsonSchema: MetadataJsonSchema.noConversions)}) {
    if (config.jsonSchema == MetadataJsonSchema.noConversions) {
      throw MessageException("bytes not allowed in JSON in specified schema.");
    }
    if (config.jsonSchema == MetadataJsonSchema.detailedSchema) {
      return {"bytes": BytesUtils.toHexString(value)};
    }
    return BytesUtils.toHexString(value, prefix: "0x");
  }

  /// Converts the metadata to CBOR.
  @override
  CborObject toCbor() {
    return CborBytesValue(value);
  }

  @override
  int compareTo(TransactionMetadata other) {
    if (other is! TransactionMetadata<List<int>>) return super.compareTo(other);
    final lenComparison = value.length.compareTo(other.value.length);
    if (lenComparison == 0) {
      return BytesUtils.compareBytes(value, other.value);
    }
    return lenComparison;
  }
}
