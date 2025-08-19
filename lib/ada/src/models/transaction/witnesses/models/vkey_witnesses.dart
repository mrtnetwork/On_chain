import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/models/vkey_witness.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class VkeyWitnessesSerializationConfig {
  final CborIterableEncodingType encoding;
  final List<int>? tags;
  const VkeyWitnessesSerializationConfig(
      {this.tags, this.encoding = CborIterableEncodingType.set});

  factory VkeyWitnessesSerializationConfig.fromJson(Map<String, dynamic> json) {
    return VkeyWitnessesSerializationConfig(
        tags: (json["tags"] as List?)?.cast(),
        encoding: json["encoding"] == null
            ? CborIterableEncodingType.set
            : CborIterableEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name, "tags": tags};
  }
}

/// Vkeywitness
class VkeyWitnesses with ADASerialization {
  final List<Vkeywitness> witnesses;
  final VkeyWitnessesSerializationConfig serializationConfig;
  VkeyWitnesses(List<Vkeywitness> witnesses,
      {this.serializationConfig = const VkeyWitnessesSerializationConfig()})
      : witnesses = witnesses.immutable;
  factory VkeyWitnesses.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final tag = cbor.as<CborTagValue>("witnesses");
      final list = tag.valueAs<CborIterableObject>('witnesses');
      return VkeyWitnesses(
          list
              .valueAsListOf<CborListValue>("witnesses")
              .map((e) => Vkeywitness.deserialize(e))
              .toList(),
          serializationConfig: VkeyWitnessesSerializationConfig(
              encoding: list.encoding, tags: tag.tags));
    }
    final list = cbor.as<CborIterableObject>('witnesses');
    return VkeyWitnesses(
        list
            .valueAsListOf<CborListValue>("witnesses")
            .map((e) => Vkeywitness.deserialize(e))
            .toList(),
        serializationConfig:
            VkeyWitnessesSerializationConfig(encoding: list.encoding));
  }
  factory VkeyWitnesses.fromJson(Map<String, dynamic> json) {
    return VkeyWitnesses(
        (json["witnesses"] as List)
            .map((e) => Vkeywitness.fromJson(e))
            .toList(),
        serializationConfig: VkeyWitnessesSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    final obj = () {
      switch (serializationConfig.encoding) {
        case CborIterableEncodingType.inDefinite:
          return CborListValue.inDefinite(
              witnesses.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.definite:
          return CborListValue.definite(
              witnesses.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.set:
          return CborSetValue(witnesses.map((e) => e.toCbor()));
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
      "witnesses": witnesses.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}
