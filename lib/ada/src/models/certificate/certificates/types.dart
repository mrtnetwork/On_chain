import 'package:blockchain_utils/cbor/cbor.dart';

import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';

/// Represents the type of a certificate.
class CertificateType with InternalCborSerialization {
  /// The name of the certificate type.
  final String name;

  /// The value of the certificate type.
  final int value;

  /// Constructs a [CertificateType].
  const CertificateType._(this.name, this.value);

  /// Certificate type for stake registration.
  static const CertificateType stakeRegistration =
      CertificateType._('StakeRegistration', 0);

  /// Certificate type for stake deregistration.
  static const CertificateType stakeDeregistration =
      CertificateType._('StakeDeregistration', 1);

  /// Certificate type for stake delegation.
  static const CertificateType stakeDelegation =
      CertificateType._('StakeDelegation', 2);

  /// Certificate type for pool registration.
  static const CertificateType poolRegistration =
      CertificateType._('PoolRegistration', 3);

  /// Certificate type for pool retirement.
  static const CertificateType poolRetirement =
      CertificateType._('PoolRetirement', 4);

  /// Certificate type for genesis key delegation.
  static const CertificateType genesisKeyDelegation =
      CertificateType._('GenesisKeyDelegation', 5);

  /// Certificate type for moving instantaneous rewards.
  static const CertificateType moveInstantaneousRewardsCert =
      CertificateType._('MoveInstantaneousRewardsCert', 6);

  /// Conway: Stake registration certificate.
  static const CertificateType stakeRegistrationConway =
      CertificateType._('StakeRegistrationConway', 7);

  /// Conway: Stake deregistration certificate.
  static const CertificateType stakeDeregistrationConway =
      CertificateType._('StakeDeregistrationConway', 8);

  /// Conway: Vote delegation certificate.
  static const CertificateType voteDelegation =
      CertificateType._('VoteDelegation', 9);

  /// Conway: Stake and vote delegation certificate.
  static const CertificateType stakeAndVoteDelegation =
      CertificateType._('StakeAndVoteDelegation', 10);

  /// Conway: Stake registration and delegation certificate.
  static const CertificateType stakeRegistrationAndDelegation =
      CertificateType._('StakeRegistrationAndDelegation', 11);

  /// Conway: Vote registration and delegation certificate.
  static const CertificateType voteRegistrationAndDelegation =
      CertificateType._('VoteRegistrationAndDelegation', 12);

  /// Conway: Stake vote registration and delegation certificate.
  static const CertificateType stakeVoteRegistrationAndDelegation =
      CertificateType._('StakeVoteRegistrationAndDelegation', 13);

  /// Conway: Committee hot key authorization certificate.
  static const CertificateType committeeHotAuth =
      CertificateType._('CommitteeHotAuth', 14);

  /// Conway: Committee cold key resignation certificate.
  static const CertificateType committeeColdResign =
      CertificateType._('CommitteeColdResign', 15);

  /// Conway: DRep (Delegate Representative) registration certificate.
  static const CertificateType dRepRegistration =
      CertificateType._('DRepRegistration', 16);

  /// Conway: DRep deregistration certificate.
  static const CertificateType dRepDeregistration =
      CertificateType._('DRepDeregistration', 17);

  /// Conway: DRep update certificate.
  static const CertificateType dRepUpdate = CertificateType._('DRepUpdate', 18);

  /// List of all certificate types.
  static const List<CertificateType> values = [
    stakeRegistration,
    stakeDeregistration,
    stakeDelegation,
    poolRegistration,
    poolRetirement,
    genesisKeyDelegation,
    moveInstantaneousRewardsCert,
    stakeRegistrationConway,
    stakeDeregistrationConway,
    voteDelegation,
    stakeAndVoteDelegation,
    stakeRegistrationAndDelegation,
    voteRegistrationAndDelegation,
    stakeVoteRegistrationAndDelegation,
    committeeHotAuth,
    committeeColdResign,
    dRepRegistration,
    dRepDeregistration,
    dRepUpdate,
  ];

  /// Constructs a [CertificateType] from a serialized value.
  factory CertificateType.deserialize(CborIntValue cbor,
      {CertificateType? validate}) {
    final type = fromValue(cbor.value);
    if (validate != null && type != validate) {
      throw ADAPluginException('Invalid Certificate type.',
          details: {'expected': validate, 'Type': type});
    }
    return type;
  }

  /// Retrieves a [CertificateType] based on its value.
  static CertificateType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          'No CertificateType found matching the specified value',
          details: {'value': value}),
    );
  }

  /// Retrieves a [CertificateType] based on its name.
  static CertificateType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          'No CertificateType found matching the specified name',
          details: {'name': name}),
    );
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  @override
  String toString() {
    return 'CertificateTypes.$name';
  }

  @override
  String toJson() {
    return name;
  }
}
