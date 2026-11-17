import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';

/// Class representing a public key in the Solana blockchain.
class SolanaPublicKey {
  /// Private constructor to prevent direct instantiation.
  const SolanaPublicKey(this.publicKey);

  /// Private field holding the Ed25519 public key.
  final ED25519PublicKey publicKey;

  /// Factory method to create a SolanaPublicKey instance from bytes.
  factory SolanaPublicKey.fromBytes(List<int> publicKeyBytes) {
    final publicKey = ED25519PublicKey.fromBytes(publicKeyBytes);
    return SolanaPublicKey(publicKey);
  }

  /// Convert the public key to bytes.
  List<int> toBytes32() {
    return publicKey.toBytes();
  }

  /// Derive the Solana address associated with the public key.
  SolAddress toAddress() {
    return SolAddress.fromPublicKey(toBytes32());
  }

  /// Verify a message using the public key and signature.
  bool verify({required List<int> message, required List<int> signature}) {
    // Create a verifier from the public key bytes.
    final ED25519Verifier verifier = ED25519Verifier(publicKey);
    // Verify the message and signature using the verifier.
    return verifier.verify(message, ED25519Signature.fromBytes(signature));
  }
}
