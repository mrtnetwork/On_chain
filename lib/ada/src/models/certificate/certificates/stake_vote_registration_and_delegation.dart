import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/governance/models/drep/drep.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

class StakeVoteRegistrationAndDelegation extends Certificate {
  final Credential stakeCredential;
  final Ed25519PoolKeyHash poolKeyHash;
  final DRep drep;
  final BigInt coin;
  const StakeVoteRegistrationAndDelegation(
      {required this.stakeCredential,
      required this.poolKeyHash,
      required this.drep,
      required this.coin});

  factory StakeVoteRegistrationAndDelegation.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.stakeVoteRegistrationAndDelegation);
    return StakeVoteRegistrationAndDelegation(
        stakeCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        poolKeyHash:
            Ed25519PoolKeyHash.deserialize(cbor.elementAt<CborBytesValue>(2)),
        drep: DRep.deserialize(cbor.elementAt<CborListValue>(3)),
        coin: cbor.elementAsInteger(4));
  }
  factory StakeVoteRegistrationAndDelegation.fromJson(
      Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson =
        json[CertificateType.stakeVoteRegistrationAndDelegation.name] ?? json;
    return StakeVoteRegistrationAndDelegation(
        stakeCredential: Credential.fromJson(correctJson['stake_credential']),
        poolKeyHash: Ed25519PoolKeyHash.fromHex(correctJson['pool_keyhash']),
        drep: DRep.fromJson(correctJson["drep"]),
        coin: BigintUtils.parse(correctJson['coin']));
  }

  StakeVoteRegistrationAndDelegation copyWith(
      {Credential? stakeCredential,
      Ed25519PoolKeyHash? poolKeyHash,
      DRep? drep,
      BigInt? coin}) {
    return StakeVoteRegistrationAndDelegation(
        stakeCredential: stakeCredential ?? this.stakeCredential,
        poolKeyHash: poolKeyHash ?? this.poolKeyHash,
        drep: drep ?? this.drep,
        coin: coin ?? this.coin);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      stakeCredential.toCbor(),
      poolKeyHash.toCbor(),
      drep.toCbor(),
      CborUnsignedValue.u64(coin)
    ]);
  }

  @override
  CertificateType get type =>
      CertificateType.stakeVoteRegistrationAndDelegation;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'stake_credential': stakeCredential.toJson(),
        'pool_keyhash': poolKeyHash.toJson(),
        'drep': drep.toJson(),
        'coin': coin.toString()
      }
    };
  }

  @override
  List<Credential> get signersCredential => [stakeCredential];
}
