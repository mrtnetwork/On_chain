import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

/// Represents an Ada public key.
class AdaPublicKey {
  final Ed25519PublicKey _publicKey;

  /// Constructs an [AdaPublicKey] instance with the provided [_publicKey].
  const AdaPublicKey._(this._publicKey);

  /// Constructs an [AdaPublicKey] from the given [publicKeyBytes].
  factory AdaPublicKey.fromBytes(List<int> publicKeyBytes) {
    return AdaPublicKey._(Ed25519PublicKey.fromBytes(publicKeyBytes));
  }

  /// Constructs an [AdaPublicKey] from the hexadecimal representation [publicKeyHex].
  factory AdaPublicKey.fromHex(String publicKeyHex) {
    return AdaPublicKey.fromBytes(BytesUtils.fromHexString(publicKeyHex));
  }

  /// Converts the public key to its byte representation.
  ///
  /// If [withPrefix] is true (default), includes the prefix byte.
  /// Otherwise, excludes the prefix byte.
  List<int> toBytes([bool withPrefix = true]) {
    if (withPrefix) {
      return _publicKey.compressed;
    }
    return _publicKey.compressed.sublist(1);
  }

  /// Converts the public key to its hexadecimal representation.
  ///
  /// If [withPrefix] is true (default), includes the prefix byte in the hexadecimal string.
  /// Otherwise, excludes the prefix byte.
  String toHex([bool withPrefix = true]) {
    return BytesUtils.toHexString(toBytes(withPrefix));
  }

  /// Verifies the given [signature] against the [digest] using this public key.
  ///
  /// Returns true if the verification succeeds, false otherwise.
  bool verify({required List<int> digest, required List<int> signature}) {
    final verifier = CardanoVerifier.fromKeyBytes(toBytes());
    return verifier.verify(digest, signature);
  }

  /// Converts the [AdaPublicKey] to a verification key ([Vkey]).
  Vkey toVerificationKey() {
    return Vkey(toBytes(false));
  }
}
