import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

class StakeRegistrationConway extends Certificate {
  final Credential stakeCredential;
  final BigInt? coin;

  const StakeRegistrationConway({
    required this.stakeCredential,
    this.coin,
  });

  factory StakeRegistrationConway.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.stakeRegistrationConway);
    return StakeRegistrationConway(
        stakeCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        coin: cbor.elementAsInteger(2));
  }
  factory StakeRegistrationConway.fromJson(Map<String, dynamic> json) {
    final currentJson =
        json[CertificateType.stakeRegistrationConway.name] ?? json;
    return StakeRegistrationConway(
        stakeCredential: Credential.fromJson(currentJson['stake_credential']),
        coin: BigintUtils.tryParse(currentJson["coin"]));
  }

  StakeRegistrationConway copyWith(
      {Credential? stakeCredential, BigInt? coin}) {
    return StakeRegistrationConway(
        stakeCredential: stakeCredential ?? this.stakeCredential,
        coin: coin ?? this.coin);
  }

  @override
  CborListValue toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      stakeCredential.toCbor(),
      if (coin != null) CborUnsignedValue.u64(coin)
    ]);
  }

  @override
  CertificateType get type => CertificateType.stakeRegistrationConway;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'stake_credential': stakeCredential.toJson(),
        'coin': coin?.toString()
      }
    };

    /// stake_registration_conway
  }

  @override
  List<Credential> get signersCredential => [stakeCredential];
}
