import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/core/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/core/types.dart';
import 'package:on_chain/ada/src/models/credential/core/stake_cred.dart';

/// Represents a stake registration certificate with serialization support.
class StakeRegistration extends Certificate {
  /// The stake credential.
  final StakeCred stakeCredential;

  /// Constructs a StakeRegistration object with the specified stake credential.
  const StakeRegistration(this.stakeCredential);

  /// Deserializes a StakeRegistration object from its CBOR representation.
  factory StakeRegistration.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.getIndex(0),
        validate: CertificateType.stakeRegistration);
    return StakeRegistration(StakeCred.deserialize(cbor.getIndex(1)));
  }
  factory StakeRegistration.fromJson(Map<String, dynamic> json) {
    return StakeRegistration(StakeCred.fromJson(json['stake_credential'] ??
        json['stake_registration']['stake_credential']));
  }
  StakeRegistration copyWith({StakeCred? stakeCredential}) {
    return StakeRegistration(stakeCredential ?? this.stakeCredential);
  }

  @override
  CborListValue toCbor() {
    return CborListValue.fixedLength([
      type.toCbor(),
      stakeCredential.toCbor(),
    ]);
  }

  @override
  CertificateType get type => CertificateType.stakeRegistration;

  @override
  Map<String, dynamic> toJson() {
    return {
      'stake_registration': {'stake_credential': stakeCredential.toJson()}
    };
  }
}
