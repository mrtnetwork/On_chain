import 'package:blockchain_utils/blockchain_utils.dart';

import 'public_key.dart';

/// Represents a Tron private key.
class TronPrivateKey with SecretState {
  /// Creates a [TronPrivateKey] from a Secp256k1 private key.
  const TronPrivateKey(this.privateKey);

  /// The underlying Secp256k1 private key.
  final Secp256k1PrivateKey privateKey;

  /// Creates a [TronPrivateKey] from a hex string.
  factory TronPrivateKey.fromHex(String privateKeyHex) {
    final bytes = BytesUtils.fromHexString(privateKeyHex);
    try {
      return TronPrivateKey.fromBytes(bytes);
    } finally {
      bytes.zero();
    }
  }

  /// Creates a [TronPrivateKey] from raw key bytes.
  factory TronPrivateKey.fromBytes(List<int> keyBytes) {
    try {
      final Secp256k1PrivateKey key = Secp256k1PrivateKey.fromBytes(keyBytes);
      return TronPrivateKey(key);
    } catch (e) {
      // Throws a TronPluginException if the key bytes are invalid.
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid Tron private key.',
        details: {'input': BytesUtils.toHexString(keyBytes)},
      );
    }
  }

  /// Converts the private key to raw bytes.
  SecretBytes toBytes() {
    return privateKey.toBytes();
  }

  /// Converts the private key to a hex string.
  String toHex() {
    return privateKey.takeSecretKey().toHex();
  }

  /// Returns the corresponding Tron public key.
  TronPublicKey publicKey() {
    return TronPublicKey(privateKey.publicKey);
  }

  /// Signs a transaction digest.
  BuBytes sign(List<int> transactionDigest) {
    final signer = TronSigner(Secp256k1Signer(privateKey));
    return signer.sign(transactionDigest).encoded;
  }

  /// Signs a personal message using the private key and returns the signature as a hexadecimal string.
  ///
  /// Optionally, [payloadLength] can be set to specify the payload length for the message.
  String signPersonalMessage(
    List<int> message, {
    int? payloadLength,
    bool useEthereumPrefix = false,
  }) {
    final signer = TronSigner(Secp256k1Signer(privateKey));
    final sign = signer.signPersonalMessage(
      message,
      payloadLength: payloadLength,
      useEthPrefix: useEthereumPrefix,
    );
    return sign.encoded.toHex();
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}
