import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

/// Represents a stake deregistration certificate with serialization support.
class StakeDeregistration extends Certificate {
  /// The stake credential.
  final Credential stakeCredential;

  /// Constructs a StakeDeregistration object with the specified stake credential.
  const StakeDeregistration(this.stakeCredential);

  /// Deserializes a StakeDeregistration object from its CBOR representation.
  factory StakeDeregistration.deserialize(CborListValue cbor) {
    CertificateType.deserialize(
      cbor.elementAt<CborIntValue>(0),
      validate: CertificateType.stakeDeregistration,
    );
    return StakeDeregistration(
        Credential.deserialize(cbor.elementAt<CborListValue>(1)));
  }
  factory StakeDeregistration.fromJson(Map<String, dynamic> json) {
    final currentJson = json[CertificateType.stakeDeregistration.name] ?? json;
    return StakeDeregistration(
        Credential.fromJson(currentJson['stake_credential']));
  }
  StakeDeregistration copyWith({Credential? stakeCredential}) {
    return StakeDeregistration(stakeCredential ?? this.stakeCredential);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      stakeCredential.toCbor(),
    ]);
  }

  @override
  CertificateType get type => CertificateType.stakeDeregistration;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {'stake_credential': stakeCredential.toJson()}
    };
  }

  @override
  List<Credential> get signersCredential => [stakeCredential];
}
