import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/models/certificate/certs.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';

/// Represents an abstract certificate with serialization capabilities.
abstract class Certificate with ADASerialization {
  /// Constructs a [Certificate].
  const Certificate();

  /// The type of the certificate.
  abstract final CertificateType type;

  /// Constructs a certificate instance from its serialized form.
  factory Certificate.deserialize(CborListValue cbor) {
    final type = CertificateType.deserialize(cbor.getIndex(0));
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
      default:
        return StakeRegistration.deserialize(cbor);
    }
  }

  /// Constructs a certificate instance from its json form.
  factory Certificate.fromJson(Map<String, dynamic> json) {
    final CertificateType type;
    try {
      type = CertificateType.fromName(json.keys.first);
    } on StateError {
      throw ADAPluginException("Invalid json certificate.",
          details: {"json": json});
    }
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
      default:
        return StakeRegistration.fromJson(json);
    }
  }
}
