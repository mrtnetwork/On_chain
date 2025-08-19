import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor/cbor_serialization.dart';

/// Represents a voter type.
class VoterType with ADASerialization {
  /// The name of the voter type.
  final String name;

  /// The value of the voter type.
  final int value;

  const VoterType._(this.name, this.value);

  static const VoterType constitutionalCommitteeHotKeyHash =
      VoterType._('constitutional_committee_hot_key_hash', 0);

  static const VoterType constitutionalCommitteeHotScriptHash =
      VoterType._('constitutional_committee_hot_script_hash', 1);

  static const VoterType drepKeyHash = VoterType._('drep_key_hash', 2);

  static const VoterType drepScriptHash = VoterType._('drep_script_hash', 3);

  static const VoterType stakingPoolKeyHash =
      VoterType._('staking_pool_key_hash', 4);

  /// List of all voter types.
  static const List<VoterType> values = [
    constitutionalCommitteeHotKeyHash,
    constitutionalCommitteeHotScriptHash,
    drepKeyHash,
    drepScriptHash,
    stakingPoolKeyHash
  ];

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  static VoterType fromJson(String? value, {VoterType? validate}) {
    final type = fromName(value);
    if (validate != null && type != validate) {
      throw ADAPluginException('Invalid VoterType.',
          details: {'expected': validate, 'Type': type});
    }
    return type;
  }

  static VoterType deserialize(int? value, {VoterType? validate}) {
    final type = fromValue(value);
    if (validate != null && type != validate) {
      throw ADAPluginException('Invalid VoterType.',
          details: {'expected': validate, 'Type': type});
    }
    return type;
  }

  /// Returns the [VoterType] corresponding to the provided [value].
  static VoterType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No VoterType found matching the specified value',
          details: {'value': value}),
    );
  }

  /// Returns the [VoterType] corresponding to the provided [value].
  static VoterType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No VoterType found matching the specified name',
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
