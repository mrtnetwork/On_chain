import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Enum representing the type of relay.
class RelayType with ADASerialization {
  /// The name of the relay type.
  final String name;

  /// The value representing the relay type.
  final int value;

  /// Internal constructor for creating a RelayType instance.
  const RelayType._(this.name, this.value);

  /// RelayType for a single host address.
  static const RelayType singleHostAddr = RelayType._('single_host_addr', 0);

  /// RelayType for a single host name.
  static const RelayType singleHostName = RelayType._('single_host_name', 1);

  /// RelayType for multiple host names.
  static const RelayType multiHostName = RelayType._('multi_host_name', 2);

  /// List of all RelayType values.
  static const List<RelayType> values = [
    singleHostAddr,
    singleHostName,
    multiHostName
  ];

  /// Deserialize a RelayType from a CBOR integer value.
  factory RelayType.deserialize(CborIntValue cbor, {RelayType? validate}) {
    final type = fromValue(cbor.value);
    if (validate != null && type != validate) {
      throw ADAPluginException('Invalid RelayType.',
          details: {'Expected': validate, 'Type': type});
    }
    return fromValue(cbor.value);
  }

  /// Get the RelayType instance corresponding to a given value.
  static RelayType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No RelayType found matching the specified value',
          details: {'value': value}),
    );
  }

  /// Get the RelayType instance corresponding to a given name.
  static RelayType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No RelayType found matching the specified name',
          details: {'name': name}),
    );
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  @override
  String toString() {
    return 'RelayType.$name';
  }

  @override
  String toJson() {
    return name;
  }
}
