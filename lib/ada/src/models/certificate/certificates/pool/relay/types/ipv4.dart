import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/constants/constant.dart';
import 'package:on_chain/ada/src/models/utils/utils.dart';

/// Class representing an IPv4 address.
class Ipv4 with InternalCborSerialization {
  /// The IPv4 address.
  final List<int> ipv4;

  /// Constructs an IPv4 instance.
  Ipv4(List<int> ipv4)
      : ipv4 = AdaTransactionUtils.validateFixedLengthBytes(
            bytes: ipv4,
            length: AdaTransactionConstant.ipv4Length,
            objectName: 'IPv4');

  /// Deserialize an IPv4 instance from CBOR data.
  factory Ipv4.deserialize(CborBytesValue cbor) {
    return Ipv4(cbor.value);
  }
  factory Ipv4.fromJson(String value) {
    return Ipv4(value.split('.').map<int>((e) => int.parse(e)).toList());
  }
  Ipv4 copyWith({
    List<int>? ipv4,
  }) {
    return Ipv4(
      ipv4 ?? this.ipv4,
    );
  }

  @override
  CborObject toCbor() {
    return CborBytesValue(ipv4);
  }

  @override
  String toJson() {
    return ipv4.join('.');
  }
}
