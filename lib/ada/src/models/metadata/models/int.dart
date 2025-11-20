import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'config.dart';
import 'metadata_json_schame.dart';
import 'tranasction_metadata.dart';
import 'transaction_metadata_types.dart';

class TransactionMetadataIntSerializationConfig {
  final CborLengthEncoding encoding;
  const TransactionMetadataIntSerializationConfig(
      {this.encoding = CborLengthEncoding.canonical});
  factory TransactionMetadataIntSerializationConfig.fromJson(
      Map<String, dynamic> json) {
    return TransactionMetadataIntSerializationConfig(
        encoding: json["encoding"] == null
            ? CborLengthEncoding.canonical
            : CborLengthEncoding.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name};
  }
}

/// Represents transaction metadata containing an integer value.
class TransactionMetadataInt extends TransactionMetadata<BigInt> {
  /// The integer value of the metadata.
  @override
  final BigInt value;

  /// Constructs a TransactionMetadataInt object.
  const TransactionMetadataInt(
      {required this.value,
      this.serializationConfig =
          const TransactionMetadataIntSerializationConfig()});

  final TransactionMetadataIntSerializationConfig serializationConfig;

  /// Deserializes a TransactionMetadataInt object from CBOR.
  factory TransactionMetadataInt.deserialize(CborObject cbor) {
    if (cbor.hasType<CborBigIntValue>()) {
      final big = cbor.as<CborBigIntValue>();

      return TransactionMetadataInt(
          value: big.toBigInt(),
          serializationConfig: TransactionMetadataIntSerializationConfig(
              encoding: big.encoding));
    }
    return TransactionMetadataInt(value: cbor.as<CborNumeric>().toBigInt());
  }
  factory TransactionMetadataInt.fromJson(Map<String, dynamic> json) {
    return TransactionMetadataInt(
        value:
            BigintUtils.parse(json[TransactionMetadataType.metadataInt.name]),
        serializationConfig: TransactionMetadataIntSerializationConfig.fromJson(
            json['serialization_config']));
  }
  TransactionMetadataInt copyWith({BigInt? value}) {
    return TransactionMetadataInt(value: value ?? this.value);
  }

  /// Returns the type of the metadata.
  @override
  TransactionMetadataType get type => TransactionMetadataType.metadataInt;

  /// Converts the metadata to JSON.
  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: value.toString(),
      'serialization_config': serializationConfig.toJson()
    };
  }

  @override
  Object toJsonSchema(
      {MetadataSchemaConfig config = const MetadataSchemaConfig(
          jsonSchema: MetadataJsonSchema.noConversions)}) {
    if (config.jsonSchema == MetadataJsonSchema.detailedSchema) {
      return {'int': config.useIntInsteadBigInt ? value.toInt() : value};
    }
    if (!config.useIntInsteadBigInt) return value;
    return value.toInt();
  }

  /// Converts the metadata to CBOR.
  @override
  CborObject toCbor({bool sort = false}) {
    if (value.isNegative) {
      return CborSignedValue.i64(value);
    }
    return CborUnsignedValue.u64(value);
  }

  @override
  int compareTo(TransactionMetadata other) {
    if (other is! TransactionMetadata<BigInt>) return super.compareTo(other);
    return value.compareTo(other.value);
  }
}
