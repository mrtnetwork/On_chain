import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Represents the type of a stake credential.
class StakeCredType with ADASerialization {
  /// The name of the stake credential type.
  final String name;

  /// The value of the stake credential type.
  final int value;

  /// Constructs a [StakeCredType] with the specified [name] and [value].
  const StakeCredType._({required this.name, required this.value});

  /// Represents a key stake credential type.
  static const StakeCredType key = StakeCredType._(name: "key", value: 0);

  /// Represents a script stake credential type.
  static const StakeCredType script = StakeCredType._(name: "script", value: 1);

  /// A list containing all defined [StakeCredType] values.
  static const List<StakeCredType> values = [key, script];

  /// Deserializes a [StakeCredType] from a CBOR integer value [cbor].
  factory StakeCredType.deserialize(CborIntValue cbor) {
    return fromValue(cbor.value);
  }

  /// Returns the [StakeCredType] corresponding to the specified [value].
  static StakeCredType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No StakeCredType found matching the specified value",
          details: {"value": value}),
    );
  }

  /// Returns the [StakeCredType] corresponding to the specified [name].
  static StakeCredType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw MessageException(
          "No StakeCredType found matching the specified name",
          details: {"name": name}),
    );
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  @override
  String toString() {
    return "StakeCredType.$name";
  }

  @override
  String toJson() {
    return name;
  }
}
