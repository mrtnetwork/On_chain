import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/ada/src/models/fixed_bytes/models/models.dart';

/// Represents an Ada public key.
class AdaPublicKey {
  final BaseEd25519PublicKey publicKey;

  /// Constructs an [AdaPublicKey] instance with the provided [publicKey].
  const AdaPublicKey._(this.publicKey);
  factory AdaPublicKey.from(BaseEd25519PublicKey key) {
    return switch (key.type) {
      CryptoKeyType.ed25519 ||
      CryptoKeyType.ed25519Kholaw => AdaPublicKey._(key),
      _ =>
        throw BuError(
          DefaultErrorType.unsupported,
          'Unsupported key algorithm. Expected ed25519 or ed25519Kholaw.',
          details: {'algorithm': key.type.name},
        ),
    };
  }

  /// Constructs an [AdaPublicKey] from the given [publicKeyBytes].
  factory AdaPublicKey.fromBytes(List<int> publicKeyBytes) {
    return AdaPublicKey._(ED25519PublicKey.fromBytes(publicKeyBytes));
  }

  /// Constructs an [AdaPublicKey] from the hexadecimal representation [publicKeyHex].
  factory AdaPublicKey.fromHex(String publicKeyHex) {
    return AdaPublicKey.fromBytes(BytesUtils.fromHexString(publicKeyHex));
  }

  BuBytes toBytes32() {
    return publicKey.toBytes();
  }

  String toHex() {
    return BytesUtils.toHexString(toBytes32());
  }

  /// Verifies the given [signature] against the [digest] using this public key.
  ///
  /// Returns true if the verification succeeds, false otherwise.
  bool verify({required List<int> digest, required List<int> signature}) {
    final verifier = ED25519Verifier(publicKey);
    return verifier.verify(digest, ED25519Signature.fromBytes(signature));
  }

  /// Converts the [AdaPublicKey] to a verification key ([Vkey]).
  Vkey toVerificationKey() {
    return Vkey(toBytes32());
  }
}
