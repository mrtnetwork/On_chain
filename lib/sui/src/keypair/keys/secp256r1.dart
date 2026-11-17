import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/sui/src/address/address/address.dart';
import 'package:on_chain/sui/src/keypair/core/core.dart';
import 'package:on_chain/sui/src/keypair/types/types.dart';

/// Represents a Sui secp256r1 private key with signing capabilities.
class SuiSecp256r1PrivateKey extends SuiBasePrivateKey<SuiSecp256r1PublicKey> {
  /// P-256 (secp256r1) group order (FIPS 186-4 §D.1.2.3).
  static final BigInt _curveOrder = BigInt.parse(
    'ffffffff00000000ffffffffffffffffbce6faada7179e84f3b9cac2fc632551',
    radix: 16,
  );
  final SuiHybridSecp256r1PrivateKey privateKey;
  @override
  final SuiSecp256r1PublicKey publicKey;

  /// Private constructor to initialize the secp256r1 private key.
  SuiSecp256r1PrivateKey(this.privateKey)
    : publicKey = SuiSecp256r1PublicKey(privateKey.publicKey),
      super(algorithm: SuiKeyAlgorithm.secp256r1);

  /// Creates an instance from raw private key bytes.
  factory SuiSecp256r1PrivateKey.fromBytes(List<int> keyBytes) {
    return SuiSecp256r1PrivateKey(
      SuiHybridSecp256r1PrivateKey.fromBytes(keyBytes),
    );
  }

  /// Signs a digest and returns the signature, canonicalized to low-S form
  /// (`s <= n/2`) to match official Sui vectors (both forms verify).
  @override
  SuiGenericSignature sign(List<int> digest) {
    final signer = Secp256r1Signer(privateKey);
    final signature = signer.sign(digest).signature;
    final s = signature.s.toBigInt();
    final normalized =
        s > _curveOrder ~/ BigInt.two
            ? IECDSASignature(
              r: signature.r,
              s: BigintUtils.toBytes(_curveOrder - s),
            )
            : signature;
    return SuiGenericSignature(
      signature: normalized.toBytes(),
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

/// Represents a Sui secp256r1 public key with verification capabilities.
class SuiSecp256r1PublicKey
    extends SuiCryptoPublicKey<SuiHybridSecp256r1PublicKey> {
  /// Private constructor to initialize the secp256r1 public key.
  const SuiSecp256r1PublicKey(SuiHybridSecp256r1PublicKey publicKey)
    : super(algorithm: SuiKeyAlgorithm.secp256r1, publicKey: publicKey);

  /// Creates an instance from raw public key bytes.
  factory SuiSecp256r1PublicKey.fromBytes(List<int> keyBytes) {
    return SuiSecp256r1PublicKey(
      SuiHybridSecp256r1PublicKey.fromBytes(keyBytes),
    );
  }

  /// Creates an instance from a serialized structure.
  factory SuiSecp256r1PublicKey.fromStruct(Map<String, dynamic> json) {
    return SuiSecp256r1PublicKey.fromBytes(json.valueAsBytes("key"));
  }

  /// Defines the layout for BCS serialization of the public key.
  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        EcdsaKeysConst.pubKeyCompressedByteLen,
        property: "key",
      ),
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
    final verifier = Secp256r1Verifier(publicKey);
    return verifier.verify(
      message,
      IECDSASignature.fromBytes(signature),
      hashMessage: hashMessage,
    );
  }

  /// Converts the public key to a corresponding Sui address.
  @override
  SuiAddress toAddress() {
    return SuiAddress(SuiAddrEncoder().encodeSecp256r1Key(toBytes()));
  }
}
