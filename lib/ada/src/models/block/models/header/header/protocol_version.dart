import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

class ProtocolVersion with InternalCborSerialization {
  final int major;
  final int minor;
  const ProtocolVersion({required this.major, required this.minor});

  factory ProtocolVersion.deserialize(CborListValue cbor) {
    return ProtocolVersion(
        major: cbor.elementAt<CborIntValue>(0).value,
        minor: cbor.elementAt<CborIntValue>(1).value);
  }
  factory ProtocolVersion.fromJson(Map<String, dynamic> json) {
    return ProtocolVersion(major: json['major'], minor: json['minor']);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite(toCborObjects());
  }

  List<CborObject> toCborObjects() {
    return [CborUnsignedValue.u32(major), CborUnsignedValue.u32(minor)];
  }

  @override
  Map<String, dynamic> toJson() {
    return {'major': major, 'minor': minor};
  }
}
