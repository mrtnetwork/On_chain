import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

/// Represents a stake delegation certificate with serialization support.
class StakeDelegation extends Certificate {
  /// The stake credential.
  final Credential stakeCredential;

  /// The pool key hash.
  final Ed25519PoolKeyHash poolKeyHash;

  /// Constructs a StakeDelegation object with the specified stake credential and pool key hash.
  const StakeDelegation(
      {required this.stakeCredential, required this.poolKeyHash});

  /// Deserializes a StakeDelegation object from its CBOR representation.
  factory StakeDelegation.deserialize(CborListValue cbor) {
    CertificateType.deserialize(
      cbor.elementAt<CborIntValue>(0),
      validate: CertificateType.stakeDelegation,
    );
    return StakeDelegation(
      stakeCredential: Credential.deserialize(cbor.elementAt<CborListValue>(1)),
      poolKeyHash:
          Ed25519PoolKeyHash.deserialize(cbor.elementAt<CborBytesValue>(2)),
    );
  }
  factory StakeDelegation.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> correctJson =
        json[CertificateType.stakeDelegation.name] ?? json;
    return StakeDelegation(
        stakeCredential: Credential.fromJson(correctJson['stake_credential']),
        poolKeyHash: Ed25519PoolKeyHash.fromHex(correctJson['pool_keyhash']));
  }

  StakeDelegation copyWith(
      {Credential? stakeCredential, Ed25519PoolKeyHash? poolKeyHash}) {
    return StakeDelegation(
        stakeCredential: stakeCredential ?? this.stakeCredential,
        poolKeyHash: poolKeyHash ?? this.poolKeyHash);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      stakeCredential.toCbor(),
      poolKeyHash.toCbor(),
    ]);
  }

  @override
  CertificateType get type => CertificateType.stakeDelegation;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'stake_credential': stakeCredential.toJson(),
        'pool_keyhash': poolKeyHash.toJson(),
      }
    };
  }

  @override
  List<Credential> get signersCredential => [stakeCredential];
}
