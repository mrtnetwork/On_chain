import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_data/models/config.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_data/models/plutus_data.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_data/models/plutus_data_type.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_data/models/plutus_json_schame.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class PlutusListSerializationConfig {
  final CborIterableEncodingType encoding;
  final List<int>? tags;
  const PlutusListSerializationConfig(
      {this.encoding = CborIterableEncodingType.definite, this.tags});
  factory PlutusListSerializationConfig.fromJson(Map<String, dynamic> json) {
    return PlutusListSerializationConfig(
        tags: (json["tags"] as List?)?.cast(),
        encoding: json["encoding"] == null
            ? CborIterableEncodingType.definite
            : CborIterableEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name, "tags": tags};
  }
}

/// Represents a Plutus list.
class PlutusList extends PlutusData {
  /// The list value.
  final List<PlutusData> value;

  /// Indicates if the list has definite encoding.
  final PlutusListSerializationConfig serializationConfig;

  /// Creates a [PlutusList] instance.
  PlutusList(this.value, {PlutusListSerializationConfig? serializationConfig})
      : serializationConfig = serializationConfig ??
            PlutusListSerializationConfig(
                encoding: value.isEmpty
                    ? CborIterableEncodingType.definite
                    : CborIterableEncodingType.inDefinite);

  /// Deserializes a [PlutusList] instance from CBOR.
  factory PlutusList.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final tag = cbor.as<CborTagValue>("PlutusList");
      final data = tag.valueAs<CborIterableObject>("PlutusList");
      return PlutusList(
          data
              .valueAsListOf<CborObject>('PlutusList')
              .map((e) => PlutusData.deserialize(e))
              .toList(),
          serializationConfig: PlutusListSerializationConfig(
              tags: tag.tags, encoding: data.encoding));
    }
    final list = cbor.as<CborIterableObject>("PlutusList");
    return PlutusList(
        list
            .valueAsListOf<CborObject>('PlutusList')
            .map((e) => PlutusData.deserialize(e))
            .toList(),
        serializationConfig:
            PlutusListSerializationConfig(encoding: list.encoding));
  }
  factory PlutusList.fromJson(Map<String, dynamic> json,
      {PlutusListSerializationConfig serializationConfig =
          const PlutusListSerializationConfig()}) {
    return PlutusList(
        (json[PlutusDataType.list.name] as List)
            .map((e) => PlutusData.fromJson(e))
            .toList(),
        serializationConfig: PlutusListSerializationConfig.fromJson(
            json['serialization_config'] ?? {}));
  }
  @override
  CborObject toCbor({bool sort = false}) {
    final obj = () {
      switch (serializationConfig.encoding) {
        case CborIterableEncodingType.inDefinite:
          return CborListValue.inDefinite(
              value.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.definite:
          return CborListValue.definite(value.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.set:
          return CborSetValue(value.map((e) => e.toCbor()).toList());
      }
    }() as CborObject;
    final tags = serializationConfig.tags;
    if (tags == null) {
      return obj;
    }
    return CborTagValue(obj, tags);
  }

  @override
  PlutusDataType get type => PlutusDataType.list;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: value.map((e) => e.toJson()).toList(),
      'serialization_config': serializationConfig.toJson()
    };
  }

  @override
  int compareTo(PlutusData other) {
    if (other is! PlutusList) {
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

  PlutusList copyWith(
      {List<PlutusData>? value,
      PlutusListSerializationConfig? serializationConfig}) {
    return PlutusList(value ?? this.value,
        serializationConfig: serializationConfig ?? this.serializationConfig);
  }

  @override
  Object toJsonSchema(
      {PlutusSchemaConfig config = const PlutusSchemaConfig(
          jsonSchema: PlutusJsonSchema.basicConversions)}) {
    if (config.jsonSchema == PlutusJsonSchema.detailedSchema) {
      return {
        'list': value.map((e) => e.toJsonSchema(config: config)).toList()
      };
    }
    return value.map((e) => e.toJsonSchema(config: config)).toList();
  }
}
