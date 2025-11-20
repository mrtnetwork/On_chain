import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/governance/models/drep/drep.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

class VoteRegistrationAndDelegation extends Certificate {
  final Credential stakeCredential;
  final DRep drep;
  final BigInt coin;
  const VoteRegistrationAndDelegation(
      {required this.stakeCredential, required this.drep, required this.coin});

  factory VoteRegistrationAndDelegation.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.voteRegistrationAndDelegation);
    return VoteRegistrationAndDelegation(
        stakeCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        drep: DRep.deserialize(cbor.elementAt<CborListValue>(2)),
        coin: cbor.elementAsInteger(3));
  }
  factory VoteRegistrationAndDelegation.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson =
        json[CertificateType.voteRegistrationAndDelegation.name] ?? json;
    return VoteRegistrationAndDelegation(
        stakeCredential: Credential.fromJson(correctJson['stake_credential']),
        drep: DRep.fromJson(correctJson["drep"]),
        coin: BigintUtils.parse(correctJson['coin']));
  }

  VoteRegistrationAndDelegation copyWith(
      {Credential? stakeCredential, DRep? drep, BigInt? coin}) {
    return VoteRegistrationAndDelegation(
        stakeCredential: stakeCredential ?? this.stakeCredential,
        drep: drep ?? this.drep,
        coin: coin ?? this.coin);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      stakeCredential.toCbor(),
      drep.toCbor(),
      CborUnsignedValue.u64(coin)
    ]);
  }

  @override
  CertificateType get type => CertificateType.voteRegistrationAndDelegation;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'stake_credential': stakeCredential.toJson(),
        'drep': drep.toJson(),
        'coin': coin.toString()
      }
    };
  }

  @override
  List<Credential> get signersCredential => [stakeCredential];
}
