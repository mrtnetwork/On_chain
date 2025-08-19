import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/pool/relay/core/relay.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/pool/relay/core/relay_type.dart';

/// Class representing a multi-hostname relay.
class MultiHostName extends Relay {
  /// The DNS name associated with the multi-hostname relay.
  final String dnsName;

  /// Constructs a MultiHostName instance.
  const MultiHostName({required this.dnsName});

  /// Deserialize a MultiHostName instance from CBOR data.
  factory MultiHostName.deserialize(CborListValue cbor) {
    RelayType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: RelayType.multiHostName);
    return MultiHostName(dnsName: cbor.elementAt<CborStringValue>(1).value);
  }
  factory MultiHostName.fromJson(Map<String, dynamic> json) {
    return MultiHostName(
        dnsName: json['dns_name'] ?? json['multi_host_name']['dns_name']);
  }
  MultiHostName copyWith({String? dnsName}) {
    return MultiHostName(dnsName: dnsName ?? this.dnsName);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([type.toCbor(), CborStringValue(dnsName)]);
  }

  @override
  RelayType get type => RelayType.multiHostName;

  @override
  Map<String, dynamic> toJson() {
    return {
      'multi_host_name': {'dns_name': dnsName}
    };
  }
}
