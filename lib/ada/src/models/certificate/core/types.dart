import 'package:blockchain_utils/cbor/cbor.dart';

import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Represents the type of a certificate.
class CertificateType with ADASerialization {
  /// The name of the certificate type.
  final String name;

  /// The value of the certificate type.
  final int value;

  /// Constructs a [CertificateType].
  const CertificateType._(this.name, this.value);

  /// Certificate type for stake registration.
  static const CertificateType stakeRegistration =
      CertificateType._("stake_registration", 0);

  /// Certificate type for stake deregistration.
  static const CertificateType stakeDeregistration =
      CertificateType._("stake_deregistration", 1);

  /// Certificate type for stake delegation.
  static const CertificateType stakeDelegation =
      CertificateType._("stake_delegation", 2);

  /// Certificate type for pool registration.
  static const CertificateType poolRegistration =
      CertificateType._("pool_registration", 3);

  /// Certificate type for pool retirement.
  static const CertificateType poolRetirement =
      CertificateType._("pool_retirement", 4);

  /// Certificate type for genesis key delegation.
  static const CertificateType genesisKeyDelegation =
      CertificateType._("genesis_key_delegation", 5);

  /// Certificate type for moving instantaneous rewards.
  static const CertificateType moveInstantaneousRewardsCert =
      CertificateType._("move_instantaneous_rewards_cert", 6);

  /// List of all certificate types.
  static const List<CertificateType> values = [
    stakeRegistration,
    stakeDeregistration,
    stakeDelegation,
    poolRegistration,
    poolRetirement,
    genesisKeyDelegation,
    moveInstantaneousRewardsCert
  ];

  /// Constructs a [CertificateType] from a serialized value.
  factory CertificateType.deserialize(CborIntValue cbor,
      {CertificateType? validate}) {
    final type = fromValue(cbor.value);
    if (validate != null && type != validate) {
      throw ADAPluginException("Invalid Certificate type.",
          details: {"Excepted": validate, "Type": type});
    }
    return type;
  }

  /// Retrieves a [CertificateType] based on its value.
  static CertificateType fromValue(int? value) {
    return values.firstWhere(
      (element) => element.value == value,
      orElse: () => throw ADAPluginException(
          "No CertificateType found matching the specified value",
          details: {"value": value}),
    );
  }

  /// Retrieves a [CertificateType] based on its name.
  static CertificateType fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ADAPluginException(
          "No CertificateType found matching the specified name",
          details: {"name": name}),
    );
  }

  @override
  CborObject toCbor() {
    return CborIntValue(value);
  }

  @override
  String toString() {
    return "CertificateTypes.$name";
  }

  @override
  String toJson() {
    return name;
  }
}
