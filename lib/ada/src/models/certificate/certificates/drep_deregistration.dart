import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/serialization/cbor_serialization.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/certificate.dart';
import 'package:on_chain/ada/src/models/certificate/certificates/types.dart';
import 'package:on_chain/ada/src/models/credential/models/credential.dart';

class DRepDeregistration extends Certificate {
  final Credential votingCredential;
  final BigInt coin;

  const DRepDeregistration(
      {required this.votingCredential, required this.coin});

  factory DRepDeregistration.deserialize(CborListValue cbor) {
    CertificateType.deserialize(cbor.elementAt<CborIntValue>(0),
        validate: CertificateType.dRepDeregistration);
    return DRepDeregistration(
        votingCredential:
            Credential.deserialize(cbor.elementAt<CborListValue>(1)),
        coin: cbor.elementAsInteger(2));
  }
  factory DRepDeregistration.fromJson(Map<String, dynamic> json) {
    final currentJson = json[CertificateType.dRepDeregistration.name] ?? json;
    final coin = currentJson['coin'];
    return DRepDeregistration(
        votingCredential: Credential.fromJson(currentJson['voting_credential']),
        coin: BigintUtils.parse(coin));
  }

  @override
  CborListValue toCbor() {
    return CborListValue.definite([
      type.toCbor(),
      votingCredential.toCbor(),
      CborUnsignedValue.u64(coin)
    ]);
  }

  @override
  CertificateType get type => CertificateType.dRepDeregistration;

  @override
  Map<String, dynamic> toJson() {
    return {
      type.name: {
        'voting_credential': votingCredential.toJson(),
        'coin': coin.toString()
      }
    };
  }

  @override
  List<Credential> get signersCredential => [votingCredential];
}
