import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

/// Represents a Sui secp256k1 private key with signing capabilities.
class SuiSecp256k1PrivateKey extends SuiBasePrivateKey<SuiSecp256k1PublicKey> {
  final Secp256k1PrivateKey _privateKey;

  /// Private constructor to initialize the secp256k1 private key.
  SuiSecp256k1PrivateKey._(this._privateKey)
      : super(algorithm: SuiKeyAlgorithm.secp256k1);

  /// Creates an instance from raw private key bytes.
  factory SuiSecp256k1PrivateKey.fromBytes(List<int> keyBytes) {
    return SuiSecp256k1PrivateKey._(Secp256k1PrivateKey.fromBytes(keyBytes));
  }

  /// Returns the corresponding public key for the private key.
  @override
  late final SuiSecp256k1PublicKey publicKey =
      SuiSecp256k1PublicKey._(_privateKey.publicKey);

  /// Signs a digest and returns the signature.
  @override
  SuiGenericSignature sign(List<int> digest) {
    final signer = Secp256k1Signer.fromKeyBytes(toBytes());
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

/// Represents a Sui secp256k1 public key with verification capabilities.
class SuiSecp256k1PublicKey extends SuiCryptoPublicKey<Secp256k1PublicKey> {
  /// Private constructor to initialize the secp256k1 public key.
  const SuiSecp256k1PublicKey._(Secp256k1PublicKey publicKey)
      : super(algorithm: SuiKeyAlgorithm.secp256k1, publicKey: publicKey);

  /// Creates an instance from raw public key bytes.
  factory SuiSecp256k1PublicKey.fromBytes(List<int> keyBytes) {
    return SuiSecp256k1PublicKey._(Secp256k1PublicKey.fromBytes(keyBytes));
  }

  factory SuiSecp256k1PublicKey.fromStruct(Map<String, dynamic> json) {
    return SuiSecp256k1PublicKey.fromBytes(json.asBytes("key"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(EcdsaKeysConst.pubKeyCompressedByteLen,
          property: "key"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"key": toBytes()};
  }

  /// Returns the public key bytes in compressed or uncompressed format.
  @override
  List<int> toBytes({PubKeyModes pubkeyMode = PubKeyModes.compressed}) {
    if (pubkeyMode == PubKeyModes.compressed) {
      return publicKey.compressed;
    }
    return publicKey.uncompressed;
  }

  /// Returns the hexadecimal representation of the public key.
  @override
  String toHex(
      {PubKeyModes pubkeyMode = PubKeyModes.compressed,
      bool lowerCase = false}) {
    return BytesUtils.toHexString(toBytes(pubkeyMode: pubkeyMode),
        lowerCase: lowerCase);
  }

  /// Verifies a message and signature pair for authenticity.
  @override
  bool verify(
      {required List<int> message,
      required List<int> signature,
      bool hashMessage = true}) {
    final verifier = Secp256k1Verifier.fromKeyBytes(toBytes());
    return verifier.verify(message, signature, hashMessage: hashMessage);
  }

  /// Checks equality based on the public key.
  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! SuiSecp256k1PublicKey) return false;
    return publicKey == other.publicKey;
  }

  /// Returns the hash code for the public key.
  @override
  int get hashCode => publicKey.hashCode;

  /// Converts the public key to a corresponding Sui address.
  @override
  SuiAddress toAddress() {
    return SuiAddress(
        SuiAddrEncoder().encodeSecp256k1Key(publicKey.uncompressed));
  }
}
