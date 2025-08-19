import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

class StakeRegistrationAndDelegation extends Certificate {
  final Credential stakeCredential;
  final Ed25519PoolKeyHash poolKeyHash;
  final BigInt coin;
  const StakeRegistrationAndDelegation(
      {required this.stakeCredential,
      required this.poolKeyHash,
      required this.coin});

  factory StakeRegistrationAndDelegation.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.stakeRegistrationAndDelegation);
    return StakeRegistrationAndDelegation(
        stakeCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        poolKeyHash:
            Ed25519PoolKeyHash.deserialize(cbor.elementAt<CborBytesValue>(2)),
        coin: cbor.elementAsInteger(3));
  }
  factory StakeRegistrationAndDelegation.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson =
        json[CertificateType.stakeRegistrationAndDelegation.name] ?? json;
    return StakeRegistrationAndDelegation(
        stakeCredential: Credential.fromJson(correctJson['stake_credential']),
        poolKeyHash: Ed25519PoolKeyHash.fromHex(correctJson['pool_keyhash']),
        coin: BigintUtils.parse(correctJson["coin"]));
  }

  StakeRegistrationAndDelegation copyWith(
      {Credential? stakeCredential,
      Ed25519PoolKeyHash? poolKeyHash,
      BigInt? coin}) {
    return StakeRegistrationAndDelegation(
        stakeCredential: stakeCredential ?? this.stakeCredential,
        poolKeyHash: poolKeyHash ?? this.poolKeyHash,
        coin: coin ?? this.coin);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      stakeCredential.toCbor(),
      poolKeyHash.toCbor(),
      CborUnsignedValue.u64(coin)
    ]);
  }

  @override
  CertificateType get type => CertificateType.stakeRegistrationAndDelegation;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'stake_credential': stakeCredential.toJson(),
        'pool_keyhash': poolKeyHash.toJson(),
        'coin': coin.toString()
      }
    };
  }

  @override
  List<Credential> get signersCredential => [stakeCredential];
}
