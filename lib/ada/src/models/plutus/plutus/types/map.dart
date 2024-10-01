import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/integer.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/types/bytes.dart';

/// Represents a Plutus map.
class PlutusMap extends PlutusData {
  /// The map value.
  final Map<PlutusData, PlutusData> value;

  /// Creates a [PlutusMap] instance.
  PlutusMap(Map<PlutusData, PlutusData> value)
      : value = Map<PlutusData, PlutusData>.unmodifiable(value);

  /// Deserializes a [PlutusMap] instance from CBOR.
  factory PlutusMap.deserialize(CborMapValue cbor) {
    return PlutusMap({
      for (final i in cbor.value.entries)
        PlutusData.deserialize(i.key): PlutusData.deserialize(i.value)
    });
  }
  factory PlutusMap.fromJson(Map<String, dynamic> json) {
    return PlutusMap({
      for (final i in (json["map"] as Map).entries)
        PlutusData.fromJson(i.key): PlutusData.fromJson(i.value)
    });
  }

  @override
  CborObject toCbor() {
    final keys = value.keys.toList()..sort((a, b) => a.compareTo(b));
    return CborMapValue.fixedLength(
        {for (final i in keys) i.toCbor(): value[i]!.toCbor()});
  }

  @override
  PlutusDataType get type => PlutusDataType.map;

  @override
  toJson() {
    return {
      "map": {for (final i in value.entries) i.key.toJson(): i.value.toJson()}
    };
  }

  @override
  toJsonSchema(
      {PlutusSchemaConfig config = const PlutusSchemaConfig(
          jsonSchema: PlutusJsonSchema.basicConversions)}) {
    if (config.jsonSchema == PlutusJsonSchema.basicConversions) {
      final Map<String, dynamic> json = {};
      for (final i in value.entries) {
        if (i.key is! PlutusInteger && i.key is! PlutusBytes) {
          throw ADAPluginException("plutus object are not allowed as key.",
              details: {"Key": i.key, "Type": i.key.runtimeType});
        }
        final key = i.key.toJsonSchema(config: config).toString();
        final value = i.value.toJsonSchema(config: config);
        json.addAll({key: value});
      }
      return json;
    } else {
      return {
        "map": value.entries.map((entry) {
          final k = entry.key.toJsonSchema(config: config);
          final v = entry.value.toJsonSchema(config: config);
          return {'k': k, 'v': v};
        }).toList()
      };
    }
  }

  @override
  int compareTo(PlutusData other) {
    if (other is! PlutusMap) {
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
}
