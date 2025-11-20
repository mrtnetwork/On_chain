import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/governance/models/drep/drep.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

class StakeAndVoteDelegation extends Certificate {
  final Credential stakeCredential;
  final Ed25519PoolKeyHash poolKeyHash;
  final DRep drep;
  const StakeAndVoteDelegation(
      {required this.stakeCredential,
      required this.poolKeyHash,
      required this.drep});

  factory StakeAndVoteDelegation.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.stakeAndVoteDelegation);
    return StakeAndVoteDelegation(
        stakeCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        poolKeyHash:
            Ed25519PoolKeyHash.deserialize(cbor.elementAt<CborBytesValue>(2)),
        drep: DRep.deserialize(cbor.elementAt<CborListValue>(3)));
  }
  factory StakeAndVoteDelegation.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson =
        json[CertificateType.stakeAndVoteDelegation.name] ?? json;
    return StakeAndVoteDelegation(
        stakeCredential: Credential.fromJson(correctJson['stake_credential']),
        poolKeyHash: Ed25519PoolKeyHash.fromHex(correctJson['pool_keyhash']),
        drep: DRep.fromJson(correctJson["drep"]));
  }

  StakeAndVoteDelegation copyWith(
      {Credential? stakeCredential,
      Ed25519PoolKeyHash? poolKeyHash,
      DRep? drep}) {
    return StakeAndVoteDelegation(
        stakeCredential: stakeCredential ?? this.stakeCredential,
        poolKeyHash: poolKeyHash ?? this.poolKeyHash,
        drep: drep ?? this.drep);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      stakeCredential.toCbor(),
      poolKeyHash.toCbor(),
      drep.toCbor()
    ]);
  }

  @override
  CertificateType get type => CertificateType.stakeAndVoteDelegation;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'stake_credential': stakeCredential.toJson(),
        'pool_keyhash': poolKeyHash.toJson(),
        'drep': drep.toJson()
      }
    };
  }

  @override
  List<Credential> get signersCredential => [stakeCredential];
}
