import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class PlutusScriptsSerializationConfig {
  final CborIterableEncodingType encoding;
  final List<int>? tags;
  const PlutusScriptsSerializationConfig(
      {this.tags, this.encoding = CborIterableEncodingType.definite});

  factory PlutusScriptsSerializationConfig.fromJson(Map<String, dynamic> json) {
    return PlutusScriptsSerializationConfig(
        tags: (json["tags"] as List?)?.cast(),
        encoding: json["encoding"] == null
            ? CborIterableEncodingType.set
            : CborIterableEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name, "tags": tags};
  }
}

class PlutusScripts with InternalCborSerialization {
  final List<List<int>> scripts;
  final PlutusScriptsSerializationConfig serializationConfig;
  PlutusScripts(List<List<int>> scripts,
      {this.serializationConfig = const PlutusScriptsSerializationConfig()})
      : scripts = scripts.immutable;
  factory PlutusScripts.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final tag = cbor.as<CborTagValue>("scripts");
      final list = tag.valueAs<CborIterableObject>('scripts');
      return PlutusScripts(
          list
              .valueAsListOf<CborBytesValue>("scripts")
              .map((e) => e.value)
              .toList(),
          serializationConfig: PlutusScriptsSerializationConfig(
              encoding: list.encoding, tags: tag.tags));
    }
    final list = cbor.as<CborIterableObject>('scripts');
    return PlutusScripts(
        list
            .valueAsListOf<CborBytesValue>("scripts")
            .map((e) => e.value)
            .toList(),
        serializationConfig:
            PlutusScriptsSerializationConfig(encoding: list.encoding));
  }
  factory PlutusScripts.fromJson(Map<String, dynamic> json) {
    return PlutusScripts(
        (json["scripts"] as List)
            .map((e) => BytesUtils.fromHexString(e))
            .toList(),
        serializationConfig: PlutusScriptsSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    final obj = () {
      switch (serializationConfig.encoding) {
        case CborIterableEncodingType.inDefinite:
          return CborListValue.inDefinite(
              scripts.map((e) => CborBytesValue(e)).toList());
        case CborIterableEncodingType.definite:
          return CborListValue.definite(
              scripts.map((e) => CborBytesValue(e)).toList());
        case CborIterableEncodingType.set:
          return CborSetValue(scripts.map((e) => CborBytesValue(e)));
      }
    }() as CborObject;
    final tags = serializationConfig.tags;
    if (tags != null) {
      return CborTagValue(obj, tags);
    }
    return obj;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "scripts": scripts.map((e) => BytesUtils.toHexString(e)).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}
