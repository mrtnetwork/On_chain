import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/governance/models/anchor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

class CommitteeColdResign extends Certificate {
  final Credential committeeColdCredential;

  final Anchor? anchor;

  const CommitteeColdResign(
      {required this.committeeColdCredential, required this.anchor});

  factory CommitteeColdResign.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.committeeColdResign);
    return CommitteeColdResign(
        committeeColdCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        anchor: cbor
            .elementAt<CborListValue?>(2)
            ?.convertTo<Anchor, CborListValue>((e) => Anchor.deserialize(e)));
  }
  factory CommitteeColdResign.fromJson(Map<String, dynamic> json) {
    final currentJson = json[CertificateType.committeeColdResign.name] ?? json;
    final anchor = currentJson['anchor'];
    return CommitteeColdResign(
        committeeColdCredential:
            Credential.fromJson(currentJson['committee_cold_credential']),
        anchor: anchor == null ? null : Anchor.fromJson(anchor));
  }

  @override
  CborListValue toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      committeeColdCredential.toCbor(),
      anchor?.toCbor() ?? const CborNullValue(),
    ]);
  }

  @override
  CertificateType get type => CertificateType.committeeColdResign;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'committee_cold_credential': committeeColdCredential.toJson(),
        'anchor': anchor?.toJson()
      }
    };
  }

  @override
  List<Credential> get signersCredential => [committeeColdCredential];
}
