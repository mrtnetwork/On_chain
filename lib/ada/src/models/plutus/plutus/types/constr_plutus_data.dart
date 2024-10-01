import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus.dart';
import 'package:on_chain/ada/src/models/plutus/utils/utils.dart';
import 'list.dart';

/// Represents constructed Plutus data.
class ConstrPlutusData extends PlutusData {
  const ConstrPlutusData({required this.alternative, required this.data});

  /// The alternative value.
  final BigInt alternative;

  /// The data associated with the constructor.
  final PlutusList data;

  /// Deserializes a [ConstrPlutusData] instance from CBOR.
  factory ConstrPlutusData.deserialize(CborTagValue cbor) {
    if (BytesUtils.bytesEqual(cbor.tags, [PlutusDataUtils.generalFormTag])) {
      final CborListValue data = cbor.getValue<CborListValue>();
      return ConstrPlutusData(
          alternative: data.getIndex<CborObject>(0).getInteger(),
          data: PlutusList.deserialize(data.getIndex(1)));
    }
    final BigInt? alternative =
        PlutusDataUtils.cborTagToAlternative(cbor.tags.first);
    if (alternative == null) {
      throw const ADAPluginException("Invalid ConstrPlutusData tag.");
    }
    return ConstrPlutusData(
        alternative: alternative,
        data: PlutusList.deserialize(cbor.getValue()));
  }

  factory ConstrPlutusData.fromJson(Map<String, dynamic> json) {
    final correctJson = json["constr_plutus_data"];
    return ConstrPlutusData(
        alternative: BigintUtils.parse(correctJson["constructor"]),
        data: PlutusList.fromJson(correctJson["fields"]));
  }

  @override
  PlutusDataType get type => PlutusDataType.constrPlutusData;

  @override
  CborObject toCbor() {
    final tag = PlutusDataUtils.alternativeToCborTag(alternative);
    if (tag != null) {
      return CborTagValue(data.toCbor(), [tag]);
    }
    return CborTagValue(
        CborListValue.fixedLength(
            [CborUnsignedValue.u64(alternative), data.toCbor()]),
        [PlutusDataUtils.generalFormTag]);
  }

  @override
  toJson() {
    return {
      "constr_plutus_data": {
        "constructor": alternative.toString(),
        "fields": data.toJson()
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
  toJsonSchema(
      {PlutusSchemaConfig config = const PlutusSchemaConfig(
          jsonSchema: PlutusJsonSchema.basicConversions)}) {
    return {
      "constructor":
          config.useIntInsteadBigInt ? alternative.toInt() : alternative,
      "fields": data.value.map((e) => e.toJsonSchema(config: config)).toList()
    };
  }
}
