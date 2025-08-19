import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:blockchain_utils/cbor/extention/extenton.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'config.dart';
import 'plutus_data.dart';
import 'plutus_data_type.dart';
import 'plutus_json_schame.dart';

class PlutusIntegerSerializationConfig {
  final CborLengthEncoding encoding;
  final CborPlutusIntegerEncoding? type;
  const PlutusIntegerSerializationConfig(
      {this.encoding = CborLengthEncoding.canonical, this.type});
  factory PlutusIntegerSerializationConfig.fromJson(Map<String, dynamic> json) {
    return PlutusIntegerSerializationConfig(
        type: json["type"] == null
            ? null
            : CborPlutusIntegerEncoding.fromName(json["type"]),
        encoding: json["encoding"] == null
            ? CborLengthEncoding.canonical
            : CborLengthEncoding.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name, "type": type?.name};
  }
}

enum CborPlutusIntegerEncoding {
  int,
  bigInt;

  static CborPlutusIntegerEncoding fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () =>
            throw const CborException("Invalid plutus integer encoding type."));
  }
}

/// Represents a Plutus integer.
class PlutusInteger extends PlutusData {
  /// The integer value.
  final BigInt value;

  final PlutusIntegerSerializationConfig serializationConfig;

  /// Creates a [PlutusInteger] instance.
  const PlutusInteger(this.value,
      {this.serializationConfig = const PlutusIntegerSerializationConfig()});

  /// Deserializes a [PlutusInteger] instance from CBOR.
  factory PlutusInteger.deserialize(CborObject cbor) {
    final cborNumber = cbor.as<CborNumeric>('PlutusInteger');
    if (cborNumber.hasType<CborBigIntValue>()) {
      final big = cborNumber.cast<CborBigIntValue>();
      return PlutusInteger(
        big.toBigInt(),
        serializationConfig: PlutusIntegerSerializationConfig(
            type: CborPlutusIntegerEncoding.bigInt, encoding: big.encoding),
      );
    }
    return PlutusInteger(cborNumber.toBigInt());
  }
  factory PlutusInteger.fromJson(Map<String, dynamic> json) {
    return PlutusInteger(BigintUtils.parse(json[PlutusDataType.integer.name]),
        serializationConfig: PlutusIntegerSerializationConfig.fromJson(
            json['serialization_config'] ?? {}));
  }

  @override
  CborObject toCbor({bool sort = false}) {
    switch (serializationConfig.type) {
      case CborPlutusIntegerEncoding.int:
        return CborSafeIntValue(value);
      case CborPlutusIntegerEncoding.bigInt:
        return CborBigIntValue(value, encoding: serializationConfig.encoding);
      default:
        if (value <= maxU64) {
          return CborSafeIntValue(value);
        }
        return CborBigIntValue(value);
    }
  }

  @override
  PlutusDataType get type => PlutusDataType.integer;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: value.toString(),
      'serialization_config': serializationConfig.toJson()
    };
  }

  @override
  int compareTo(PlutusData other) {
    if (other is! PlutusInteger) return super.compareTo(other);
    return value.compareTo(other.value);
  }

  @override
  Object toJsonSchema(
      {PlutusSchemaConfig config = const PlutusSchemaConfig(
          jsonSchema: PlutusJsonSchema.basicConversions)}) {
    if (config.jsonSchema == PlutusJsonSchema.detailedSchema) {
      return {'int': config.useIntInsteadBigInt ? value.toInt() : value};
    }

    return config.useIntInsteadBigInt ? value.toInt() : value;
  }
}
