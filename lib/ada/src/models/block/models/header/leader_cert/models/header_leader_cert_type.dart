import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class HeaderLeaderCertType with InternalCborSerialization {
  final String name;
  final int value;
  const HeaderLeaderCertType._(this.name, this.value);
  static const HeaderLeaderCertType nonceAndLeader =
      HeaderLeaderCertType._('NonceAndLeader', 0);
  static const HeaderLeaderCertType vrfResult =
      HeaderLeaderCertType._('VrfResult', 1);
  static const List<HeaderLeaderCertType> values = [nonceAndLeader, vrfResult];
  factory HeaderLeaderCertType.deserialize(CborIntValue cbor,
      {HeaderLeaderCertType? validate}) {
    final type = fromValue(cbor.value);
    if (validate != null && type != validate) {
      throw ADAPluginException('Invalid HeaderLeaderCertType.',
          details: {'expected': validate, 'Type': type});
    }

    return fromValue(cbor.value);
  }

  static HeaderLeaderCertType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No HeaderLeaderCertType found matching the specified value',
          details: {'value': value}),
    );
  }

  static HeaderLeaderCertType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No HeaderLeaderCertType found matching the specified name',
          details: {'name': name}),
    );
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  @override
  String toString() {
    return 'HeaderLeaderCertType.$name';
  }

  @override
  String toJson() {
    return name;
  }
}
