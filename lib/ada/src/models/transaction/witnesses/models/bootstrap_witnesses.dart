import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'bootstrap_witness.dart';

class BootstrapWitnessesSerializationConfig {
  final CborIterableEncodingType encoding;
  final List<int>? tags;
  const BootstrapWitnessesSerializationConfig(
      {this.tags, this.encoding = CborIterableEncodingType.set});

  factory BootstrapWitnessesSerializationConfig.fromJson(
      Map<String, dynamic> json) {
    return BootstrapWitnessesSerializationConfig(
        tags: (json["tags"] as List?)?.cast(),
        encoding: json["encoding"] == null
            ? CborIterableEncodingType.set
            : CborIterableEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name, "tags": tags};
  }
}

/// BootstrapWitness
class BootstrapWitnesses with InternalCborSerialization {
  final List<BootstrapWitness> witnesses;
  final BootstrapWitnessesSerializationConfig serializationConfig;
  BootstrapWitnesses(List<BootstrapWitness> witnesses,
      {this.serializationConfig =
          const BootstrapWitnessesSerializationConfig()})
      : witnesses = witnesses.immutable;
  factory BootstrapWitnesses.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final tag = cbor.as<CborTagValue>("witnesses");
      final list = tag.valueAs<CborIterableObject>('witnesses');
      return BootstrapWitnesses(
          list
              .valueAsListOf<CborListValue>("witnesses")
              .map((e) => BootstrapWitness.deserialize(e))
              .toList(),
          serializationConfig: BootstrapWitnessesSerializationConfig(
              encoding: list.encoding, tags: tag.tags));
    }
    final list = cbor.as<CborIterableObject>('witnesses');
    return BootstrapWitnesses(
        list
            .valueAsListOf<CborListValue>("witnesses")
            .map((e) => BootstrapWitness.deserialize(e))
            .toList(),
        serializationConfig:
            BootstrapWitnessesSerializationConfig(encoding: list.encoding));
  }
  factory BootstrapWitnesses.fromJson(Map<String, dynamic> json) {
    return BootstrapWitnesses(
        (json["witnesses"] as List)
            .map((e) => BootstrapWitness.fromJson(e))
            .toList(),
        serializationConfig: BootstrapWitnessesSerializationConfig.fromJson(
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
