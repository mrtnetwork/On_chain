import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor/cbor_serialization.dart';

/// Represents a drep type.
class DRepType with InternalCborSerialization {
  /// The name of the drep type.
  final String name;

  /// The value of the drep type.
  final int value;

  const DRepType._(this.name, this.value);

  static const DRepType drepKeyHash = DRepType._('key_hash', 0);

  static const DRepType drepScriptHash = DRepType._('script_hash', 1);

  static const DRepType alwaysAbstain = DRepType._('always_abstain', 2);

  static const DRepType alwaysNoConfidence = DRepType._(
    'always_no_confidence',
    3,
  );

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
      throw ADAPluginException(
        'Invalid DRep type.',
        details: {'expected': validate.toString(), 'Type': type.toString()},
      );
    }
    return type;
  }

  factory DRepType.fromJson(Map<String, dynamic> json, {DRepType? validate}) {
    final type = fromName(json.keys.firstOrNull);
    if (validate != null && type != validate) {
      throw ADAPluginException(
        'Invalid DRep type.',
        details: {'expected': validate.toString(), 'Type': type.toString()},
      );
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
      orElse: () => throw ItemNotFoundException(name: "DRepType"),
    );
  }

  /// Returns the [DRepType] corresponding to the provided [value].
  static DRepType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ItemNotFoundException(name: "DRepType"),
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
