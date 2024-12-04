import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus.dart';
import 'package:on_chain/ada/src/models/plutus/utils/utils.dart';

/// Represents Plutus bytes data.
class PlutusBytes extends PlutusData {
  final List<int> value;

  /// Constructs a [PlutusBytes] instance with the given value.
  PlutusBytes({required List<int> value})
      : value = BytesUtils.toBytes(value, unmodifiable: true);

  /// Deserializes a [PlutusBytes] instance from CBOR.
  factory PlutusBytes.deserialize(CborObject cbor) {
    return PlutusBytes(value: cbor.getValue<List<int>>());
  }
  factory PlutusBytes.fromJson(Map<String, dynamic> json) {
    return PlutusBytes(value: BytesUtils.fromHexString(json["bytes"]));
  }

  @override
  CborObject toCbor() {
    if (value.length > PlutusDataUtils.chunkSize) {
      final List<List<int>> chunks = [];
      for (var i = 0; i < value.length; i += PlutusDataUtils.chunkSize) {
        chunks.add(value.sublist(
            i,
            i + PlutusDataUtils.chunkSize > value.length
                ? value.length
                : i + PlutusDataUtils.chunkSize));
      }
      return CborDynamicBytesValue(chunks);
    }
    return CborBytesValue(value);
  }

  @override
  PlutusDataType get type => PlutusDataType.bytes;

  @override
  Map<String, dynamic> toJson() {
    return {"bytes": BytesUtils.toHexString(value)};
  }

  @override
  int compareTo(PlutusData other) {
    if (other is! PlutusBytes) return super.compareTo(other);
    final lenComparison = value.length.compareTo(other.value.length);
    if (lenComparison == 0) {
      return BytesUtils.compareBytes(value, other.value);
    }
    return lenComparison;
  }

  @override
  toJsonSchema(
      {PlutusSchemaConfig config = const PlutusSchemaConfig(
          jsonSchema: PlutusJsonSchema.basicConversions)}) {
    if (config.jsonSchema == PlutusJsonSchema.basicConversions) {
      try {
        return StringUtils.decode(value);
      } catch (e) {
        return BytesUtils.toHexString(value, prefix: "0x");
      }
    }
    return {"bytes": BytesUtils.toHexString(value)};
  }
}
