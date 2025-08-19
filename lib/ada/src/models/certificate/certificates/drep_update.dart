import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/governance/models/anchor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

class DRepUpdate extends Certificate {
  final Credential votingCredential;
  final Anchor? anchor;

  const DRepUpdate({required this.votingCredential, this.anchor});

  factory DRepUpdate.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.dRepUpdate);
    return DRepUpdate(
        votingCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        anchor: cbor
            .elementAt<CborListValue?>(2)
            ?.convertTo<Anchor, CborListValue>((e) => Anchor.deserialize(e)));
  }
  factory DRepUpdate.fromJson(Map<String, dynamic> json) {
    final currentJson = json[CertificateType.dRepUpdate.name] ?? json;
    final anchor = currentJson['anchor'];
    return DRepUpdate(
        votingCredential: Credential.fromJson(currentJson['voting_credential']),
        anchor: anchor == null ? null : Anchor.fromJson(anchor));
  }

  @override
  CborListValue toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      votingCredential.toCbor(),
      anchor?.toCbor() ?? const CborNullValue(),
    ]);
  }

  @override
  CertificateType get type => CertificateType.dRepUpdate;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'voting_credential': votingCredential.toJson(),
        'anchor': anchor?.toJson()
      }
    };
  }

  @override
  List<Credential> get signersCredential => [votingCredential];
}
