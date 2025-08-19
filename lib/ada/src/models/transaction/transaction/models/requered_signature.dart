import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class RequiredSignersSerializationConfig {
  final CborIterableEncodingType encoding;
  final List<int>? tags;
  const RequiredSignersSerializationConfig(
      {this.encoding = CborIterableEncodingType.set, this.tags});

  factory RequiredSignersSerializationConfig.fromJson(
      Map<String, dynamic> json) {
    return RequiredSignersSerializationConfig(
        tags: (json["tags"] as List?)?.cast(),
        encoding: json["encoding"] == null
            ? CborIterableEncodingType.set
            : CborIterableEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name, "tags": tags};
  }
}

class RequiredSigners with ADASerialization {
  final List<Ed25519KeyHash> outputs;
  final RequiredSignersSerializationConfig serializationConfig;
  RequiredSigners(List<Ed25519KeyHash> outputs,
      {this.serializationConfig = const RequiredSignersSerializationConfig()})
      : outputs = outputs.immutable;
  factory RequiredSigners.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final tag = cbor.as<CborTagValue>("required signers");
      final list = tag.valueAs<CborIterableObject>('required signers');
      return RequiredSigners(
          list
              .valueAsListOf<CborBytesValue>("required signers")
              .map((e) => Ed25519KeyHash.deserialize(e))
              .toList(),
          serializationConfig: RequiredSignersSerializationConfig(
              encoding: list.encoding, tags: tag.tags));
    }
    final list = cbor.as<CborIterableObject>('required signers');
    return RequiredSigners(
        list
            .valueAsListOf<CborBytesValue>("required signers")
            .map((e) => Ed25519KeyHash.deserialize(e))
            .toList(),
        serializationConfig:
            RequiredSignersSerializationConfig(encoding: list.encoding));
  }
  factory RequiredSigners.fromJson(Map<String, dynamic> json) {
    return RequiredSigners(
        (json["required_signers"] as List)
            .map((e) => Ed25519KeyHash.fromHex(e))
            .toList(),
        serializationConfig: RequiredSignersSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    final obj = () {
      switch (serializationConfig.encoding) {
        case CborIterableEncodingType.inDefinite:
          return CborListValue.inDefinite(
              outputs.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.definite:
          return CborListValue.definite(
              outputs.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.set:
          return CborSetValue(outputs.map((e) => e.toCbor()));
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
      "required_signers": outputs.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}
