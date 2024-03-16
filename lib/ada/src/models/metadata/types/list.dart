import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/metadata/core/meta_data.dart';

/// Represents transaction metadata containing a list of transaction metadata items.
class TransactionMetadataList
    extends TransactionMetadata<List<TransactionMetadata>> {
  /// The list of transaction metadata items.
  @override
  final List<TransactionMetadata> value;

  /// Constructs a TransactionMetadataList object.
  TransactionMetadataList({required List<TransactionMetadata> value})
      : value = List<TransactionMetadata>.unmodifiable(value);

  /// Deserializes a TransactionMetadataList object from CBOR.
  factory TransactionMetadataList.deserialize(CborListValue cbor) {
    return TransactionMetadataList(
        value:
            cbor.value.map((e) => TransactionMetadata.deserialize(e)).toList());
  }
  factory TransactionMetadataList.fromJson(Map<String, dynamic> json) {
    return TransactionMetadataList(
        value: (json["list"] as List)
            .map((e) => TransactionMetadata.deserialize(e))
            .toList());
  }
  TransactionMetadataList copyWith({List<TransactionMetadata>? value}) {
    return TransactionMetadataList(value: value ?? this.value);
  }

  /// Returns the type of the metadata.
  @override
  TransactionMetadataType get type => TransactionMetadataType.metadataList;

  /// Converts the metadata to JSON.
  @override
  Map<String, dynamic> toJson() {
    return {"list": value.map((e) => e.toJson()).toList()};
  }

  /// Converts the metadata to CBOR.
  @override
  CborObject toCbor() {
    return CborListValue.fixedLength(value.map((e) => e.toCbor()).toList());
  }

  /// Compares this metadata list with another metadata list.
  @override
  int compareTo(TransactionMetadata other) {
    if (other is! TransactionMetadata<List<TransactionMetadata>>) {
      return super.compareTo(other);
    }
    final lenComparison = value.length.compareTo(other.value.length);
    if (lenComparison == 0) {
      for (int i = 0; i < value.length; i++) {
        final valueCompare =
            value.elementAt(i).compareTo(other.value.elementAt(i));
        if (valueCompare != 0) return valueCompare;
      }
    }
    return lenComparison;
  }

  @override
  toJsonSchema(
      {MetadataSchemaConfig config = const MetadataSchemaConfig(
          jsonSchema: MetadataJsonSchema.noConversions)}) {
    if (config.jsonSchema == MetadataJsonSchema.detailedSchema) {
      return {
        "list": value.map((e) => e.toJsonSchema(config: config)).toList()
      };
    }
    return value.map((e) => e.toJsonSchema(config: config)).toList();
  }
}
