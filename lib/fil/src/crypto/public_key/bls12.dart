import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/crypto/public_key/public_key.dart';
import 'package:on_chain/fil/src/crypto/types/types.dart';

class FilBls12PublicKey extends FilecoinPublicKey {
  final Bls12G1PublicKey publicKey;

  const FilBls12PublicKey(this.publicKey) : super(type: FilecoinKeyType.bls12);

  factory FilBls12PublicKey.fromBytes(List<int> bytes) =>
      FilBls12PublicKey(Bls12G1PublicKey.fromBytes(bytes));

  @override
  BuBytes toBytes() {
    return publicKey.toBytes();
  }

  @override
  bool verifySignature(List<int> message, List<int> signature) {
    return publicKey.verify(
      Bls12G1VerifiyingParams(
        signature: Bls12G1Signature.fromBytes(signature),
        signingParams: Bls12SigningParams(message: message),
      ),
    );
  }

  @override
  List<dynamic> get variables => [publicKey];
}
