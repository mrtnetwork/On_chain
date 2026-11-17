import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/crypto/public_key/public_key.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

/// Ed25519-bip32 (Khovratovich) public key for ICP.
///
/// The 32-byte point A = kL·B verifies with standard ed25519 verification,
/// so node/user signatures verify exactly like plain ed25519 keys.
class ICPEd25519KholawPublicKey extends ICPPublicKey {
  final ED25519KholawPublicKey publicKey;

  const ICPEd25519KholawPublicKey(this.publicKey)
    : super(type: ICPKeyType.ed25519Kholaw);

  factory ICPEd25519KholawPublicKey.fromBytes(List<int> bytes) =>
      ICPEd25519KholawPublicKey(ED25519KholawPublicKey.fromBytes(bytes));

  @override
  BuBytes toBytes() {
    return publicKey.toBytes();
  }

  @override
  bool verifySignature(List<int> message, List<int> signature) {
    final verifier = ED25519Verifier(
      ED25519PublicKey.fromBytes(publicKey.toBytes()),
    );
    return verifier.verify(message, ED25519Signature.fromBytes(signature));
  }

  @override
  List<dynamic> get variables => [publicKey];

  @override
  BuBytes toDer() {
    return DerCodec.encodeEd25519PublicKeySpki(publicKey.toBytes());
  }
}
