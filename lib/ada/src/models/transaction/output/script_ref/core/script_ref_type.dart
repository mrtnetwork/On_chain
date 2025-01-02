import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/types/int.dart';

import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Represents the type of a script reference.
class ScriptRefType with ADASerialization {
  /// The name of the script reference type.
  final String name;

  /// The value representing the script reference type.
  final int value;

  /// Creates a [ScriptRefType] instance.
  const ScriptRefType._(this.name, this.value);

  /// Native script reference type.
  static const ScriptRefType nativeScript = ScriptRefType._('native_script', 0);

  /// Plutus script reference type.
  static const ScriptRefType plutusScript = ScriptRefType._('plutus_script', 1);

  /// List of all script reference types.
  static const List<ScriptRefType> values = [nativeScript, plutusScript];

  /// Deserializes a [ScriptRefType] instance from CBOR.
  factory ScriptRefType.deserialize(CborIntValue cbor,
      {ScriptRefType? validate}) {
    final type = fromValue(cbor.value);
    if (validate != null && type != validate) {
      throw ADAPluginException('Invalid ScriptRefType.',
          details: {'Expected': validate, 'Type': type});
    }
    return fromValue(cbor.value);
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  /// Gets the [ScriptRefType] instance corresponding to the provided value.
  static ScriptRefType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No ScriptRefType found matching the specified value',
          details: {'value': value}),
    );
  }

  /// Gets the [ScriptRefType] instance corresponding to the provided name.
  static ScriptRefType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No ScriptRefType found matching the specified name',
          details: {'name': name}),
    );
  }

  /// Converts the [ScriptRefType] instance to its JSON representation.
  @override
  String toJson() {
    return name;
  }

  /// Converts the [ScriptRefType] instance to a string representation.
  @override
  String toString() {
    return 'ScriptRefType.$name';
  }
}
