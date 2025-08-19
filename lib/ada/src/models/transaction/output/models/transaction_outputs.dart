import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/ada/src/models/transaction/output/models/transaction_output.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class TransactionOutputsSerializationConfig {
  final CborIterableEncodingType encoding;
  final List<int>? tags;
  const TransactionOutputsSerializationConfig(
      {this.encoding = CborIterableEncodingType.definite, this.tags});

  factory TransactionOutputsSerializationConfig.fromJson(
      Map<String, dynamic> json) {
    return TransactionOutputsSerializationConfig(
        tags: (json["tags"] as List?)?.cast(),
        encoding: json["encoding"] == null
            ? CborIterableEncodingType.definite
            : CborIterableEncodingType.fromName(json["encoding"]));
  }
  Map<String, dynamic> toJson() {
    return {"encoding": encoding.name, "tags": tags};
  }
}

class TransactionOutputs with ADASerialization {
  final List<TransactionOutput> outputs;
  final TransactionOutputsSerializationConfig serializationConfig;
  TransactionOutputs(List<TransactionOutput> outputs,
      {this.serializationConfig =
          const TransactionOutputsSerializationConfig()})
      : outputs = outputs.immutable;
  factory TransactionOutputs.deserialize(CborObject cbor) {
    if (cbor.hasType<CborTagValue>()) {
      final tag = cbor.as<CborTagValue>("outputs");
      final list = tag.valueAs<CborIterableObject>('outputs');
      return TransactionOutputs(
          list
              .valueAsListOf<CborObject>("outputs")
              .map((e) => TransactionOutput.deserialize(e))
              .toList(),
          serializationConfig: TransactionOutputsSerializationConfig(
              encoding: list.encoding, tags: tag.tags));
    }
    final list = cbor.as<CborIterableObject>('outputs');
    return TransactionOutputs(
        list
            .valueAsListOf<CborObject>("outputs")
            .map((e) => TransactionOutput.deserialize(e))
            .toList(),
        serializationConfig:
            TransactionOutputsSerializationConfig(encoding: list.encoding));
  }
  factory TransactionOutputs.fromJson(Map<String, dynamic> json) {
    return TransactionOutputs(
        (json["outputs"] as List)
            .map((e) => TransactionOutput.fromJson(e))
            .toList(),
        serializationConfig: TransactionOutputsSerializationConfig.fromJson(
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
      "outputs": outputs.map((e) => e.toJson()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}
