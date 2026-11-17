import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/keypair/public_key.dart';

/// Class representing a private key for Solana.
class SolanaPrivateKey with SecretState {
  /// Private constructor to prevent direct instantiation.
  SolanaPrivateKey(this.privateKey);

  /// Private field holding the Ed25519 private key.
  final ED25519PrivateKey privateKey;

  /// Factory method to create a SolanaPrivateKey instance from a seed represented as a hexadecimal string.
  factory SolanaPrivateKey.fromSeedHex(String seedHex) {
    final privateKey = ED25519PrivateKey.fromBytes(
      BytesUtils.fromHexString(seedHex),
    );
    return SolanaPrivateKey(privateKey);
  }

  /// Factory method to create a SolanaPrivateKey instance from a keypair encoded as base58(PrivateKey,PublicKey).
  factory SolanaPrivateKey.fromBase58(String b58KeyPair) {
    final keypairBytes = Base58Decoder.decode(b58KeyPair);
    return SolanaPrivateKey.fromBytes(keypairBytes);
  }

  /// Factory method to create a SolanaPrivateKey instance from bytes representing a keypair.
  factory SolanaPrivateKey.fromBytes(List<int> keypairBytes) {
    final privateKey = ED25519PrivateKey.fromBytes(keypairBytes);
    return SolanaPrivateKey(privateKey);
  }

  /// Retrieve the seed bytes of the private key.
  SecretBytes seedBytes() {
    return privateKey.toBytes();
  }

  /// Convert the seed bytes of the private key to a hexadecimal string.
  String seedHex() {
    return privateKey.takeSecretKey().toHex();
  }

  /// encode keypair to base58(PrivateKey,PublicKey)
  String toBase58() {
    return privateKey.toExpandedBytes().useValue(
      (k) => Base58Encoder.encode(k),
      zero: true,
    );
  }

  /// Retrieve the keypair bytes representing both the seed and public key.
  SecretBytes keypairBytes() {
    return privateKey.toExpandedBytes();
  }

  /// Convert the keypair bytes to a hexadecimal string.
  String toHex() {
    return keypairBytes().useValue(
      (k) => BytesUtils.toHexString(k),
      zero: true,
    );
  }

  /// Derive the public key associated with the private key.
  SolanaPublicKey publicKey() {
    return SolanaPublicKey(privateKey.publicKey);
  }

  /// Sign a digest using the private key.
  BuBytes sign(List<int> digest) {
    final signer = ED25519Signer(privateKey);
    return signer.sign(digest).encoded;
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}
