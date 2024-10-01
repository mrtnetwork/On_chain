import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/ethereum/src/keys/public_key.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Class representing an Ethereum private key, allowing for cryptographic operations and key-related functionality.
class ETHPrivateKey {
  /// Private constructor for creating an instance of [ETHPrivateKey] with a given private key.
  const ETHPrivateKey._(this._privateKey);

  /// The underlying ECDSA private key.
  final Secp256k1PrivateKeyEcdsa _privateKey;

  /// Creates an [ETHPrivateKey] instance from a hexadecimal private key string.
  factory ETHPrivateKey(String privateKeyHex) {
    return ETHPrivateKey.fromBytes(BytesUtils.fromHexString(privateKeyHex));
  }

  /// Creates an [ETHPrivateKey] instance from a list of bytes representing the private key.
  factory ETHPrivateKey.fromBytes(List<int> keyBytes) {
    try {
      final Secp256k1PrivateKeyEcdsa key =
          Secp256k1PrivateKeyEcdsa.fromBytes(keyBytes);
      return ETHPrivateKey._(key);
    } catch (e) {
      throw ETHPluginException("invalid ethereum private key",
          details: {"input": BytesUtils.toHexString(keyBytes)});
    }
  }

  /// Retrieves the raw bytes of the private key.
  List<int> toBytes() {
    return _privateKey.raw;
  }

  /// Converts the private key to a hexadecimal string.
  String toHex() {
    return BytesUtils.toHexString(toBytes());
  }

  /// Retrieves the corresponding Ethereum public key.
  ETHPublicKey publicKey() {
    return ETHPublicKey.fromBytes(_privateKey.publicKey.compressed);
  }

  /// Signs a transaction digest using the private key.
  ///
  /// Optionally, [hashMessage] can be set to false to skip hashing the message before signing.
  ETHSignature sign(List<int> transactionDigest, {bool hashMessage = true}) {
    final ethsigner = ETHSigner.fromKeyBytes(toBytes());
    final sign = ethsigner.sign(transactionDigest, hashMessage: hashMessage);
    return sign;
  }

  /// Signs a personal message using the private key and returns the signature as a hexadecimal string.
  ///
  /// Optionally, [payloadLength] can be set to specify the payload length for the message.
  String signPersonalMessage(List<int> message, {int? payloadLength}) {
    final ethsigner = ETHSigner.fromKeyBytes(toBytes());
    final sign =
        ethsigner.signProsonalMessage(message, payloadLength: payloadLength);
    return BytesUtils.toHexString(sign);
  }
}
