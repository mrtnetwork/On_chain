import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

/// Represents a pot for Move instance reward.
class MIRPot with InternalCborSerialization {
  /// The name of the pot.
  final String name;

  /// The value associated with the pot.
  final int value;

  /// Constructs a MIRPot object with the specified name and value.
  const MIRPot._(this.name, this.value);

  /// Represents the reserves pot for MIR.
  static const MIRPot reserves = MIRPot._('reserves', 0);

  /// Represents the treasury pot for MIR.
  static const MIRPot treasury = MIRPot._('treasury', 1);

  /// A list containing all possible MIRPot values.
  static const List<MIRPot> values = [reserves, treasury];

  /// Deserializes a MIRPot object from its CBOR representation.
  factory MIRPot.deserialize(CborIntValue cbor) {
    return fromValue(cbor.value);
  }

  /// Retrieves a MIRPot object based on its value.
  static MIRPot fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No MIRPot found matching the specified value',
          details: {'value': value}),
    );
  }

  /// Retrieves a MIRPot object based on its name.
  static MIRPot fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No MIRPot found matching the specified name',
          details: {'name': name}),
    );
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  @override
  String toString() {
    return 'MIRPot.$name';
  }

  @override
  String toJson() {
    return name;
  }
}
