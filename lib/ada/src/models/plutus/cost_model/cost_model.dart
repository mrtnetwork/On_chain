import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/plutus/utils/utils.dart';
import 'package:on_chain/ada/src/models/plutus/plutus_script/language/language.dart';

import 'cost.dart';

/// Represents cost models for different languages.
class Costmdls with ADASerialization {
  /// The cost models mapping.
  final Map<Language, CostModel> value;

  /// Constructs a [Costmdls] instance.
  Costmdls(Map<Language, CostModel> value)
      : value = Map<Language, CostModel>.unmodifiable(value);

  /// Constructs a [Costmdls] instance from CBOR bytes.
  factory Costmdls.fromCborBytes(List<int> cborBytes) {
    return Costmdls.deserialize(CborObject.fromCbor(cborBytes).cast());
  }

  /// Deserializes a [Costmdls] instance from CBOR map value.
  factory Costmdls.deserialize(CborMapValue cbor) {
    return Costmdls({
      for (final entry
          in cbor.cast<CborMapValue<CborObject, CborObject>>().value.entries)
        Language.deserialize(entry.key): CostModel.deserialize(entry.value)
    });
  }
  factory Costmdls.fromJson(Map<String, dynamic> json) {
    return Costmdls({
      for (final entry in json.entries)
        Language.fromName(entry.key): CostModel.fromJson(entry.value)
    });
  }

  @override
  CborObject toCbor() {
    final Map<CborObject, CborObject> cborValues = {};
    for (final entry in value.entries) {
      cborValues.addAll({entry.key.toCbor(false): entry.value.toCbor(false)});
    }
    return CborMapValue.fixedLength(cborValues);
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
    for (final key in sortedKeys) {
      cborValues.addAll({
        key.toCbor(key == Language.plutusV1):
            value[key]!.toCbor(key == Language.plutusV1)
      });
    }
    return CborMapValue.fixedLength(cborValues);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      for (final entry in value.entries)
        entry.key.toJson(): entry.value.toJson()
    };
  }
}
