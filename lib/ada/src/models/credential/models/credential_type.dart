import 'package:blockchain_utils/cbor/cbor.dart';

import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

/// Represents the type of a credential.
class CredentialType with InternalCborSerialization {
  /// The name of the credential type.
  final String name;

  /// The value of the credential type.
  final int value;

  /// Constructs a [CredentialType] with the specified [name] and [value].
  const CredentialType._({required this.name, required this.value});

  /// Represents a key credential type.
  static const CredentialType key = CredentialType._(name: 'Key', value: 0);

  /// Represents a script credential type.
  static const CredentialType script =
      CredentialType._(name: 'Script', value: 1);

  bool get isScript => this == script;
  bool get isKey => this == key;

  /// A list containing all defined [CredentialType] values.
  static const List<CredentialType> values = [key, script];

  /// Deserializes a [CredentialType] from a CBOR integer value [cbor].
  factory CredentialType.deserialize(CborIntValue cbor) {
    return fromValue(cbor.value);
  }

  /// Returns the [CredentialType] corresponding to the specified [value].
  static CredentialType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No CredentialType found matching the specified value',
          details: {'value': value}),
    );
  }

  /// Returns the [CredentialType] corresponding to the specified [name].
  static CredentialType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No CredentialType found matching the specified name',
          details: {'name': name}),
    );
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  @override
  String toString() {
    return 'CredentialType.$name';
  }

  @override
  String toJson() {
    return name;
  }
}
