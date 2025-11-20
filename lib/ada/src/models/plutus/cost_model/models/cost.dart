import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class CostModelSerializationConfig {
  final CborIterableEncodingType listEncoding;
  const CostModelSerializationConfig(
      {this.listEncoding = CborIterableEncodingType.definite});
  factory CostModelSerializationConfig.fromJson(Map<String, dynamic> json) {
    return CostModelSerializationConfig(
        listEncoding: json["encoding"] == null
            ? CborIterableEncodingType.definite
            : CborIterableEncodingType.fromName(json["encoding"]));
  }

  Map<String, dynamic> toJson() {
    return {"encoding": listEncoding.name};
  }
}

/// Represents a cost model.
class CostModel with InternalCborSerialization {
  /// The list of values in the cost model.
  final List<BigInt> values;

  final CostModelSerializationConfig serializationConfig;

  /// Constructs a [CostModel] instance.
  CostModel(List<BigInt> values,
      {this.serializationConfig = const CostModelSerializationConfig()})
      : values = List<BigInt>.unmodifiable(values);

  /// Deserializes a [CostModel] instance from CBOR object.
  factory CostModel.deserialize(CborObject cbor) {
    final list = cbor.as<CborListValue>("CostModel");
    return CostModel(
        list
            .valueAsListOf<CborNumeric>("CostModel")
            .map((e) => e.toBigInt())
            .toList(),
        serializationConfig:
            CostModelSerializationConfig(listEncoding: list.encoding));
  }
  factory CostModel.fromJson(Map<String, dynamic> json) {
    return CostModel(
        (json["models"] as List).map((e) => BigInt.parse(e)).toList(),
        serializationConfig: CostModelSerializationConfig.fromJson(
            json["serialization_config"] ?? {}));
  }
  @override
  CborObject toCbor({CostModelSerializationConfig? config}) {
    config ??= serializationConfig;
    final obj = () {
      switch (config!.listEncoding) {
        case CborIterableEncodingType.inDefinite:
          return CborListValue<CborSignedValue>.inDefinite(
              values.map((e) => CborSignedValue.i64(e)).toList());
        case CborIterableEncodingType.definite:
          return CborListValue<CborSignedValue>.definite(
              values.map((e) => CborSignedValue.i64(e)).toList());
        case CborIterableEncodingType.set:
          return CborSetValue<CborSignedValue>(
              values.map((e) => CborSignedValue.i64(e)).toList());
      }
    }() as CborObject;
    return obj;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "models": values.map((e) => e.toString()).toList(),
      "serialization_config": serializationConfig.toJson()
    };
  }
}
