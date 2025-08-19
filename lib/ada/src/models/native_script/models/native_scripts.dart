import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'native_script.dart';

class NativeScriptsSerializationConfig {
  final CborIterableEncodingType encoding;
  final List<int>? tags;
  const NativeScriptsSerializationConfig(
      {this.tags, this.encoding = CborIterableEncodingType.set});

  factory NativeScriptsSerializationConfig.fromJson(Map<String, dynamic> json) {
    return NativeScriptsSerializationConfig(
        tags: (json["tags"] as List?)?.cast(),
        encoding: json["encoding"] == null
            ? CborIterableEncodingType.set
            : CborIterableEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name, "tags": tags};
  }
}

class NativeScripts with ADASerialization {
  final List<NativeScript> scripts;
  final NativeScriptsSerializationConfig serializationConfig;
  NativeScripts(List<NativeScript> scripts,
      {this.serializationConfig = const NativeScriptsSerializationConfig()})
      : scripts = scripts.immutable;
  factory NativeScripts.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final tag = cbor.as<CborTagValue>("native_scripts");
      final list = tag.valueAs<CborIterableObject>('native_scripts');
      return NativeScripts(
          list
              .valueAsListOf<CborListValue>("native_scripts")
              .map((e) => NativeScript.deserialize(e))
              .toList(),
          serializationConfig: NativeScriptsSerializationConfig(
              encoding: list.encoding, tags: tag.tags));
    }
    final list = cbor.as<CborIterableObject>('native_scripts');
    return NativeScripts(
        list
            .valueAsListOf<CborListValue>("native_scripts")
            .map((e) => NativeScript.deserialize(e))
            .toList(),
        serializationConfig:
            NativeScriptsSerializationConfig(encoding: list.encoding));
  }
  factory NativeScripts.fromJson(Map<String, dynamic> json) {
    return NativeScripts(
        (json["native_scripts"] as List)
            .map((e) => NativeScript.fromJson(e))
            .toList(),
        serializationConfig: NativeScriptsSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    final obj = () {
      switch (serializationConfig.encoding) {
        case CborIterableEncodingType.inDefinite:
          return CborListValue.inDefinite(
              scripts.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.definite:
          return CborListValue.definite(
              scripts.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.set:
          return CborSetValue(scripts.map((e) => e.toCbor()));
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
      "native_scripts": scripts.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}
