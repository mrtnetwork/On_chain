import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

/// Represents a Sui ED25519 private key with signing capabilities.
class SuiED25519PrivateKey extends SuiBasePrivateKey<SuiED25519PublicKey> {
  final Ed25519PrivateKey _privateKey;

  /// Private constructor to initialize the ED25519 private key.
  SuiED25519PrivateKey._(this._privateKey)
      : super(algorithm: SuiKeyAlgorithm.ed25519);

  /// Creates an instance from raw private key bytes.
  factory SuiED25519PrivateKey.fromBytes(List<int> keyBytes) {
    return SuiED25519PrivateKey._(Ed25519PrivateKey.fromBytes(keyBytes));
  }

  /// Returns the corresponding public key for the private key.
  @override
  late final SuiED25519PublicKey publicKey =
      SuiED25519PublicKey._(_privateKey.publicKey);

  /// Signs a digest and returns the signature.
  @override
  SuiGenericSignature sign(List<int> digest) {
    final signer = Ed25519Signer.fromKeyBytes(toBytes());
    return SuiGenericSignature(
        signature: signer.signConst(digest), algorithm: algorithm);
  }

  /// Returns the raw bytes of the private key.
  @override
  List<int> toBytes() {
    return _privateKey.raw;
  }

  /// Returns the hexadecimal representation of the private key.
  @override
  String toHex({bool lowerCase = false}) {
    return _privateKey.toHex(lowerCase: lowerCase);
  }
}

/// Represents a Sui ED25519 public key with verification capabilities.
class SuiED25519PublicKey extends SuiCryptoPublicKey<Ed25519PublicKey> {
  /// Private constructor to initialize the ED25519 public key.
  const SuiED25519PublicKey._(Ed25519PublicKey publicKey)
      : super(algorithm: SuiKeyAlgorithm.ed25519, publicKey: publicKey);

  /// Creates an instance from raw public key bytes.
  factory SuiED25519PublicKey.fromBytes(List<int> keyBytes) {
    return SuiED25519PublicKey._(Ed25519PublicKey.fromBytes(keyBytes));
  }

  factory SuiED25519PublicKey.fromStruct(Map<String, dynamic> json) {
    return SuiED25519PublicKey.fromBytes(json.asBytes("key"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(Ed25519KeysConst.pubKeyByteLen, property: "key"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  /// Converts the public key to a layout structure for serialization.
  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"key": toBytes()};
  }

  /// Returns the public key bytes in compressed format, omitting the first byte.
  @override
  List<int> toBytes() {
    return publicKey.compressed.sublist(1);
  }

  /// Returns the hexadecimal representation of the public key.
  @override
  String toHex({bool lowerCase = false}) {
    return BytesUtils.toHexString(toBytes(), lowerCase: lowerCase);
  }

  /// Checks equality based on the public key.
  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! SuiED25519PublicKey) return false;
    return publicKey == other.publicKey;
  }

  /// Returns the hash code for the public key.
  @override
  int get hashCode => publicKey.hashCode;

  /// Verifies a message and signature pair for authenticity.
  @override
  bool verify({required List<int> message, required List<int> signature}) {
    final verifier = Ed25519Verifier.fromKeyBytes(toBytes());
    return verifier.verify(message, signature);
  }

  /// Converts the public key to a corresponding Sui address.
  @override
  SuiAddress toAddress() {
    return SuiAddress(SuiAddrEncoder().encodeKey(publicKey.compressed));
  }
}
