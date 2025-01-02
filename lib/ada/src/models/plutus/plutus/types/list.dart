import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/plutus/plutus/core/plutus.dart';

/// Represents a Plutus list.
class PlutusList extends PlutusData {
  /// The list value.
  final List<PlutusData> value;

  /// Indicates if the list has definite encoding.
  final bool? definiteEncoding;

  /// Creates a [PlutusList] instance.
  PlutusList(this.value, {this.definiteEncoding});

  /// Deserializes a [PlutusList] instance from CBOR.
  factory PlutusList.deserialize(CborListValue cbor) {
    return PlutusList(cbor.value.map((e) => PlutusData.deserialize(e)).toList(),
        definiteEncoding: cbor.isFixedLength);
  }
  factory PlutusList.fromJson(Map<String, dynamic> json) {
    return PlutusList(
        (json['list'] as List).map((e) => PlutusData.fromJson(e)).toList(),
        definiteEncoding: json['definite_encoding']);
  }
  @override
  CborObject toCbor() {
    final bool definite = definiteEncoding ?? value.isEmpty;
    if (!definite) {
      return CborListValue.dynamicLength(value.map((e) => e.toCbor()).toList());
    }

    return CborListValue.fixedLength(value.map((e) => e.toCbor()).toList());
  }

  @override
  PlutusDataType get type => PlutusDataType.list;

  @override
  Map<String, List> toJson() {
    return {'list': value.map((e) => e.toJson()).toList()};
  }

  @override
  int compareTo(PlutusData other) {
    if (other is! PlutusList) {
      return super.compareTo(other);
    }
    final lenComparison = value.length.compareTo(other.value.length);
    if (lenComparison == 0) {
      for (int i = 0; i < value.length; i++) {
        final valueCompare =
            value.elementAt(i).compareTo(other.value.elementAt(i));
        if (valueCompare != 0) return valueCompare;
      }
    }
    return lenComparison;
  }

  PlutusList copyWith({List<PlutusData>? value, bool? definiteEncoding}) {
    return PlutusList(value ?? this.value,
        definiteEncoding: definiteEncoding ?? this.definiteEncoding);
  }

  @override
  Object toJsonSchema(
      {PlutusSchemaConfig config = const PlutusSchemaConfig(
          jsonSchema: PlutusJsonSchema.basicConversions)}) {
    if (config.jsonSchema == PlutusJsonSchema.detailedSchema) {
      return {
        'list': value.map((e) => e.toJsonSchema(config: config)).toList()
      };
    }
    return value.map((e) => e.toJsonSchema(config: config)).toList();
  }
}
