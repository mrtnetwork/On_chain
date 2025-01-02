import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/core/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/core/types.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred.dart';

/// Represents a stake deregistration certificate with serialization support.
class StakeDeregistration extends Certificate {
  /// The stake credential.
  final StakeCred stakeCredential;

  /// Constructs a StakeDeregistration object with the specified stake credential.
  const StakeDeregistration(this.stakeCredential);

  /// Deserializes a StakeDeregistration object from its CBOR representation.
  factory StakeDeregistration.deserialize(CborListValue cbor) {
    CertificateType.deserialize(
      cbor.getIndex(0),
      validate: CertificateType.stakeDeregistration,
    );
    return StakeDeregistration(StakeCred.deserialize(cbor.getIndex(1)));
  }
  factory StakeDeregistration.fromJson(Map<String, dynamic> json) {
    return StakeDeregistration(StakeCred.fromJson(json['stake_credential'] ??
        json['stake_deregistration']['stake_credential']));
  }
  StakeDeregistration copyWith({StakeCred? stakeCredential}) {
    return StakeDeregistration(stakeCredential ?? this.stakeCredential);
  }

  @override
  CborObject toCbor() {
    return CborListValue.fixedLength([
      type.toCbor(),
      stakeCredential.toCbor(),
    ]);
  }

  @override
  CertificateType get type => CertificateType.stakeDeregistration;

  @override
  Map<String, dynamic> toJson() {
    return {
      'stake_deregistration': {'stake_credential': stakeCredential.toJson()}
    };
  }
}
