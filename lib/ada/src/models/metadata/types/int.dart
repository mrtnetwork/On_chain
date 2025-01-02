import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/metadata/core/meta_data.dart';

/// Represents transaction metadata containing an integer value.
class TransactionMetadataInt extends TransactionMetadata<BigInt> {
  /// The integer value of the metadata.
  @override
  final BigInt value;

  /// Constructs a TransactionMetadataInt object.
  const TransactionMetadataInt({required this.value});

  /// Deserializes a TransactionMetadataInt object from CBOR.
  factory TransactionMetadataInt.deserialize(CborObject cbor) {
    return TransactionMetadataInt(value: cbor.getInteger());
  }
  factory TransactionMetadataInt.fromJson(Map<String, dynamic> json) {
    return TransactionMetadataInt(value: BigintUtils.parse(json['int']));
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
    return {'int': value.toString()};
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
  CborObject toCbor() {
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
