import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class RedeemerTag with ADASerialization {
  final String name;
  final int value;
  const RedeemerTag._(this.name, this.value);
  static const RedeemerTag spend = RedeemerTag._("Spend", 0);
  static const RedeemerTag mint = RedeemerTag._("Mint", 1);
  static const RedeemerTag cert = RedeemerTag._("Cert", 2);
  static const RedeemerTag reward = RedeemerTag._("Reward", 3);
  static const List<RedeemerTag> values = [spend, mint, cert, reward];
  factory RedeemerTag.deserialize(CborIntValue cbor) {
    return fromValue(cbor.value);
  }

  static RedeemerTag fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No RedeemerTag found matching the specified value",
          details: {"value": value}),
    );
  }

  static RedeemerTag fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw MessageException(
          "No RedeemerTag found matching the specified name",
          details: {"name": name}),
    );
  }

  @override
  String toString() {
    return "RedeemerTag.$name";
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  @override
  String toJson() {
    return name;
  }
}
