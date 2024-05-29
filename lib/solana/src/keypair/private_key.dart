import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/keypair/public_key.dart';

/// Class representing a private key for Solana.
class SolanaPrivateKey {
  /// Private constructor to prevent direct instantiation.
  SolanaPrivateKey._(this._privateKey);

  /// Private field holding the Ed25519 private key.
  final Ed25519PrivateKey _privateKey;

  /// Factory method to create a SolanaPrivateKey instance from a seed represented as a list of bytes.
  factory SolanaPrivateKey.fromSeed(List<int> keyBytes) {
    final privateKey = Ed25519PrivateKey.fromBytes(keyBytes);
    return SolanaPrivateKey._(privateKey);
  }

  /// Factory method to create a SolanaPrivateKey instance from a seed represented as a hexadecimal string.
  factory SolanaPrivateKey.fromSeedHex(String seedHex) {
    final privateKey =
        Ed25519PrivateKey.fromBytes(BytesUtils.fromHexString(seedHex));
    return SolanaPrivateKey._(privateKey);
  }

  /// Factory method to create a SolanaPrivateKey instance from bytes representing a keypair.
  factory SolanaPrivateKey.fromBytes(List<int> keypairBytes) {
    // Check if the byte length matches the expected length of a Solana keypair.
    if (keypairBytes.length !=
        (Ed25519KeysConst.privKeyByteLen + Ed25519KeysConst.pubKeyByteLen)) {
      throw MessageException(
          "Invalid Solana keypair length. A valid keypair must consist of exactly 64 bytes, combining both the seed and public key components.",
          details: {"length": keypairBytes.length});
    }
    // Extract seed bytes and public bytes from the keypair bytes.
    final seedBytes = keypairBytes.sublist(0, Ed25519KeysConst.privKeyByteLen);
    final publicBytes = keypairBytes.sublist(Ed25519KeysConst.privKeyByteLen);
    // Create a private key from the seed bytes.
    final privateKey = Ed25519PrivateKey.fromBytes(seedBytes);
    // Check if the extracted public bytes match the public key derived from the private key.
    if (!bytesEqual(
        privateKey.publicKey.compressed
            .sublist(Ed25519KeysConst.pubKeyPrefix.length),
        publicBytes)) {
      throw const MessageException("Invalid keypair");
    }
    return SolanaPrivateKey._(privateKey);
  }

  /// Retrieve the seed bytes of the private key.
  List<int> seedBytes() {
    return _privateKey.raw;
  }

  /// Convert the seed bytes of the private key to a hexadecimal string.
  String seedHex() {
    return BytesUtils.toHexString(seedBytes());
  }

  /// Retrieve the keypair bytes representing both the seed and public key.
  List<int> keypairBytes() {
    return [
      ..._privateKey.raw,
      ..._privateKey.publicKey.compressed
          .sublist(Ed25519KeysConst.pubKeyPrefix.length)
    ];
  }

  /// Convert the keypair bytes to a hexadecimal string.
  String toHex() {
    return BytesUtils.toHexString(keypairBytes());
  }

  /// Derive the public key associated with the private key.
  SolanaPublicKey publicKey() {
    return SolanaPublicKey.fromBytes(_privateKey.publicKey.compressed);
  }

  /// Sign a digest using the private key.
  List<int> sign(List<int> digest) {
    final signer = SolanaSigner.fromKeyBytes(_privateKey.raw);
    return signer.sign(digest);
  }
}
