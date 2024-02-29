import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:blockchain_utils/bip/address/p2pkh_addr.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

/// Class representing an Ethereum public key, providing methods for conversion, verification, and address generation.
class ETHPublicKey {
  /// Private constructor for creating an instance of [ETHPublicKey] with a given public key.
  ETHPublicKey._(this._publicKey);

  /// The underlying ECDSA public key.
  final Secp256k1PublicKeyEcdsa _publicKey;

  /// Creates an [ETHPublicKey] instance from a list of bytes representing the public key.
  factory ETHPublicKey.fromBytes(List<int> keyBytes) {
    try {
      final pubKey = Secp256k1PublicKeyEcdsa.fromBytes(keyBytes);
      return ETHPublicKey._(pubKey);
    } catch (e) {
      throw MessageException("invalid public key",
          details: {"input": BytesUtils.toHexString(keyBytes)});
    }
  }

  /// Creates an [ETHPublicKey] instance from a hexadecimal public key string.
  factory ETHPublicKey(String pubHex) {
    return ETHPublicKey.fromBytes(BytesUtils.fromHexString(pubHex));
  }

  /// Retrieves the raw bytes of the public key.
  List<int> toBytes([PubKeyModes mode = PubKeyModes.compressed]) {
    if (mode == PubKeyModes.uncompressed) {
      return _publicKey.uncompressed;
    }
    return _publicKey.compressed;
  }

  /// Converts the public key to a hexadecimal string.
  String toHex([PubKeyModes mode = PubKeyModes.compressed]) {
    return BytesUtils.toHexString(toBytes(mode));
  }

  /// Converts the public key to an Ethereum address.
  ETHAddress toAddress() {
    return ETHAddress.fromPublicKey(toBytes());
  }

  @override
  String toString() {
    return toHex();
  }

  /// Verifies the signature of a personal message using the public key.
  ///
  /// Optionally, [hashMessage] can be set to false to skip hashing the message before verification.
  /// Optionally, [payloadLength] can be set to specify the payload length for the message.
  bool verifyPersonalMessage(List<int> messageDigest, List<int> signature,
      {bool hashMessage = true, int? payloadLength}) {
    final verifier = ETHVerifier.fromKeyBytes(toBytes());
    return verifier.verifyPersonalMessage(messageDigest, signature,
        hashMessage: hashMessage, payloadLength: payloadLength);
  }

  static ETHPublicKey? getPublicKey(
      List<int> messageDigest, List<int> signature,
      {bool hashMessage = true, int? payloadLength}) {
    final verifier = ETHVerifier.getPublicKey(messageDigest, signature,
        hashMessage: hashMessage, payloadLength: payloadLength);
    if (verifier == null) return null;
    final pubKey = Secp256k1PublicKeyEcdsa.fromBytes(verifier.point.toBytes());
    return ETHPublicKey._(pubKey);
  }
}
