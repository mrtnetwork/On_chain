import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';

/// Represents a Tron public key.
class TronPublicKey {
  /// Creates a [TronPublicKey] from a Secp256k1 public key.
  const TronPublicKey(this.publicKey);

  /// The underlying Secp256k1 public key.
  final Secp256k1PublicKey publicKey;

  /// Creates a [TronPublicKey] from raw key bytes.
  factory TronPublicKey.fromBytes(List<int> keyBytes) {
    try {
      final pubKey = Secp256k1PublicKey.fromBytes(keyBytes);
      return TronPublicKey(pubKey);
    } catch (e) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid Tron public key.',
        details: {'input': BytesUtils.toHexString(keyBytes)},
      );
    }
  }

  /// Creates a [TronPublicKey] from a hex string.
  factory TronPublicKey.fromHex(String pubHex) {
    return TronPublicKey.fromBytes(BytesUtils.fromHexString(pubHex));
  }

  /// Converts the public key to raw bytes.
  BuBytes toBytes([CryptoKeyEncoding mode = CryptoKeyEncoding.base]) {
    return publicKey.toBytes(mode: mode);
  }

  /// Converts the public key to a hex string.
  String toHex({CryptoKeyEncoding mode = CryptoKeyEncoding.base}) {
    return toBytes(mode).toHex();
  }

  /// Returns the corresponding Tron address.
  TronAddress toAddress() {
    return TronAddress.fromPublicKey(toBytes());
  }

  /// Verifies the signature of a personal message using the public key.
  ///
  /// Optionally, [hashMessage] can be set to false to skip hashing the message before verification.
  /// Optionally, [payloadLength] can be set to specify the payload length for the message.
  bool verifyPersonalMessage(
    List<int> messageDigest,
    String signature, {
    bool hashMessage = true,
    int? payloadLength,
    bool useEthereumPrefix = false,
  }) {
    final verifier = TronVerifier(Secp256k1Verifier(publicKey));
    return verifier.verifyPersonalMessage(
      messageDigest,
      BytesUtils.fromHexString(signature),
      hashMessage: hashMessage,
      payloadLength: payloadLength,
      useEthPrefix: useEthereumPrefix,
    );
  }

  /// Recovers the public key from a personal-message signature.
  static TronPublicKey fromPersonalSignature(
    List<int> messageDigest,
    String signature, {
    bool hashMessage = true,
    int? payloadLength,
    bool useEthereumPrefix = false,
  }) {
    final publicKey = TronVerifier.getPublicKey(
      messageDigest,
      BytesUtils.fromHexString(signature),
      hashMessage: hashMessage,
      payloadLength: payloadLength,
      useEthPrefix: useEthereumPrefix,
    );
    return TronPublicKey(publicKey);
  }

  /// Returns the hex representation of the public key.
  @override
  String toString() {
    return toHex();
  }
}
