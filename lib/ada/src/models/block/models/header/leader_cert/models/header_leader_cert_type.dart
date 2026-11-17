import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/serialization/cbor_serialization.dart';

class HeaderLeaderCertType with InternalCborSerialization {
  final String name;
  final int value;
  const HeaderLeaderCertType._(this.name, this.value);
  static const HeaderLeaderCertType nonceAndLeader = HeaderLeaderCertType._(
    'NonceAndLeader',
    0,
  );
  static const HeaderLeaderCertType vrfResult = HeaderLeaderCertType._(
    'VrfResult',
    1,
  );
  static const List<HeaderLeaderCertType> values = [nonceAndLeader, vrfResult];
  factory HeaderLeaderCertType.deserialize(
    CborIntValue cbor, {
    HeaderLeaderCertType? validate,
  }) {
    final type = fromValue(cbor.value);
    if (validate != null && type != validate) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid HeaderLeaderCertType.',
        details: {'expected': validate.toString(), 'Type': type.toString()},
      );
    }
    return type;
  }

  static HeaderLeaderCertType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                'Invalid HeaderLeaderCertType value.',
                details: {'value': '$value'},
              ),
    );
  }

  static HeaderLeaderCertType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.invalidArgument,
                'Invalid HeaderLeaderCertType name.',
                details: {'name': name},
              ),
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
