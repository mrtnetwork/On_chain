import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/certificate/certs.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

/// Represents an abstract certificate with serialization capabilities.
abstract class Certificate with InternalCborSerialization {
  /// Constructs a [Certificate].
  const Certificate();

  /// The type of the certificate.
  abstract final CertificateType type;

  /// Constructs a certificate instance from its serialized form.
  factory Certificate.deserialize(CborListValue cbor) {
    final type = CertificateType.deserialize(cbor.elementAt<CborIntValue>(0));
    switch (type) {
      case CertificateType.genesisKeyDelegation:
        return GenesisKeyDelegation.deserialize(cbor);
      case CertificateType.moveInstantaneousRewardsCert:
        return MoveInstantaneousRewardsCert.deserialize(cbor);
      case CertificateType.poolRegistration:
        return PoolRegistration.deserialize(cbor);
      case CertificateType.poolRetirement:
        return PoolRetirement.deserialize(cbor);
      case CertificateType.stakeDelegation:
        return StakeDelegation.deserialize(cbor);
      case CertificateType.stakeDeregistration:
        return StakeDeregistration.deserialize(cbor);
      case CertificateType.stakeRegistration:
        return StakeRegistration.deserialize(cbor);

      case CertificateType.stakeRegistrationConway:
        return StakeRegistrationConway.deserialize(cbor);
      case CertificateType.stakeDeregistrationConway:
        return StakeDeregistrationConway.deserialize(cbor);

      case CertificateType.voteDelegation:
        return VoteDelegation.deserialize(cbor);
      case CertificateType.stakeAndVoteDelegation:
        return StakeAndVoteDelegation.deserialize(cbor);
      case CertificateType.stakeRegistrationAndDelegation:
        return StakeRegistrationAndDelegation.deserialize(cbor);
      case CertificateType.voteRegistrationAndDelegation:
        return VoteRegistrationAndDelegation.deserialize(cbor);
      case CertificateType.stakeVoteRegistrationAndDelegation:
        return StakeVoteRegistrationAndDelegation.deserialize(cbor);
      case CertificateType.committeeHotAuth:
        return CommitteeHotAuth.deserialize(cbor);
      case CertificateType.committeeColdResign:
        return CommitteeColdResign.deserialize(cbor);
      case CertificateType.dRepRegistration:
        return DRepRegistration.deserialize(cbor);
      case CertificateType.dRepDeregistration:
        return DRepDeregistration.deserialize(cbor);
      case CertificateType.dRepUpdate:
        return DRepUpdate.deserialize(cbor);

      default:
        throw UnimplementedError("Invalid certificate type.");
    }
  }

  /// Constructs a certificate instance from its json form.
  factory Certificate.fromJson(Map<String, dynamic> json) {
    final CertificateType type =
        CertificateType.fromName(json.keys.firstOrNull);
    switch (type) {
      case CertificateType.genesisKeyDelegation:
        return GenesisKeyDelegation.fromJson(json);
      case CertificateType.moveInstantaneousRewardsCert:
        return MoveInstantaneousRewardsCert.fromJson(json);
      case CertificateType.poolRegistration:
        return PoolRegistration.fromJson(json);
      case CertificateType.poolRetirement:
        return PoolRetirement.fromJson(json);
      case CertificateType.stakeDelegation:
        return StakeDelegation.fromJson(json);
      case CertificateType.stakeDeregistration:
        return StakeDeregistration.fromJson(json);
      case CertificateType.stakeRegistration:
        return StakeRegistration.fromJson(json);
      case CertificateType.stakeRegistrationConway:
        return StakeRegistrationConway.fromJson(json);
      case CertificateType.stakeDeregistrationConway:
        return StakeDeregistrationConway.fromJson(json);
      case CertificateType.voteDelegation:
        return VoteDelegation.fromJson(json);
      case CertificateType.stakeAndVoteDelegation:
        return StakeAndVoteDelegation.fromJson(json);
      case CertificateType.stakeRegistrationAndDelegation:
        return StakeRegistrationAndDelegation.fromJson(json);
      case CertificateType.voteRegistrationAndDelegation:
        return VoteRegistrationAndDelegation.fromJson(json);
      case CertificateType.stakeVoteRegistrationAndDelegation:
        return StakeVoteRegistrationAndDelegation.fromJson(json);
      case CertificateType.committeeHotAuth:
        return CommitteeHotAuth.fromJson(json);
      case CertificateType.committeeColdResign:
        return CommitteeColdResign.fromJson(json);
      case CertificateType.dRepRegistration:
        return DRepRegistration.fromJson(json);
      case CertificateType.dRepDeregistration:
        return DRepDeregistration.fromJson(json);
      case CertificateType.dRepUpdate:
        return DRepUpdate.fromJson(json);

      default:
        throw UnimplementedError("Invalid certificate type.");
    }
  }

  /// the credential required for signing
  List<Credential> get signersCredential;
  @override
  Map<String, dynamic> toJson();
}
