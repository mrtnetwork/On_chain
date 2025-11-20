import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/governance/models/drep/drep.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

class VoteDelegation extends Certificate {
  final Credential stakeCredential;
  final DRep drep;
  const VoteDelegation({
    required this.stakeCredential,
    required this.drep,
  });

  factory VoteDelegation.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.voteDelegation);
    return VoteDelegation(
        stakeCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        drep: DRep.deserialize(cbor.elementAt<CborListValue>(2)));
  }
  factory VoteDelegation.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson =
        json[CertificateType.voteDelegation.name] ?? json;
    return VoteDelegation(
        stakeCredential: Credential.fromJson(correctJson['stake_credential']),
        drep: DRep.fromJson(correctJson["drep"]));
  }

  VoteDelegation copyWith({Credential? stakeCredential, DRep? drep}) {
    return VoteDelegation(
      stakeCredential: stakeCredential ?? this.stakeCredential,
      drep: drep ?? this.drep,
    );
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      stakeCredential.toCbor(),
      drep.toCbor(),
    ]);
  }

  @override
  CertificateType get type => CertificateType.voteDelegation;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'stake_credential': stakeCredential.toJson(),
        'drep': drep.toJson(),
      }
    };
  }

  @override
  List<Credential> get signersCredential => [stakeCredential];
}
