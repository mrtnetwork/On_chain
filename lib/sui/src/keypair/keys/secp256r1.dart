import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

/// Represents a Sui secp256r1 private key with signing capabilities.
class SuiSecp256r1PrivateKey extends SuiBasePrivateKey<SuiSecp256r1PublicKey> {
  final Nist256p1PrivateKey _privateKey;

  /// Private constructor to initialize the secp256r1 private key.
  SuiSecp256r1PrivateKey._(this._privateKey)
      : super(algorithm: SuiKeyAlgorithm.secp256r1);

  /// Creates an instance from raw private key bytes.
  factory SuiSecp256r1PrivateKey.fromBytes(List<int> keyBytes) {
    return SuiSecp256r1PrivateKey._(Nist256p1PrivateKey.fromBytes(keyBytes));
  }

  /// Returns the corresponding public key for the private key.
  @override
  late final SuiSecp256r1PublicKey publicKey =
      SuiSecp256r1PublicKey._(_privateKey.publicKey as Nist256p1PublicKey);

  /// Signs a digest and returns the signature.
  @override
  SuiGenericSignature sign(List<int> digest) {
    final signer = Nist256p1Signer.fromKeyBytes(toBytes());
    return SuiGenericSignature(
        signature: signer.sign(digest), algorithm: algorithm);
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

/// Represents a Sui secp256r1 public key with verification capabilities.
class SuiSecp256r1PublicKey extends SuiCryptoPublicKey<Nist256p1PublicKey> {
  /// Private constructor to initialize the secp256r1 public key.
  const SuiSecp256r1PublicKey._(Nist256p1PublicKey publicKey)
      : super(algorithm: SuiKeyAlgorithm.secp256r1, publicKey: publicKey);

  /// Creates an instance from raw public key bytes.
  factory SuiSecp256r1PublicKey.fromBytes(List<int> keyBytes) {
    return SuiSecp256r1PublicKey._(Nist256p1PublicKey.fromBytes(keyBytes));
  }

  /// Creates an instance from a serialized structure.
  factory SuiSecp256r1PublicKey.fromStruct(Map<String, dynamic> json) {
    return SuiSecp256r1PublicKey.fromBytes(json.asBytes("key"));
  }

  /// Defines the layout for BCS serialization of the public key.
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(EcdsaKeysConst.pubKeyCompressedByteLen,
          property: "key"),
    ], property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"key": toBytes()};
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
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
    final verifier = Nist256p1Verifier.fromKeyBytes(toBytes());
    return verifier.verify(message, signature, hashMessage: hashMessage);
  }

  /// Checks equality based on the public key.
  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! SuiSecp256r1PublicKey) return false;
    return publicKey == other.publicKey;
  }

  /// Returns the hash code for the public key.
  @override
  int get hashCode => publicKey.hashCode;

  /// Converts the public key to a corresponding Sui address.
  @override
  SuiAddress toAddress() {
    return SuiAddress(
        SuiAddrEncoder().encodeSecp256r1Key(publicKey.uncompressed));
  }
}
