import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Represents a native script type.
class NativeScriptType with ADASerialization {
  /// The name of the native script type.
  final String name;

  /// The value of the native script type.
  final int value;

  /// Constructs a [NativeScriptType] with the given [name] and [value].
  const NativeScriptType._(this.name, this.value);

  /// Native script type representing a script pubkey.
  static const NativeScriptType scriptPubkey =
      NativeScriptType._('ScriptPubkey', 0);

  /// Native script type representing a script all.
  static const NativeScriptType scriptAll = NativeScriptType._('ScriptAll', 1);

  /// Native script type representing a script any.
  static const NativeScriptType scriptAny = NativeScriptType._('ScriptAny', 2);

  /// Native script type representing a script n-of-k.
  static const NativeScriptType scriptNOfK =
      NativeScriptType._('ScriptNOfK', 3);

  /// Native script type representing a timelock start.
  static const NativeScriptType timelockStart =
      NativeScriptType._('TimelockStart', 4);

  /// Native script type representing a timelock expiry.
  static const NativeScriptType timelockExpiry =
      NativeScriptType._('TimelockExpiry', 5);

  /// List of all native script types.
  static const List<NativeScriptType> values = [
    scriptPubkey,
    scriptAll,
    scriptAny,
    scriptNOfK,
    timelockStart,
    timelockExpiry
  ];

  /// Deserializes a [NativeScriptType] from CBOR.
  factory NativeScriptType.deserialize(CborIntValue cbor) {
    return fromValue(cbor.value);
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  /// Returns the [NativeScriptType] corresponding to the provided [value].
  static NativeScriptType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No NativeScriptType found matching the specified value',
          details: {'value': value}),
    );
  }

  /// Returns the [NativeScriptType] corresponding to the provided [value].
  static NativeScriptType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No NativeScriptType found matching the specified name',
          details: {'name': name}),
    );
  }

  @override
  String toString() {
    return 'NativeScriptType.$name';
  }

  @override
  String toJson() {
    return name;
  }
}
