import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/keypair/core/keypair.dart';
import 'package:on_chain/aptos/src/keypair/types/types.dart';

class AptosSecp256k1PrivateKey
    extends
        AptosBasePrivateKey<
          AptosSecp256k1PublicKey,
          AptosSecp256k1AnySignature
        > {
  final Secp256k1PrivateKey privateKey;
  AptosSecp256k1PrivateKey(this.privateKey)
    : super(algorithm: AptosKeyAlgorithm.secp256k1);
  factory AptosSecp256k1PrivateKey.fromBytes(List<int> keyBytes) {
    return AptosSecp256k1PrivateKey(Secp256k1PrivateKey.fromBytes(keyBytes));
  }

  @override
  AptosSecp256k1PublicKey get publicKey =>
      AptosSecp256k1PublicKey(privateKey.publicKey);

  @override
  AptosSecp256k1AnySignature sign(List<int> digest) {
    digest = QuickCrypto.sha3256Hash(digest);
    final signer = Secp256k1Signer(privateKey);
    return AptosSecp256k1AnySignature(
      signer.sign(digest, hashMessage: false).encoded,
    );
  }

  @override
  SecretBytes toBytes() {
    return privateKey.toBytes();
  }

  @override
  String toHex({bool lowerCase = true, String prefix = ''}) {
    return privateKey.takeSecretKey().toHex(
      lowerCase: lowerCase,
      prefix: prefix,
    );
  }

  @override
  void dispose() {
    privateKey.dispose();
  }

  @override
  List<dynamic> get variables => [privateKey];
}

class AptosSecp256k1PublicKey extends AptosCryptoPublicKey<Secp256k1PublicKey> {
  const AptosSecp256k1PublicKey(Secp256k1PublicKey publicKey)
    : super(algorithm: AptosKeyAlgorithm.secp256k1, publicKey: publicKey);
  factory AptosSecp256k1PublicKey.fromBytes(List<int> keyBytes) {
    return AptosSecp256k1PublicKey(Secp256k1PublicKey.fromBytes(keyBytes));
  }

  factory AptosSecp256k1PublicKey.fromStruct(Map<String, dynamic> json) {
    return AptosSecp256k1PublicKey.fromBytes(json.valueAsBytes("key"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.bcsBytes(property: "key"),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"key": publicKeyBytes(pubkeyMode: CryptoKeyEncoding.uncompressed)};
  }

  @override
  BuBytes publicKeyBytes({
    CryptoKeyEncoding pubkeyMode = CryptoKeyEncoding.base,
  }) {
    return publicKey.toBytes(mode: pubkeyMode);
  }

  @override
  String publicKeyHex({
    CryptoKeyEncoding pubkeyMode = CryptoKeyEncoding.base,
    bool lowerCase = false,
  }) {
    return BytesUtils.toHexString(
      publicKeyBytes(pubkeyMode: pubkeyMode),
      lowerCase: lowerCase,
    );
  }

  @override
  bool verify({
    required List<int> message,
    required List<int> signature,
    bool hashMessage = true,
  }) {
    if (hashMessage) {
      message = QuickCrypto.sha3256Hash(message);
    }
    final verifier = Secp256k1Verifier(publicKey);
    return verifier.verify(
      message,
      IECDSASignature.fromBytes(signature),
      hashMessage: false,
    );
  }

  @override
  AptosAddress toAddress() {
    return AptosAddress(AptosAddrEncoder().encodeSingleKey(publicKey));
  }
}
