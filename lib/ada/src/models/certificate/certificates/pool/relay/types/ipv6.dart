import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/constants/constant.dart';
import 'package:on_chain/ada/src/models/utils/utils.dart';

/// Class representing an IPv6 address.
class Ipv6 with ADASerialization {
  /// The IPv6 address.
  final List<int> ipv6;

  /// Constructs an IPv6 instance.
  Ipv6(List<int> ipv6)
      : ipv6 = AdaTransactionUtils.validateFixedLengthBytes(
            bytes: ipv6,
            length: AdaTransactionConstant.ipv6Length,
            objectName: 'IPv6');

  /// Deserialize an IPv6 instance from CBOR data.
  factory Ipv6.deserialize(CborBytesValue cbor) {
    return Ipv6(cbor.value);
  }
  factory Ipv6.fromJson(String value) {
    return Ipv6(
        value.split(':').map<int>((e) => int.parse(e, radix: 16)).toList());
  }
  Ipv6 copyWith({
    List<int>? ipv6,
  }) {
    return Ipv6(ipv6 ?? this.ipv6);
  }

  @override
  CborObject toCbor() {
    return CborBytesValue(ipv6);
  }

  @override
  String toJson() {
    return ipv6.map((e) => e.toRadixString(16).padLeft(2, '0')).join(':');
  }
}
