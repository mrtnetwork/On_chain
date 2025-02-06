import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/byron/byron.dart';
import 'package:on_chain/ada/src/exception/exception.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/bootstrap_witness.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/vkey_witness.dart';
import 'public_key.dart';

/// Represents an Ada private key.
class AdaPrivateKey {
  final IPrivateKey _privateKey;

  /// Constructs an [AdaPrivateKey] instance with the provided [_privateKey].
  const AdaPrivateKey._(this._privateKey);

  /// Constructs an [AdaPrivateKey] from the given [privateKeyBytes].
  ///
  /// Throws a [MessageException] if the length of [privateKeyBytes] is invalid.
  factory AdaPrivateKey.fromBytes(List<int> privateKeyBytes) {
    if (privateKeyBytes.length != Ed25519KeysConst.privKeyByteLen &&
        privateKeyBytes.length != Ed25519KholawKeysConst.privKeyByteLen) {
      throw ADAPluginException('Invalid private key bytes.', details: {
        'length': privateKeyBytes.length,
        'expected':
            '${Ed25519KeysConst.privKeyByteLen} or ${Ed25519KholawKeysConst.privKeyByteLen}'
      });
    }
    IPrivateKey key;
    if (privateKeyBytes.length == Ed25519KholawKeysConst.privKeyByteLen) {
      key = Ed25519KholawPrivateKey.fromBytes(privateKeyBytes);
    } else {
      key = Ed25519PrivateKey.fromBytes(privateKeyBytes);
    }
    return AdaPrivateKey._(key);
  }

  /// Constructs an [AdaPrivateKey] from the hexadecimal representation [privateKeyHex].
  factory AdaPrivateKey.fromHex(String privateKeyHex) {
    return AdaPrivateKey.fromBytes(BytesUtils.fromHexString(privateKeyHex));
  }

  /// Obtains the public key derived from this private key.
  AdaPublicKey publicKey() {
    return AdaPublicKey.fromBytes(_privateKey.publicKey.compressed);
  }

  /// Converts the private key to its byte representation.
  List<int> toBytes() {
    return _privateKey.raw;
  }

  /// Converts the private key to its hexadecimal representation.
  String toHex() {
    return BytesUtils.toHexString(toBytes());
  }

  /// Signs the given [digest] with this private key.
  ///
  /// Returns the signature as a list of bytes.
  List<int> sign(List<int> digest) {
    final signer = CardanoSigner.fromKeyBytes(toBytes());
    final sig = signer.sign(digest);
    return sig;
  }

  /// Creates a Vkeywitness by signing the provided [digest] using the private key associated with this [AdaPublicKey].
  /// The [digest] represents the message to be signed.
  /// Returns a Vkeywitness object containing the verification key and signature.
  Vkeywitness createSignatureWitness(List<int> digest) {
    return Vkeywitness(
        vKey: publicKey().toVerificationKey(),
        signature: Ed25519Signature(sign(digest)));
  }

  BootstrapWitness createBootstrapWitness(
      {required List<int> digest,
      required ADAByronAddress address,
      required List<int> chainCode}) {
    return BootstrapWitness(
        vkey: Vkey(publicKey().toBytes(false)),
        signature: Ed25519Signature(sign(digest)),
        chainCode: chainCode,
        attributes: address.attributeSerialize());
  }
}
