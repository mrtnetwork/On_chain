import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

/// Represents a stake registration certificate with serialization support.
class StakeRegistration extends Certificate {
  /// The stake credential.
  final Credential stakeCredential;

  /// Constructs a StakeRegistration object with the specified stake credential.
  const StakeRegistration(this.stakeCredential);

  /// Deserializes a StakeRegistration object from its CBOR representation.
  factory StakeRegistration.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.stakeRegistration);
    return StakeRegistration(
        Credential.deserialize(cbor.elementAt<CborListValue>(1)));
  }
  factory StakeRegistration.fromJson(Map<String, dynamic> json) {
    final currentJson = json[CertificateType.stakeRegistration.name] ?? json;
    return StakeRegistration(
        Credential.fromJson(currentJson['stake_credential']));
  }
  StakeRegistration copyWith({Credential? stakeCredential}) {
    return StakeRegistration(stakeCredential ?? this.stakeCredential);
  }

  @override
  CborListValue toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      stakeCredential.toCbor(),
    ]);
  }

  @override
  CertificateType get type => CertificateType.stakeRegistration;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {'stake_credential': stakeCredential.toJson()}
    };
  }

  @override
  List<Credential> get signersCredential => [stakeCredential];
}
