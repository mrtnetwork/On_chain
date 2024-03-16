import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

class HeaderLeaderCertType with ADASerialization {
  final String name;
  final int value;
  const HeaderLeaderCertType._(this.name, this.value);
  static const HeaderLeaderCertType nonceAndLeader =
      HeaderLeaderCertType._("NonceAndLeader", 0);
  static const HeaderLeaderCertType vrfResult =
      HeaderLeaderCertType._("VrfResult", 1);
  static const List<HeaderLeaderCertType> values = [nonceAndLeader, vrfResult];
  factory HeaderLeaderCertType.deserialize(CborIntValue cbor,
      {HeaderLeaderCertType? validate}) {
    final type = fromValue(cbor.value);
    if (validate != null && type != validate) {
      throw MessageException("Invalid HeaderLeaderCertType.",
          details: {"Excepted": validate, "Type": type});
    }

    return fromValue(cbor.value);
  }

  static HeaderLeaderCertType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw MessageException(
          "No HeaderLeaderCertType found matching the specified value",
          details: {"value": value}),
    );
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  @override
  String toString() {
    return "HeaderLeaderCertType.$name";
  }

  @override
  String toJson() {
    return name;
  }
}
