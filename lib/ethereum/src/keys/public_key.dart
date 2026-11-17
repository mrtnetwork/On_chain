import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Represents an Ethereum public key for verification and address generation.
class ETHPublicKey {
  /// Creates an instance with the given [publicKey].
  ETHPublicKey(this.publicKey);

  /// The underlying ECDSA public key.
  final Secp256k1PublicKey publicKey;

  /// Creates an instance from public key bytes.
  factory ETHPublicKey.fromBytes(List<int> keyBytes) {
    try {
      final pubKey = Secp256k1PublicKey.fromBytes(keyBytes);
      return ETHPublicKey(pubKey);
    } catch (e) {
      throw BuError(
        DefaultErrorType.badPublicKey,
        'Invalid public key.',
        details: {'input': BytesUtils.toHexString(keyBytes)},
      );
    }
  }

  /// Creates an instance from a hex public key string.
  factory ETHPublicKey.fromHex(String pubHex) {
    return ETHPublicKey.fromBytes(BytesUtils.fromHexString(pubHex));
  }

  /// Returns the public key bytes in the given [mode].
  BuBytes toBytes([CryptoKeyEncoding mode = CryptoKeyEncoding.base]) {
    return publicKey.toBytes(mode: mode);
  }

  /// Returns the public key as a hex string.
  String toHex([CryptoKeyEncoding mode = CryptoKeyEncoding.base]) {
    return toBytes(mode).toHex();
  }

  /// Derives the Ethereum address from this public key.
  ETHAddress toAddress() {
    return ETHAddress.fromPublicKey(toBytes());
  }

  @override
  String toString() {
    return toHex();
  }

  /// Verifies a personal message signature.
  ///
  /// If [hashMessage] is true (default), hashes the message before verification.
  /// Optional [payloadLength] specifies the message payload length.
  bool verifyPersonalMessage(
    List<int> messageDigest,
    List<int> signature, {
    bool hashMessage = true,
    int? payloadLength,
  }) {
    final verifier = ETHVerifier(Secp256k1Verifier(publicKey));
    return verifier.verifyPersonalMessage(
      messageDigest,
      signature,
      hashMessage: hashMessage,
      payloadLength: payloadLength,
    );
  }

  /// Recovers the public key from a personal message signature.
  ///
  /// If [hashMessage] is true (default), hashes the message before recovery.
  /// Optional [payloadLength] specifies the message payload length.
  /// Returns null if recovery fails.
  static ETHPublicKey? getPublicKey(
    List<int> messageDigest,
    List<int> signature, {
    bool hashMessage = true,
    int? payloadLength,
  }) {
    final verifier = ETHVerifier.getPublicKey(
      messageDigest,
      signature,
      hashMessage: hashMessage,
      payloadLength: payloadLength,
    );
    return ETHPublicKey(verifier);
  }
}
