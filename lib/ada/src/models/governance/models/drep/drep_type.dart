import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor/cbor_serialization.dart';

/// Represents a drep type.
class DRepType with ADASerialization {
  /// The name of the drep type.
  final String name;

  /// The value of the drep type.
  final int value;

  const DRepType._(this.name, this.value);

  static const DRepType drepKeyHash = DRepType._('key_hash', 0);

  static const DRepType drepScriptHash = DRepType._('script_hash', 1);

  static const DRepType alwaysAbstain = DRepType._('always_abstain', 2);

  static const DRepType alwaysNoConfidence =
      DRepType._('always_no_confidence', 3);

  /// List of all drep types.
  static const List<DRepType> values = [
    drepKeyHash,
    drepScriptHash,
    alwaysAbstain,
    alwaysNoConfidence,
  ];

  factory DRepType.deserialize(CborIntValue cbor, {DRepType? validate}) {
    final type = fromValue(cbor.value);
    if (validate != null && type != validate) {
      throw ADAPluginException('Invalid DRep type.',
          details: {'expected': validate, 'Type': type});
    }
    return type;
  }

  factory DRepType.fromJson(Map<String, dynamic> json, {DRepType? validate}) {
    final type = fromName(json.keys.firstOrNull);
    if (validate != null && type != validate) {
      throw ADAPluginException('Invalid DRep type.',
          details: {'expected': validate, 'Type': type});
    }
    return type;
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  /// Returns the [DRepType] corresponding to the provided [value].
  static DRepType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No DRepType found matching the specified value',
          details: {'value': value}),
    );
  }

  /// Returns the [DRepType] corresponding to the provided [value].
  static DRepType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No DRepType found matching the specified name',
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
