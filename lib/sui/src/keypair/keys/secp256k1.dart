import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';

/// Represents a Sui secp256k1 private key with signing capabilities.
class SuiSecp256k1PrivateKey extends SuiBasePrivateKey<SuiSecp256k1PublicKey> {
  final Secp256k1PrivateKey privateKey;

  /// Private constructor to initialize the secp256k1 private key.
  SuiSecp256k1PrivateKey(this.privateKey)
    : super(algorithm: SuiKeyAlgorithm.secp256k1);

  /// Creates an instance from raw private key bytes.
  factory SuiSecp256k1PrivateKey.fromBytes(List<int> keyBytes) {
    return SuiSecp256k1PrivateKey(Secp256k1PrivateKey.fromBytes(keyBytes));
  }

  /// Returns the corresponding public key for the private key.
  @override
  late final SuiSecp256k1PublicKey publicKey = SuiSecp256k1PublicKey(
    privateKey.publicKey,
  );

  /// Signs a digest and returns the signature.
  @override
  SuiGenericSignature sign(List<int> digest) {
    final signer = Secp256k1Signer(privateKey);
    return SuiGenericSignature(
      signature: signer.sign(digest).encoded,
      algorithm: algorithm,
    );
  }

  /// Returns the raw bytes of the private key.
  @override
  SecretBytes toBytes() {
    return privateKey.toBytes();
  }

  /// Returns the hexadecimal representation of the private key.
  @override
  String toHex({bool lowerCase = false}) {
    return privateKey.takeSecretKey().toHex(lowerCase: lowerCase);
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}

/// Represents a Sui secp256k1 public key with verification capabilities.
class SuiSecp256k1PublicKey extends SuiCryptoPublicKey<Secp256k1PublicKey> {
  /// Private constructor to initialize the secp256k1 public key.
  const SuiSecp256k1PublicKey(Secp256k1PublicKey publicKey)
    : super(algorithm: SuiKeyAlgorithm.secp256k1, publicKey: publicKey);

  /// Creates an instance from raw public key bytes.
  factory SuiSecp256k1PublicKey.fromBytes(List<int> keyBytes) {
    return SuiSecp256k1PublicKey(Secp256k1PublicKey.fromBytes(keyBytes));
  }

  factory SuiSecp256k1PublicKey.fromStruct(Map<String, dynamic> json) {
    return SuiSecp256k1PublicKey.fromBytes(json.valueAsBytes("key"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        EcdsaKeysConst.pubKeyCompressedByteLen,
        property: "key",
      ),
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
  BuBytes toBytes({CryptoKeyEncoding pubkeyMode = CryptoKeyEncoding.base}) {
    return publicKey.toBytes(mode: pubkeyMode);
  }

  /// Returns the hexadecimal representation of the public key.
  @override
  String toHex({
    CryptoKeyEncoding pubkeyMode = CryptoKeyEncoding.base,
    bool lowerCase = false,
  }) {
    return toBytes(pubkeyMode: pubkeyMode).toHex(lowerCase: lowerCase);
  }

  /// Verifies a message and signature pair for authenticity.
  @override
  bool verify({
    required List<int> message,
    required List<int> signature,
    bool hashMessage = true,
  }) {
    final verifier = Secp256k1Verifier(publicKey);
    return verifier.verify(
      message,
      IECDSASignature.fromBytes(signature),
      hashMessage: hashMessage,
    );
  }

  /// Converts the public key to a corresponding Sui address.
  @override
  SuiAddress toAddress() {
    return SuiAddress(SuiAddrEncoder().encodeSecp256k1Key(toBytes()));
  }
}
