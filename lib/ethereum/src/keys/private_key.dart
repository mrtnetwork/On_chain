import 'package:on_chain/ethereum/src/keys/public_key.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/keys/signer.dart';

/// Represents an Ethereum private key for cryptographic operations.
class ETHPrivateKey with Equality, SecretState implements EthereumSigner {
  /// Creates an instance with the given [privateKey].
  const ETHPrivateKey(this.privateKey);

  /// The underlying ECDSA private key.
  final Secp256k1PrivateKey privateKey;

  /// Creates an instance from a hex private key string.
  factory ETHPrivateKey.fromHex(String privateKeyHex) {
    final bytes = BytesUtils.fromHexString(privateKeyHex);
    try {
      return ETHPrivateKey.fromBytes(BytesUtils.fromHexString(privateKeyHex));
    } finally {
      bytes.zero();
    }
  }

  /// Creates an instance from private key bytes.
  factory ETHPrivateKey.fromBytes(List<int> keyBytes) {
    try {
      final Secp256k1PrivateKey key = Secp256k1PrivateKey.fromBytes(keyBytes);
      return ETHPrivateKey(key);
    } catch (e) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid Ethereum private key.',
        details: {'input': BytesUtils.toHexString(keyBytes)},
      );
    }
  }

  /// Returns the raw private key bytes.
  SecretBytes toBytes() {
    return privateKey.toBytes();
  }

  /// Returns the private key as a hex string.
  String toHex() {
    return privateKey.takeSecretKey().toHex();
  }

  /// Returns the corresponding public key.
  ETHPublicKey publicKey() {
    return ETHPublicKey(privateKey.publicKey);
  }

  /// Signs a message digest.
  ///
  /// If [hashMessage] is true (default), hashes the message before signing.
  IECDSASignature sign(List<int> message, {bool hashMessage = true}) {
    final ethsigner = ETHSigner(Secp256k1Signer(privateKey));
    final sign = ethsigner.sign(message, hashMessage: hashMessage);
    return sign.signature;
  }

  /// Signs a personal message and returns the signature as bytes.
  ///
  /// Optional [payloadLength] specifies the message payload length.
  BuBytes signPersonalMessage(List<int> message, {int? payloadLength}) {
    final ethsigner = ETHSigner(Secp256k1Signer(privateKey));
    final sign = ethsigner.signPersonalMessage(
      message,
      payloadLength: payloadLength,
    );
    return sign.encoded;
  }

  /// Asynchronously signs a message digest.
  ///
  /// If [hashMessage] is true (default), hashes the message before signing.
  @override
  Future<IECDSASignature> signAsync(
    List<int> message, {
    bool hashMessage = true,
  }) async {
    return sign(message, hashMessage: hashMessage);
  }

  /// Asynchronously signs a personal message.
  ///
  /// Optional [payloadLength] specifies the message payload length.
  @override
  Future<BuBytes> signPersonalMessageAsync(
    List<int> message, {
    int? payloadLength,
  }) async {
    return signPersonalMessage(message, payloadLength: payloadLength);
  }

  @override
  List<dynamic> get variables => [privateKey];

  @override
  void dispose() {
    privateKey.dispose();
  }
}
