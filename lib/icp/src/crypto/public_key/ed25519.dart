import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/crypto/public_key/public_key.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

class ICPEd25519PublicKey extends ICPPublicKey {
  final ED25519PublicKey publicKey;

  const ICPEd25519PublicKey(this.publicKey) : super(type: ICPKeyType.ed25519);

  factory ICPEd25519PublicKey.fromBytes(List<int> bytes) =>
      ICPEd25519PublicKey(ED25519PublicKey.fromBytes(bytes));
  factory ICPEd25519PublicKey.froDer(List<int> bytes) =>
      ICPEd25519PublicKey(ED25519PublicKey.fromDer(bytes));

  @override
  BuBytes toBytes() {
    return publicKey.toBytes();
  }

  @override
  bool verifySignature(List<int> message, List<int> signature) {
    final verifier = ED25519Verifier(publicKey);
    return verifier.verify(message, ED25519Signature.fromBytes(signature));
  }

  @override
  List<dynamic> get variables => [publicKey];

  @override
  BuBytes toDer() {
    return publicKey.toDer();
  }
}
