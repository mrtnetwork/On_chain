import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

class CommitteeHotAuth extends Certificate {
  final Credential committeeColdCredential;

  final Credential committeeHotCredential;

  const CommitteeHotAuth(
      {required this.committeeColdCredential,
      required this.committeeHotCredential});

  factory CommitteeHotAuth.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.committeeHotAuth);
    return CommitteeHotAuth(
        committeeColdCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        committeeHotCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(2)));
  }
  factory CommitteeHotAuth.fromJson(Map<String, dynamic> json) {
    final currentJson = json[CertificateType.committeeHotAuth.name] ?? json;
    return CommitteeHotAuth(
        committeeColdCredential:
            Credential.fromJson(currentJson['committee_cold_credential']),
        committeeHotCredential:
            Credential.fromJson(currentJson['committee_hot_credential']));
  }

  @override
  CborListValue toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      committeeColdCredential.toCbor(),
      committeeHotCredential.toCbor(),
    ]);
  }

  @override
  CertificateType get type => CertificateType.committeeHotAuth;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'committee_cold_credential': committeeColdCredential.toJson(),
        'committee_hot_credential': committeeHotCredential.toJson()
      }
    };
  }

  @override
  List<Credential> get signersCredential => [committeeColdCredential];
}
