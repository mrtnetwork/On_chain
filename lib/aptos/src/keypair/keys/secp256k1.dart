import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/keypair/core/keypair.dart';
import 'package:on_chain/aptos/src/keypair/types/types.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosSecp256k1PrivateKey extends AptosBasePrivateKey<
    AptosSecp256k1PublicKey, AptosSecp256k1AnySignature> {
  final Secp256k1PrivateKeyEcdsa _privateKey;
  AptosSecp256k1PrivateKey._(this._privateKey)
      : super(algorithm: AptosKeyAlgorithm.secp256k1);
  factory AptosSecp256k1PrivateKey.fromBytes(List<int> keyBytes) {
    return AptosSecp256k1PrivateKey._(
        Secp256k1PrivateKeyEcdsa.fromBytes(keyBytes));
  }

  @override
  late final AptosSecp256k1PublicKey publicKey = AptosSecp256k1PublicKey._(
      _privateKey.publicKey as Secp256k1PublicKeyEcdsa);

  @override
  AptosSecp256k1AnySignature sign(List<int> digest) {
    digest = QuickCrypto.sha3256Hash(digest);
    final signer = Secp256k1Signer.fromKeyBytes(toBytes());
    return AptosSecp256k1AnySignature(signer.sign(digest, hashMessage: false));
  }

  @override
  List<int> toBytes() {
    return _privateKey.raw;
  }

  @override
  String toHex({bool lowerCase = true, String prefix = ''}) {
    return _privateKey.toHex(lowerCase: lowerCase, prefix: prefix);
  }
}

class AptosSecp256k1PublicKey
    extends AptosCryptoPublicKey<Secp256k1PublicKeyEcdsa> {
  const AptosSecp256k1PublicKey._(Secp256k1PublicKeyEcdsa publicKey)
      : super(algorithm: AptosKeyAlgorithm.secp256k1, publicKey: publicKey);
  factory AptosSecp256k1PublicKey.fromBytes(List<int> keyBytes) {
    return AptosSecp256k1PublicKey._(
        Secp256k1PublicKeyEcdsa.fromBytes(keyBytes));
  }

  factory AptosSecp256k1PublicKey.fromStruct(Map<String, dynamic> json) {
    return AptosSecp256k1PublicKey.fromBytes(json.asBytes("key"));
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
    return {"key": publicKeyBytes(pubkeyMode: PubKeyModes.uncompressed)};
  }

  @override
  List<int> publicKeyBytes({PubKeyModes pubkeyMode = PubKeyModes.compressed}) {
    if (pubkeyMode == PubKeyModes.compressed) {
      return publicKey.compressed;
    }
    return publicKey.uncompressed;
  }

  @override
  String publicKeyHex(
      {PubKeyModes pubkeyMode = PubKeyModes.compressed,
      bool lowerCase = false}) {
    return BytesUtils.toHexString(publicKeyBytes(pubkeyMode: pubkeyMode),
        lowerCase: lowerCase);
  }

  @override
  bool verify(
      {required List<int> message,
      required List<int> signature,
      bool hashMessage = true}) {
    if (hashMessage) {
      message = QuickCrypto.sha3256Hash(message);
    }
    final verifier = Secp256k1Verifier.fromKeyBytes(publicKeyBytes());
    return verifier.verify(message, signature, hashMessage: false);
  }

  @override
  operator ==(other) {
    if (identical(this, other)) return true;
    if (other is! AptosSecp256k1PublicKey) return false;
    return publicKey == other.publicKey;
  }

  @override
  int get hashCode => publicKey.hashCode;

  @override
  AptosAddress toAddress() {
    return AptosAddress(AptosAddrEncoder().encodeSingleKey(publicKey));
  }
}
