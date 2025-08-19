import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/pool/relay/core/relay.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/pool/relay/core/relay_type.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/pool/relay/types/models.dart';

/// Class representing a single host address relay.
class SingleHostAddr extends Relay {
  /// The port associated with the single host address relay.
  final int? port;

  /// The IPv4 address associated with the single host address relay.
  final Ipv4? ipv4;

  /// The IPv6 address associated with the single host address relay.
  final Ipv6? ipv6;

  /// Constructs a SingleHostAddr instance.
  const SingleHostAddr({this.port, this.ipv4, this.ipv6});

  /// Deserialize a SingleHostAddr instance from CBOR data.
  factory SingleHostAddr.deserialize(CborListValue cbor) {
    RelayType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: RelayType.singleHostAddr);
    return SingleHostAddr(
      port: cbor.elementAt<CborIntValue?>(1)?.value,
      ipv4: cbor
          .elementAt<CborBytesValue?>(2)
          ?.convertTo<Ipv4, CborBytesValue>((e) => Ipv4.deserialize(e)),
      ipv6: cbor
          .elementAt<CborBytesValue?>(3)
          ?.convertTo<Ipv6, CborBytesValue>((e) => Ipv6.deserialize(e)),
    );
  }

  factory SingleHostAddr.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson = json['single_host_addr'] ?? json;
    return SingleHostAddr(
        ipv4: correctJson['ipv4'] == null
            ? null
            : Ipv4.fromJson(correctJson['ipv4']),
        ipv6: correctJson['ipv6'] == null
            ? null
            : Ipv6.fromJson(correctJson['ipv6']),
        port: correctJson['port']);
  }

  SingleHostAddr copyWith({
    int? port,
    Ipv4? ipv4,
    Ipv6? ipv6,
  }) {
    return SingleHostAddr(
        port: port ?? this.port,
        ipv4: ipv4 ?? this.ipv4,
        ipv6: ipv6 ?? this.ipv6);
  }

  @override
  CborObject toCbor() {
    return CborListValue<CborObject>.definite(<CborObject>[
      type.toCbor(),
      if (port == null) const CborNullValue() else CborIntValue(port!),
      ipv4?.toCbor() ?? const CborNullValue(),
      ipv6?.toCbor() ?? const CborNullValue()
    ]);
  }

  @override
  RelayType get type => RelayType.singleHostAddr;
  @override
  Map<String, dynamic> toJson() {
    return {
      'single_host_addr': {
        'port': port,
        'ipv4': ipv4?.toJson(),
        'ipv6': ipv6?.toJson(),
      }
    };
  }
}
