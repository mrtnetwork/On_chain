import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/account.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/keypair/core/keypair.dart';
import 'package:on_chain/aptos/src/keypair/types/types.dart';

class AptosED25519PrivateKey
    extends
        AptosBasePrivateKey<AptosED25519PublicKey, AptosEd25519AnySignature> {
  final ED25519PrivateKey privateKey;
  AptosED25519PrivateKey(this.privateKey)
    : super(algorithm: AptosKeyAlgorithm.ed25519);
  factory AptosED25519PrivateKey.fromBytes(List<int> keyBytes) {
    return AptosED25519PrivateKey(ED25519PrivateKey.fromBytes(keyBytes));
  }

  @override
  AptosEd25519AnySignature sign(List<int> digest) {
    final signer = ED25519Signer(privateKey);
    return AptosEd25519AnySignature(signer.sign(digest).encoded);
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
  AptosED25519PublicKey get publicKey =>
      AptosED25519PublicKey(privateKey.publicKey);

  @override
  List<dynamic> get variables => [privateKey];
}

class AptosED25519PublicKey extends AptosCryptoPublicKey<ED25519PublicKey> {
  const AptosED25519PublicKey(ED25519PublicKey publicKey)
    : super(algorithm: AptosKeyAlgorithm.ed25519, publicKey: publicKey);
  factory AptosED25519PublicKey.fromBytes(List<int> keyBytes) {
    return AptosED25519PublicKey(ED25519PublicKey.fromBytes(keyBytes));
  }
  factory AptosED25519PublicKey.fromStruct(Map<String, dynamic> json) {
    return AptosED25519PublicKey.fromBytes(json.valueAsBytes("key"));
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
    return {"key": publicKeyBytes()};
  }

  @override
  BuBytes publicKeyBytes() {
    return publicKey.toBytes();
  }

  @override
  String publicKeyHex({bool lowerCase = false}) {
    return publicKeyBytes().toHex(lowerCase: lowerCase);
  }

  @override
  bool verify({required List<int> message, required List<int> signature}) {
    final verifier = ED25519Verifier(publicKey);
    return verifier.verify(message, ED25519Signature.fromBytes(signature));
  }

  @override
  AptosAddress toAddress({
    AptosEd25519AddressScheme scheme = AptosEd25519AddressScheme.ed25519,
  }) {
    return switch (scheme) {
      AptosEd25519AddressScheme.ed25519 => AptosAddress(
        AptosAddrEncoder().encodeKey(publicKey.toBytes()),
      ),
      AptosEd25519AddressScheme.signleKey => AptosAddress(
        AptosAddrEncoder().encodeSingleKey(publicKey),
      ),
    };
  }
}
