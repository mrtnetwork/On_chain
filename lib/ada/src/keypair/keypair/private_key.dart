import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/address/era/byron/byron.dart';

import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/models/bootstrap_witness.dart';
import 'package:on_chain/ada/src/models/transaction/witnesses/models/vkey_witness.dart';
import 'public_key.dart';

/// Represents an Ada private key.
class AdaPrivateKey with SecretState {
  final BaseEd25519PrivateKey privateKey;

  /// Constructs an [AdaPrivateKey] instance with the provided [privateKey].
  const AdaPrivateKey._(this.privateKey);
  factory AdaPrivateKey.from(BaseEd25519PrivateKey key) {
    return switch (key.type) {
      CryptoKeyType.ed25519 ||
      CryptoKeyType.ed25519Kholaw => AdaPrivateKey._(key),
      _ =>
        throw BuError(
          DefaultErrorType.unsupported,
          'Unsupported key algorithm. Expected ed25519 or ed25519Kholaw.',
          details: {'algorithm': key.type.name},
        ),
    };
  }

  /// Constructs an [AdaPrivateKey] from the given [privateKeyBytes].
  ///
  /// Throws a [BuError] if the length of [privateKeyBytes] is invalid.
  factory AdaPrivateKey.fromBytes(List<int> privateKeyBytes) {
    if (privateKeyBytes.length != Ed25519KeysConst.privKeyByteLen &&
        privateKeyBytes.length != Ed25519KeysConst.kholawPrivKeyLen) {
      throw BuError(
        DefaultErrorType.badPrivateKey,
        'Invalid private key bytes.',
        details: {
          'length': privateKeyBytes.length.toString(),
          'expected':
              '${Ed25519KeysConst.privKeyByteLen} or ${Ed25519KeysConst.kholawPrivKeyLen}',
        },
      );
    }
    BaseEd25519PrivateKey key;
    if (privateKeyBytes.length == Ed25519KeysConst.kholawPrivKeyLen) {
      key = ED25519KholawPrivateKey.fromBytes(privateKeyBytes);
    } else {
      key = ED25519PrivateKey.fromBytes(privateKeyBytes);
    }
    return AdaPrivateKey._(key);
  }

  /// Constructs an [AdaPrivateKey] from the hexadecimal representation [privateKeyHex].
  factory AdaPrivateKey.fromHex(String privateKeyHex) {
    final bytes = BytesUtils.fromHexString(privateKeyHex);
    try {
      return AdaPrivateKey.fromBytes(BytesUtils.fromHexString(privateKeyHex));
    } finally {
      bytes.forceZero();
    }
  }

  /// Obtains the public key derived from this private key.
  AdaPublicKey publicKey() {
    return AdaPublicKey.from(privateKey.publicKey);
  }

  /// Converts the private key to its byte representation.
  SecretBytes toBytes() {
    return privateKey.toBytes();
  }

  /// Converts the private key to its hexadecimal representation.
  String toHex() {
    return privateKey.takeSecretKey().toHex();
  }

  /// Signs the given [digest] with this private key.
  ///
  /// Returns the signature as a list of bytes.
  BuBytes sign(List<int> digest) {
    final signer = ED25519Signer(privateKey);
    final sig = signer.sign(digest);
    return sig.encoded;
  }

  /// Creates a Vkeywitness by signing the provided [digest] using the private key associated with this [AdaPrivateKey].
  /// The [digest] represents the message to be signed.
  /// Returns a Vkeywitness object containing the verification key and signature.
  Vkeywitness createSignatureWitness(List<int> digest) {
    return Vkeywitness(
      vKey: publicKey().toVerificationKey(),
      signature: Ed25519Signature(sign(digest)),
    );
  }

  BootstrapWitness createBootstrapWitness({
    required List<int> digest,
    required ADAByronAddress address,
    required List<int> chainCode,
  }) {
    return BootstrapWitness(
      vkey: Vkey(publicKey().toBytes32()),
      signature: Ed25519Signature(sign(digest)),
      chainCode: chainCode,
      attributes: address.attributeSerialize(),
    );
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}
