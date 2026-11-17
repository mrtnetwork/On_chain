import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/icp/src/crypto/public_key/ed25519_kholaw.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

/// Ed25519-bip32 (Khovratovich) secret key for ICP.
///
/// Holds the 64-byte extended key (kL ‖ kR); signing uses the ed25519-bip32
/// algorithm whose output verifies under standard ed25519 verification
/// against A = kL·B, which is what the IC replica checks.
class ICPEd25519KholawSecretKey
    extends ICPSecretKey<ICPEd25519KholawPublicKey> {
  final ED25519KholawPrivateKey privateKey;

  const ICPEd25519KholawSecretKey(this.privateKey)
    : super(type: ICPKeyType.ed25519Kholaw);

  factory ICPEd25519KholawSecretKey.fromBytes(List<int> bytes) =>
      ICPEd25519KholawSecretKey(ED25519KholawPrivateKey.fromBytes(bytes));

  @override
  ICPEd25519KholawPublicKey toPublicKey() =>
      ICPEd25519KholawPublicKey(privateKey.verificationKey());

  @override
  BuBytes sign(List<int> message) {
    final signer = ED25519Signer(privateKey);
    return signer.sign(message).encoded;
  }

  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  void dispose() {
    privateKey.dispose();
  }

  @override
  List<dynamic> get variables => [privateKey];
}
