import 'package:blockchain_utils/exception/exception.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/bip/ecc/keys/secp256k1_keys_ecdsa.dart';
import 'package:blockchain_utils/signer/tron/tron_signer.dart';

import 'public_key.dart';

/// Class representing a Tron private key
class TronPrivateKey {
  /// Private constructor for internal use, initializing with a Secp256k1 private key
  const TronPrivateKey._(this._privateKey);

  /// Private field to store the Secp256k1 private key
  final Secp256k1PrivateKeyEcdsa _privateKey;

  /// Factory method to create a TronPrivateKey from a hexadecimal private key string
  factory TronPrivateKey(String privateKeyHex) {
    return TronPrivateKey.fromBytes(BytesUtils.fromHexString(privateKeyHex));
  }

  /// Factory method to create a TronPrivateKey from a list of key bytes
  factory TronPrivateKey.fromBytes(List<int> keyBytes) {
    try {
      final Secp256k1PrivateKeyEcdsa key =
          Secp256k1PrivateKeyEcdsa.fromBytes(keyBytes);
      return TronPrivateKey._(key);
    } catch (e) {
      // Throw a MessageException with details if an error occurs during the creation
      throw MessageException("invalid tron private key",
          details: {"input": BytesUtils.toHexString(keyBytes)});
    }
  }

  /// Method to convert the private key to a list of bytes
  List<int> toBytes() {
    return _privateKey.raw;
  }

  /// Method to convert the private key to a hexadecimal string
  String toHex() {
    return BytesUtils.toHexString(toBytes());
  }

  /// Method to obtain the corresponding Tron public key
  TronPublicKey publicKey() {
    return TronPublicKey.fromBytes(_privateKey.publicKey.compressed);
  }

  /// Method to sign a transaction digest using the private key
  List<int> sign(List<int> transactionDigest) {
    final signer = TronSigner.fromKeyBytes(toBytes());
    return signer.sign(transactionDigest);
  }

  /// Signs a personal message using the private key and returns the signature as a hexadecimal string.
  ///
  /// Optionally, [payloadLength] can be set to specify the payload length for the message.
  String signPersonalMessage(List<int> message,
      {int? payloadLength, bool useEthereumPrefix = false}) {
    final ethsigner = TronSigner.fromKeyBytes(toBytes());
    final sign = ethsigner.signProsonalMessage(message,
        payloadLength: payloadLength, useEthPrefix: useEthereumPrefix);
    return BytesUtils.toHexString(sign);
  }

  @override
  String toString() {
    return "privatekey: ${toHex().substring(0, 5)}...\npublicKey: ${publicKey().toHex()}";
  }
}
