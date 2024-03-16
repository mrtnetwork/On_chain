import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/models/metadata/core/meta_data.dart';
import 'package:on_chain/ada/src/models/metadata/utils/metadata_utils.dart';

/// Represents transaction metadata containing a map of transaction metadata items.
class TransactionMetadataMap
    extends TransactionMetadata<Map<TransactionMetadata, TransactionMetadata>> {
  /// The map of transaction metadata items.
  @override
  final Map<TransactionMetadata, TransactionMetadata> value;

  /// Constructs a TransactionMetadataMap object.
  TransactionMetadataMap(
      {required Map<TransactionMetadata, TransactionMetadata> value})
      : value =
            Map<TransactionMetadata, TransactionMetadata>.unmodifiable(value);

  /// Deserializes a TransactionMetadataMap object from CBOR.
  factory TransactionMetadataMap.deserialize(CborMapValue cbor) {
    return TransactionMetadataMap(value: {
      for (final i in cbor.value.entries)
        TransactionMetadata.deserialize(i.key):
            TransactionMetadata.deserialize(i.value)
    });
  }
  factory TransactionMetadataMap.fromJson(Map<String, dynamic> json) {
    final Map<dynamic, dynamic> values = json["map"];
    return TransactionMetadataMap(value: {
      for (final i in values.entries)
        TransactionMetadata.fromJson(i.key):
            TransactionMetadata.fromJson(i.value)
    });
  }

  TransactionMetadataMap copyWith(
      {Map<TransactionMetadata, TransactionMetadata>? value}) {
    return TransactionMetadataMap(value: value ?? this.value);
  }

  /// Returns the type of the metadata.
  @override
  TransactionMetadataType get type => TransactionMetadataType.metadataMap;

  /// Converts the metadata to JSON.
  @override
  Map<String, dynamic> toJson() {
    return {
      "map": {for (final i in value.entries) i.key.toJson(): i.value.toJson()}
    };
  }

  /// Converts the metadata to CBOR.
  @override
  CborObject toCbor() {
    final keys = value.keys.toList()..sort((a, b) => a.compareTo(b));
    return CborMapValue.fixedLength(
        {for (final i in keys) i.toCbor(): value[i]!.toCbor()});
  }

  /// Compares this metadata map with another metadata map.
  @override
  int compareTo(TransactionMetadata other) {
    if (other is! TransactionMetadata<
        Map<TransactionMetadata, TransactionMetadata>>) {
      return super.compareTo(other);
    }
    final lenComparison = value.length.compareTo(other.value.length);
    if (lenComparison == 0) {
      for (int i = 0; i < value.entries.length; i++) {
        final entry = value.entries.elementAt(i);
        final otherEntry = other.value.entries.elementAt(i);
        final keyCompare = entry.key.compareTo(otherEntry.key);
        if (keyCompare != 0) return keyCompare;
        final valueCompare = entry.value.compareTo(otherEntry.value);
        if (valueCompare != 0) return valueCompare;
      }
    }
    return lenComparison;
  }

  @override
  toJsonSchema(
      {MetadataSchemaConfig config = const MetadataSchemaConfig(
          jsonSchema: MetadataJsonSchema.noConversions)}) {
    switch (config.jsonSchema) {
      case MetadataJsonSchema.noConversions:
      case MetadataJsonSchema.basicConversions:
        return {
          for (final i in value.entries)
            TransactionMetadataUtils.encodeKey(key: i.key, config: config):
                i.value.toJsonSchema(config: config)
        };
      default:
        return {
          "map": value.entries.map((entry) {
            final k = entry.key.toJsonSchema(config: config);
            final v = entry.value.toJsonSchema(config: config);
            return {'k': k, 'v': v};
          }).toList()
        };
    }
  }
}
