import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

/// Represents different types of Plutus data.
class PlutusDataType with InternalCborSerialization {
  /// The numeric value representing the data type.
  final int value;

  /// The name of the data type.
  final String name;

  /// Constructs a [PlutusDataType].
  const PlutusDataType._(this.value, this.name);

  /// Plutus data type representing constructed Plutus data.
  static const PlutusDataType constrPlutusData =
      PlutusDataType._(0, 'ConstrPlutusData');

  /// Plutus data type representing a map.
  static const PlutusDataType map = PlutusDataType._(1, 'Map');

  /// Plutus data type representing a list.
  static const PlutusDataType list = PlutusDataType._(2, 'List');

  /// Plutus data type representing an integer.
  static const PlutusDataType integer = PlutusDataType._(3, 'Int');

  /// Plutus data type representing bytes.
  static const PlutusDataType bytes = PlutusDataType._(4, 'Bytes');

  /// A list of all Plutus data types.
  static const List<PlutusDataType> values = [
    constrPlutusData,
    map,
    list,
    integer,
    bytes
  ];

  /// Constructs a [PlutusDataType] from its serialized form.
  factory PlutusDataType.deserialize(CborIntValue cbor) {
    return fromValue(cbor.value);
  }

  /// Constructs a [PlutusDataType] from its numeric value.
  static PlutusDataType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No PlutusDataType found matching the specified value',
          details: {'value': value}),
    );
  }

  /// Constructs a [PlutusDataType] from its numeric name.
  static PlutusDataType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No PlutusDataType found matching the specified name',
          details: {'name': name}),
    );
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  @override
  String toJson() {
    return name;
  }

  @override
  String toString() {
    return 'PlutusDataType.$name';
  }
}
