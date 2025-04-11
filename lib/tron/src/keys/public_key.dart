import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/address/tron_address.dart';
import 'package:on_chain/tron/src/exception/exception.dart';

/// Class representing a Tron public key
class TronPublicKey {
  /// Private constructor for internal use, initializing with a Secp256k1 public key
  const TronPublicKey._(this._publicKey);

  /// Private field to store the Secp256k1 public key
  final Secp256k1PublicKeyEcdsa _publicKey;

  /// Factory method to create a TronPublicKey from a list of key bytes
  factory TronPublicKey.fromBytes(List<int> keyBytes) {
    try {
      final pubKey = Secp256k1PublicKeyEcdsa.fromBytes(keyBytes);
      return TronPublicKey._(pubKey);
    } catch (e) {
      throw TronPluginException('invalid tron public key',
          details: {'input': BytesUtils.toHexString(keyBytes)});
    }
  }

  /// Factory method to create a TronPublicKey from a hexadecimal public key string
  factory TronPublicKey(String pubHex) {
    return TronPublicKey.fromBytes(BytesUtils.fromHexString(pubHex));
  }

  /// Method to convert the public key to a list of bytes
  List<int> toBytes([PubKeyModes mode = PubKeyModes.compressed]) {
    if (mode == PubKeyModes.uncompressed) {
      return _publicKey.uncompressed;
    }
    return _publicKey.compressed;
  }

  /// Method to convert the public key to a hexadecimal string
  String toHex({PubKeyModes mode = PubKeyModes.compressed}) {
    return BytesUtils.toHexString(toBytes(mode));
  }

  /// Method to obtain the corresponding Tron address from the public key
  TronAddress toAddress() {
    return TronAddress.fromPublicKey(toBytes());
  }

  /// Verifies the signature of a personal message using the public key.
  ///
  /// Optionally, [hashMessage] can be set to false to skip hashing the message before verification.
  /// Optionally, [payloadLength] can be set to specify the payload length for the message.
  bool verifyPersonalMessage(List<int> messageDigest, String signature,
      {bool hashMessage = true,
      int? payloadLength,
      bool useEthereumPrefix = false}) {
    final verifier = TronVerifier.fromKeyBytes(toBytes());
    return verifier.verifyPersonalMessage(
        messageDigest, BytesUtils.fromHexString(signature),
        hashMessage: hashMessage,
        payloadLength: payloadLength,
        useEthPrefix: useEthereumPrefix);
  }

  static TronPublicKey fromPersonalSignature(
      List<int> messageDigest, String signature,
      {bool hashMessage = true,
      int? payloadLength,
      bool useEthereumPrefix = false}) {
    final publicKey = TronVerifier.getPublicKey(
        messageDigest, BytesUtils.fromHexString(signature),
        hashMessage: hashMessage,
        payloadLength: payloadLength,
        useEthPrefix: useEthereumPrefix);
    final pubKey = Secp256k1PublicKeyEcdsa.fromBytes(publicKey.point.toBytes());
    return TronPublicKey._(pubKey);
  }

  /// Override of the toString method to return the hexadecimal representation of the public key
  @override
  String toString() {
    return toHex();
  }
}
