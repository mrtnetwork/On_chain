import 'package:on_chain/ethereum/src/exception/exception.dart';
import 'package:on_chain/ethereum/src/keys/public_key.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/keys/signer.dart';

/// Class representing an Ethereum private key, allowing for cryptographic operations and key-related functionality.
class ETHPrivateKey with Equality implements EthereumSigner {
  /// Private constructor for creating an instance of [ETHPrivateKey] with a given private key.
  const ETHPrivateKey._(this._privateKey);

  /// The underlying ECDSA private key.
  final Secp256k1PrivateKey _privateKey;

  /// Creates an [ETHPrivateKey] instance from a hexadecimal private key string.
  factory ETHPrivateKey(String privateKeyHex) {
    return ETHPrivateKey.fromBytes(BytesUtils.fromHexString(privateKeyHex));
  }

  /// Creates an [ETHPrivateKey] instance from a list of bytes representing the private key.
  factory ETHPrivateKey.fromBytes(List<int> keyBytes) {
    try {
      final Secp256k1PrivateKey key = Secp256k1PrivateKey.fromBytes(keyBytes);
      return ETHPrivateKey._(key);
    } catch (e) {
      throw ETHPluginException('invalid ethereum private key',
          details: {'input': BytesUtils.toHexString(keyBytes)});
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
  ETHSignature sign(List<int> message, {bool hashMessage = true}) {
    final ethsigner = ETHSigner.fromKeyBytes(toBytes());
    final sign = ethsigner.signConst(message, hashMessage: hashMessage);
    return sign;
  }

  /// Signs a personal message using the private key and returns the signature as a hexadecimal string.
  ///
  /// Optionally, [payloadLength] can be set to specify the payload length for the message.
  List<int> signPersonalMessage(List<int> message, {int? payloadLength}) {
    final ethsigner = ETHSigner.fromKeyBytes(toBytes());
    final sign = ethsigner.signProsonalMessageConst(message,
        payloadLength: payloadLength);
    return sign;
  }

  /// Signs a transaction digest using the private key.
  ///
  /// Optionally, [hashMessage] can be set to false to skip hashing the message before signing.
  @override
  Future<ETHSignature> signAsync(List<int> message,
      {bool hashMessage = true}) async {
    return sign(message, hashMessage: hashMessage);
  }

  /// Signs a personal message using the private key and returns the signature as a hexadecimal string.
  ///
  /// Optionally, [payloadLength] can be set to specify the payload length for the message.
  @override
  Future<List<int>> signPersonalMessageAsync(List<int> message,
      {int? payloadLength}) async {
    return signPersonalMessage(message, payloadLength: payloadLength);
  }

  @override
  List<dynamic> get variables => [_privateKey];
}
