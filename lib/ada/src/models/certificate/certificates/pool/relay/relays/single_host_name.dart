import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/pool/relay/core/relay.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/pool/relay/core/relay_type.dart';

/// Class representing a single host name relay for Cardano transactions.
class SingleHostName extends Relay {
  /// The port associated with the single host name relay.
  final int? port;

  /// The DNS name associated with the single host name relay.
  final String dnsName;

  /// Constructs a SingleHostName instance.
  const SingleHostName({this.port, required this.dnsName});

  /// Deserialize a SingleHostName instance from CBOR data.
  factory SingleHostName.deserialize(CborListValue cbor) {
    RelayType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: RelayType.singleHostName);
    return SingleHostName(
        port: cbor.elementAt<CborIntValue?>(1)?.value,
        dnsName: cbor.elementAt<CborStringValue>(2).value);
  }
  factory SingleHostName.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson = json['single_host_name'] ?? json;
    return SingleHostName(
        dnsName: correctJson['dns_name'], port: correctJson['port']);
  }
  SingleHostName copyWith({int? port, String? dnsName}) {
    return SingleHostName(
        port: port ?? this.port, dnsName: dnsName ?? this.dnsName);
  }

  @override
  CborObject toCbor() {
    return CborListValue<CborObject>.definite([
      type.toCbor(),
      if (port == null) CborNullValue() else CborIntValue(port!),
      CborStringValue(dnsName)
    ]);
  }

  @override
  RelayType get type => RelayType.singleHostName;

  @override
  Map<String, dynamic> toJson() {
    return {
      'single_host_name': {'port': port, 'dns_name': dnsName}
    };
  }
}
