import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/transaction/input/models/transaction_input.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class TransactionInputSerializationConfig {
  final CborIterableEncodingType encoding;
  final List<int>? tags;
  const TransactionInputSerializationConfig(
      {this.tags, this.encoding = CborIterableEncodingType.set});

  factory TransactionInputSerializationConfig.fromJson(
      Map<String, dynamic> json) {
    return TransactionInputSerializationConfig(
        tags: (json["tags"] as List?)?.cast(),
        encoding: json["encoding"] == null
            ? CborIterableEncodingType.set
            : CborIterableEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name, "tags": tags};
  }
}

class TransactionInputs with ADASerialization {
  final List<TransactionInput> inputs;
  final TransactionInputSerializationConfig serializationConfig;
  TransactionInputs(List<TransactionInput> inputs,
      {this.serializationConfig = const TransactionInputSerializationConfig()})
      : inputs = inputs.immutable;
  factory TransactionInputs.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final tag = cbor.as<CborTagValue>("inputs");
      final list = tag.valueAs<CborIterableObject>('inputs');
      return TransactionInputs(
          list
              .valueAsListOf<CborListValue>("inputs")
              .map((e) => TransactionInput.deserialize(e))
              .toList(),
          serializationConfig: TransactionInputSerializationConfig(
              encoding: list.encoding, tags: tag.tags));
    }
    final list = cbor.as<CborIterableObject>('inputs');
    return TransactionInputs(
        list
            .valueAsListOf<CborListValue>("inputs")
            .map((e) => TransactionInput.deserialize(e))
            .toList(),
        serializationConfig:
            TransactionInputSerializationConfig(encoding: list.encoding));
  }
  factory TransactionInputs.fromJson(Map<String, dynamic> json) {
    return TransactionInputs(
        (json["inputs"] as List)
            .map((e) => TransactionInput.fromJson(e))
            .toList(),
        serializationConfig: TransactionInputSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }

  @override
  CborObject toCbor() {
    final obj = () {
      switch (serializationConfig.encoding) {
        case CborIterableEncodingType.inDefinite:
          return CborListValue.inDefinite(
              inputs.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.definite:
          return CborListValue.definite(inputs.map((e) => e.toCbor()).toList());
        case CborIterableEncodingType.set:
          return CborSetValue(inputs.map((e) => e.toCbor()));
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
      "inputs": inputs.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}
