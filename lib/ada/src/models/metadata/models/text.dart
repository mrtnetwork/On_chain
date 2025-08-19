import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/types/types.dart';
import 'config.dart';
import 'metadata_json_schame.dart';
import 'tranasction_metadata.dart';
import 'transaction_metadata_types.dart';

class TransactionMetadataTextSerializationConfig {
  final CborLengthEncoding encoding;
  const TransactionMetadataTextSerializationConfig(
      {this.encoding = CborLengthEncoding.canonical});
  factory TransactionMetadataTextSerializationConfig.fromJson(
      Map<String, dynamic> json) {
    return TransactionMetadataTextSerializationConfig(
        encoding: json["encoding"] == null
            ? CborLengthEncoding.canonical
            : CborLengthEncoding.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name};
  }
}

/// Represents transaction metadata containing text data.
class TransactionMetadataText extends TransactionMetadata<String> {
  /// The text value of the metadata.
  @override
  final String value;

  final TransactionMetadataTextSerializationConfig serializationConfig;

  /// Constructs a TransactionMetadataText object.
  const TransactionMetadataText(
      {required this.value,
      this.serializationConfig =
          const TransactionMetadataTextSerializationConfig()});

  /// Deserializes a TransactionMetadataText object from CBOR.
  factory TransactionMetadataText.deserialize(CborStringValue cbor) {
    return TransactionMetadataText(
        value: cbor.value,
        serializationConfig: TransactionMetadataTextSerializationConfig(
            encoding: cbor.lengthEncoding));
  }
  factory TransactionMetadataText.fromJson(Map<String, dynamic> json) {
    return TransactionMetadataText(
        value: json[TransactionMetadataType.metadataText.name],
        serializationConfig:
            TransactionMetadataTextSerializationConfig.fromJson(
                json["serialization_config"] ?? {}));
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
    return {
      type.name: value,
      'serialization_config': serializationConfig.toJson()
    };
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
  CborObject toCbor({bool sort = false}) {
    return CborStringValue(value, lengthEncoding: serializationConfig.encoding);
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
