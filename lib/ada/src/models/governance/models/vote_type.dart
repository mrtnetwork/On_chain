import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:on_chain/serialization/cbor/cbor_serialization.dart';

/// Represents a vote type.
class VoteType with InternalCborSerialization {
  /// The name of the vote type.
  final String name;

  /// The value of the vote type.
  final int value;

  const VoteType._(this.name, this.value);

  static const VoteType no = VoteType._('no', 0);

  static const VoteType yes = VoteType._('yes', 1);

  static const VoteType abstain = VoteType._('abstain', 2);

  /// List of all vote types.
  static const List<VoteType> values = [no, yes, abstain];

  factory VoteType.deserialize(CborIntValue cbor) {
    return fromValue(cbor.value);
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  /// Returns the [VoteType] corresponding to the provided [value].
  static VoteType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ItemNotFoundException(name: "VoteType"),
    );
  }

  /// Returns the [VoteType] corresponding to the provided [value].
  static VoteType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ItemNotFoundException(name: "VoteType"),
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
