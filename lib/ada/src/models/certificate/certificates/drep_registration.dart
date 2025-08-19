import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/governance/models/anchor.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

class DRepRegistration extends Certificate {
  final Credential votingCredential;
  final BigInt coin;
  final Anchor? anchor;

  const DRepRegistration(
      {required this.votingCredential, required this.coin, this.anchor});

  factory DRepRegistration.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.dRepRegistration);
    return DRepRegistration(
        votingCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        coin: cbor.elementAsInteger(2),
        anchor: cbor
            .elementAt<CborListValue?>(3)
            ?.convertTo<Anchor, CborListValue>((e) => Anchor.deserialize(e)));
  }
  factory DRepRegistration.fromJson(Map<String, dynamic> json) {
    final currentJson = json[CertificateType.dRepRegistration.name] ?? json;
    final anchor = currentJson['anchor'];
    return DRepRegistration(
        votingCredential: Credential.fromJson(currentJson['voting_credential']),
        coin: BigintUtils.parse(currentJson["coin"]),
        anchor: anchor == null ? null : Anchor.fromJson(anchor));
  }

  @override
  CborListValue toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      votingCredential.toCbor(),
      CborUnsignedValue.u64(coin),
      anchor?.toCbor() ?? const CborNullValue(),
    ]);
  }

  @override
  CertificateType get type => CertificateType.dRepRegistration;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'voting_credential': votingCredential.toJson(),
        'coin': coin.toString(),
        'anchor': anchor?.toJson()
      }
    };
  }

  @override
  List<Credential> get signersCredential => [votingCredential];
}
