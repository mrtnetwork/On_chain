import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/plutus/utils/utils.dart';
import 'plutus_data_type.dart';
import 'config.dart';
import 'plutus_data.dart';
import 'plutus_json_schame.dart';

/// Represents Plutus bytes data.
class PlutusBytes extends PlutusData {
  // final PlutusBytesSerializationConfig serializationConfig;
  final List<int> value;

  /// Constructs a [PlutusBytes] instance with the given value.
  PlutusBytes({required List<int> value}) : value = value.asImmutableBytes;

  /// Deserializes a [PlutusBytes] instance from CBOR.
  factory PlutusBytes.deserialize(CborObject cbor) {
    if (cbor.hasType<CborDynamicBytesValue>()) {
      final dynamic = cbor.as<CborDynamicBytesValue>('PlutusBytes');
      return PlutusBytes(value: dynamic.value.expand((e) => e).toList());
    }
    final bytes = cbor.as<CborBytesValue>('PlutusBytes');
    return PlutusBytes(value: bytes.value);
  }
  factory PlutusBytes.fromJson(Map<String, dynamic> json) {
    return PlutusBytes(
        value: BytesUtils.fromHexString(json[PlutusDataType.bytes.name]));
  }

  @override
  CborObject toCbor({bool sort = false}) {
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
    return {type.name: BytesUtils.toHexString(value)};
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
  Object toJsonSchema(
      {PlutusSchemaConfig config = const PlutusSchemaConfig(
          jsonSchema: PlutusJsonSchema.basicConversions)}) {
    if (config.jsonSchema == PlutusJsonSchema.basicConversions) {
      try {
        return StringUtils.decode(value);
      } catch (e) {
        return BytesUtils.toHexString(value, prefix: '0x');
      }
    }
    return {'bytes': BytesUtils.toHexString(value)};
  }
}
