import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus.dart';

/// Represents a Plutus integer.
class PlutusInteger extends PlutusData {
  /// The integer value.
  final BigInt value;

  /// Creates a [PlutusInteger] instance.
  const PlutusInteger(this.value);

  /// Deserializes a [PlutusInteger] instance from CBOR.
  factory PlutusInteger.deserialize(CborObject cbor) {
    return PlutusInteger(cbor.getInteger());
  }
  factory PlutusInteger.fromJson(Map<String, dynamic> json) {
    return PlutusInteger(BigintUtils.parse(json["int"]));
  }

  @override
  CborObject toCbor() {
    return CborSignedValue.i64(value);
  }

  @override
  PlutusDataType get type => PlutusDataType.integer;

  @override
  toJson() {
    return {"int": value.toString()};
  }

  @override
  int compareTo(PlutusData other) {
    if (other is! PlutusInteger) return super.compareTo(other);
    return value.compareTo(other.value);
  }

  @override
  toJsonSchema(
      {PlutusSchemaConfig config = const PlutusSchemaConfig(
          jsonSchema: PlutusJsonSchema.basicConversions)}) {
    if (config.jsonSchema == PlutusJsonSchema.detailedSchema) {
      return {"int": config.useIntInsteadBigInt ? value.toInt() : value};
    }

    return config.useIntInsteadBigInt ? value.toInt() : value;
  }
}
