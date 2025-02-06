import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';

/// Class representing a public key in the Solana blockchain.
class SolanaPublicKey {
  /// Private constructor to prevent direct instantiation.
  const SolanaPublicKey._(this._ed25519publicKey);

  /// Private field holding the Ed25519 public key.
  final Ed25519PublicKey _ed25519publicKey;

  /// Factory method to create a SolanaPublicKey instance from bytes.
  factory SolanaPublicKey.fromBytes(List<int> publicKeyBytes) {
    final publicKey = Ed25519PublicKey.fromBytes(publicKeyBytes);
    return SolanaPublicKey._(publicKey);
  }

  /// Convert the public key to bytes.
  List<int> toBytes([bool prefix = true]) {
    // If prefix is false, return compressed key without prefix.
    if (!prefix) return _ed25519publicKey.compressed.sublist(1);
    // Otherwise, return compressed key with prefix.
    return _ed25519publicKey.compressed;
  }

  /// Derive the Solana address associated with the public key.
  SolAddress toAddress() {
    return SolAddress.fromPublicKey(toBytes());
  }

  /// Verify a message using the public key and signature.
  bool verify({required List<int> message, required List<int> signature}) {
    // Create a verifier from the public key bytes.
    final Ed25519Verifier verifier = Ed25519Verifier.fromKeyBytes(toBytes());
    // Verify the message and signature using the verifier.
    return verifier.verify(message, signature);
  }
}
