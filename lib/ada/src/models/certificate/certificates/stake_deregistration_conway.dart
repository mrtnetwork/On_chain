import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

/// Represents a stake deregistration certificate with serialization support.
class StakeDeregistrationConway extends Certificate {
  final Credential stakeCredential;
  final BigInt? coin;

  const StakeDeregistrationConway(
      {required this.stakeCredential, required this.coin});

  factory StakeDeregistrationConway.deserialize(CborListValue cbor) {
    CertificateType.deserialize(
      cbor.elementAt<CborIntValue>(0),
      validate: CertificateType.stakeDeregistrationConway,
    );
    return StakeDeregistrationConway(
        stakeCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        coin: cbor.elementAsInteger(2));
  }
  factory StakeDeregistrationConway.fromJson(Map<String, dynamic> json) {
    final currentJson =
        json[CertificateType.stakeDeregistrationConway.name] ?? json;
    return StakeDeregistrationConway(
        stakeCredential: Credential.fromJson(currentJson['stake_credential']),
        coin: BigintUtils.tryParse(currentJson["coin"]));
  }
  StakeDeregistrationConway copyWith(
      {Credential? stakeCredential, BigInt? coin}) {
    return StakeDeregistrationConway(
        stakeCredential: stakeCredential ?? this.stakeCredential,
        coin: coin ?? this.coin);
  }

  @override
  CborObject toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      stakeCredential.toCbor(),
      if (coin != null) CborUnsignedValue.u64(coin)
    ]);
  }

  @override
  CertificateType get type => CertificateType.stakeDeregistrationConway;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'stake_credential': stakeCredential.toJson(),
        'coin': coin?.toString()
      }
    };
  }

  @override
  List<Credential> get signersCredential => [stakeCredential];
}
