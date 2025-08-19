import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/plutus/utils/utils.dart';
import 'config.dart';
import 'list.dart';
import 'plutus_data.dart';
import 'plutus_data_type.dart';
import 'plutus_json_schame.dart';

class ConstrPlutusDataSerializationConfig {
  final List<int> tags;
  final BigInt? alternative;
  const ConstrPlutusDataSerializationConfig(
      {required this.tags, this.alternative});
  factory ConstrPlutusDataSerializationConfig.fromJson(
      Map<String, dynamic> json) {
    return ConstrPlutusDataSerializationConfig(
        tags: (json["tags"] as List).cast(),
        alternative: json["alternative"] == null
            ? null
            : BigintUtils.parse(json["alternative"]));
  }
  Map<String, dynamic> toJson() {
    return {"tags": tags, "alternative": alternative?.toString()};
  }
}

/// Represents constructed Plutus data.
class ConstrPlutusData extends PlutusData {
  const ConstrPlutusData(
      {required this.alternative,
      required this.data,
      this.serializationConfig});

  /// The alternative value.
  final BigInt alternative;

  /// The data associated with the constructor.
  final PlutusList data;

  final ConstrPlutusDataSerializationConfig? serializationConfig;

  /// Deserializes a [ConstrPlutusData] instance from CBOR.
  factory ConstrPlutusData.deserialize(CborTagValue cbor) {
    if (BytesUtils.bytesEqual(cbor.tags, [PlutusDataUtils.generalFormTag])) {
      final CborListValue data =
          cbor.valueAs<CborListValue>("ConstrPlutusData");
      final alternative = data.elementAt<CborNumeric>(0).toBigInt();
      final encode = ConstrPlutusData(
          alternative: data.elementAt<CborNumeric>(0).toBigInt(),
          data: PlutusList.deserialize(data.elementAt<CborObject>(1)),
          serializationConfig: ConstrPlutusDataSerializationConfig(
              tags: cbor.tags, alternative: alternative));
      return encode;
    }
    final BigInt? alternative =
        PlutusDataUtils.cborTagToAlternative(cbor.tags.first);
    if (alternative == null) {
      throw const ADAPluginException('Invalid ConstrPlutusData tag.');
    }
    final encode = ConstrPlutusData(
        serializationConfig:
            ConstrPlutusDataSerializationConfig(tags: cbor.tags),
        alternative: alternative,
        data: PlutusList.deserialize(cbor.valueAs("PlutusList")));
    return encode;
  }

  factory ConstrPlutusData.fromJson(Map<String, dynamic> json) {
    final correctJson = json[PlutusDataType.constrPlutusData.name];
    return ConstrPlutusData(
        alternative: BigintUtils.parse(correctJson['constructor']),
        data: PlutusList.fromJson(correctJson['fields']),
        serializationConfig: correctJson["serialization_config"] == null
            ? null
            : ConstrPlutusDataSerializationConfig.fromJson(
                correctJson['serialization_config']));
  }

  @override
  PlutusDataType get type => PlutusDataType.constrPlutusData;

  @override
  CborObject toCbor({bool sort = false}) {
    final config = serializationConfig;
    if (config != null) {
      final alternative = config.alternative;
      if (alternative != null) {
        return CborTagValue(
            CborListValue.definite(
                [CborUnsignedValue.u64(alternative), data.toCbor()]),
            config.tags);
      }
      return CborTagValue(data.toCbor(), config.tags);
    }
    final tag = PlutusDataUtils.alternativeToCborTag(alternative);
    if (tag != null) {
      return CborTagValue(data.toCbor(), [tag]);
    }
    return CborTagValue(
        CborListValue.definite(
            [CborUnsignedValue.u64(alternative), data.toCbor()]),
        [PlutusDataUtils.generalFormTag]);
  }

  @override
  Map<String, Map<String, dynamic>> toJson() {
    return {
      type.name: {
        'constructor': alternative.toString(),
        'fields': data.toJson(),
        'serialization_config': serializationConfig?.toJson()
      }
    };
  }

  @override
  int compareTo(PlutusData other) {
    if (other is! ConstrPlutusData) return super.compareTo(other);
    final compareAlternative = alternative.compareTo(other.alternative);
    if (compareAlternative != 0) return compareAlternative;
    return data.compareTo(other.data);
  }

  @override
  Map<String, Object> toJsonSchema(
      {PlutusSchemaConfig config = const PlutusSchemaConfig(
          jsonSchema: PlutusJsonSchema.basicConversions)}) {
    return {
      'constructor':
          config.useIntInsteadBigInt ? alternative.toInt() : alternative,
      'fields': data.value.map((e) => e.toJsonSchema(config: config)).toList(),
    };
  }
}
