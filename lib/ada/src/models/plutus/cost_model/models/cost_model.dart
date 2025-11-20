import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:blockchain_utils/cbor/extention/extenton.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/plutus/utils/utils.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/models/language.dart';

import 'cost.dart';

/// Represents cost models for different languages.
class Costmdls with InternalCborSerialization {
  /// The cost models mapping.
  final Map<Language, CostModel> value;

  /// Constructs a [Costmdls] instance.
  Costmdls(Map<Language, CostModel> value)
      : value = Map<Language, CostModel>.unmodifiable(value);

  /// Constructs a [Costmdls] instance from CBOR bytes.
  factory Costmdls.fromCborBytes(List<int> cborBytes) {
    return Costmdls.deserialize(CborObject.fromCbor(cborBytes).as());
  }

  /// Deserializes a [Costmdls] instance from CBOR map value.
  factory Costmdls.deserialize(CborMapValue cbor) {
    final map = cbor.valueAsMap<CborObject, CborObject>();
    return Costmdls({
      for (final entry in map.entries)
        Language.deserialize(entry.key): CostModel.deserialize(entry.value)
    });
  }
  factory Costmdls.fromViewCborBytes(List<int> cborBytes) {
    final cbor = CborObject.fromCbor(cborBytes).as<CborMapValue>();
    final map = cbor.valueAsMap<CborObject, CborObject>();
    return Costmdls({
      for (final entry in map.entries)
        Language.deserialize(
            CborObject.fromCbor(entry.key.as<CborBytesValue>().value)
                .cast<CborNumeric>()): CostModel.deserialize(
            CborObject.fromCbor(entry.value.as<CborBytesValue>().value)
                .cast<CborListValue>())
    });
  }
  factory Costmdls.fromJson(Map<String, dynamic> json) {
    return Costmdls({
      for (final entry in json.entries)
        Language.fromName(entry.key): CostModel.fromJson(entry.value)
    });
  }

  @override
  CborObject toCbor({bool sort = false}) {
    final Map<CborObject, CborObject> cborValues = {};
    if (sort) {
      final sortedKeys = value.keys.toList()
        ..sort(
          (a, b) {
            final lenOrder = PlutusDataUtils.costModelKeyLength(a)
                .compareTo(PlutusDataUtils.costModelKeyLength(b));
            return lenOrder == 0 ? a.value.compareTo(b.value) : lenOrder;
          },
        );

      for (final entry in sortedKeys) {
        cborValues.addAll({entry.toCbor(): value[entry]!.toCbor()});
      }
      return CborMapValue.definite(cborValues);
    }

    for (final entry in value.entries) {
      cborValues.addAll({entry.key.toCbor(): entry.value.toCbor()});
    }
    return CborMapValue.definite(cborValues);
  }

  /// Encodes the language view into a CBOR map value.
  CborObject languageViewEncoding() {
    final sortedKeys = value.keys.toList()
      ..sort(
        (a, b) {
          final lenOrder = PlutusDataUtils.costModelKeyLength(a)
              .compareTo(PlutusDataUtils.costModelKeyLength(b));
          return lenOrder == 0 ? a.value.compareTo(b.value) : lenOrder;
        },
      );
    final Map<CborObject, CborObject> cborValues = {};
    // bool isV1 = key == Language.plutusV1;
    for (final key in sortedKeys) {
      bool isV1 = key == Language.plutusV1;
      final config = isV1
          ? CostModelSerializationConfig(
              listEncoding: CborIterableEncodingType.inDefinite)
          : CostModelSerializationConfig(
              listEncoding: CborIterableEncodingType.definite);

      final modelEncoding = value[key]!.toCbor(config: config);
      final keyEncoding = key.toCbor();

      cborValues.addAll({
        isV1 ? CborBytesValue(keyEncoding.encode()) : keyEncoding:
            isV1 ? CborBytesValue(modelEncoding.encode()) : modelEncoding
      });
    }
    return CborMapValue.definite(cborValues);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      for (final entry in value.entries)
        entry.key.toJson(): entry.value.toJson()
    };
  }

  @override
  List<int> serialize({bool sort = false}) {
    return toCbor(sort: sort).encode();
  }

  @override
  String serializeHex({bool sort = false}) {
    return BytesUtils.toHexString(serialize(sort: sort));
  }
}
