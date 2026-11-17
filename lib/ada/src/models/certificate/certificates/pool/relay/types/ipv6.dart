import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/constants/constant.dart';
import 'package:on_chain/ada/src/models/utils/utils.dart';

/// Class representing an IPv6 address.
class Ipv6 with InternalCborSerialization {
  /// The IPv6 address.
  final BuBytes ipv6;

  /// Constructs an IPv6 instance.
  Ipv6(List<int> ipv6)
    : ipv6 = AdaTransactionUtils.validateFixedLengthBytes(
        bytes: ipv6,
        length: AdaTransactionConstant.ipv6Length,
        objectName: 'IPv6',
      );

  /// Deserialize an IPv6 instance from CBOR data.
  factory Ipv6.deserialize(CborBytesValue cbor) {
    return Ipv6(cbor.value);
  }
  factory Ipv6.fromJson(String value) {
    final bytes = <int>[];
    for (final group in value.split(':')) {
      bytes.addAll(BytesUtils.fromHexString(group.padLeft(4, '0')));
    }
    return Ipv6(bytes);
  }
  Ipv6 copyWith({List<int>? ipv6}) {
    return Ipv6(ipv6 ?? this.ipv6);
  }

  @override
  CborObject toCbor() {
    return CborBytesValue(ipv6);
  }

  @override
  String toJson() {
    final groups = <String>[];
    for (var i = 0; i < ipv6.length; i += 2) {
      groups.add(
        BytesUtils.toHexString(
          IntUtils.toBytes(
            IntUtils.fromBytes(ipv6, offset: i, length: 2),
            length: 2,
          ),
        ),
      );
    }
    return groups.join(':');
  }
}
