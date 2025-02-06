import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/aptos/src/account/authenticator/authenticator.dart';
import 'package:on_chain/aptos/src/account/core/account.dart';
import 'package:on_chain/aptos/src/account/types/types.dart';
import 'package:on_chain/aptos/src/address/address/address.dart';
import 'package:on_chain/aptos/src/exception/exception.dart';
import 'package:on_chain/aptos/src/keypair/keys/ed25519.dart';
import 'package:on_chain/bcs/serialization.dart';
import 'package:on_chain/utils/utils/map_utils.dart';

class AptosEd25519AccountPublicKey extends AptosAccountPublicKey {
  /// public key
  final AptosED25519PublicKey publicKey;
  const AptosEd25519AccountPublicKey(this.publicKey)
      : super(scheme: AptosSigningScheme.ed25519);
  factory AptosEd25519AccountPublicKey.deserialize(List<int> bytes) {
    final decode = BcsSerialization.deserialize(bytes: bytes, layout: layout());
    return AptosEd25519AccountPublicKey.fromStrunct(decode);
  }
  factory AptosEd25519AccountPublicKey.fromStrunct(Map<String, dynamic> json) {
    return AptosEd25519AccountPublicKey(
        AptosED25519PublicKey.fromStruct(json.asMap("publicKey")));
  }

  /// public key as bytes
  @override
  List<int> toBytes() {
    return publicKey.publicKeyBytes();
  }

  @override
  AptosAddress toAddress() {
    return AptosAddress(
        AptosAddrEncoder().encodeKey(publicKey.publicKeyBytes()));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct(
        [AptosED25519PublicKey.layout(property: "publicKey")],
        property: property);
  }

  @override
  Layout<Map<String, dynamic>> createLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toLayoutStruct() {
    return {"publicKey": publicKey.toLayoutStruct()};
  }

  @override
  bool verifySignature(
      {required List<int> message, required List<int> signature}) {
    AptosEd25519AnySignature anySignature;
    try {
      anySignature = AptosEd25519AnySignature.deserialize(signature);
    } catch (_) {
      throw DartAptosPluginException(
          "Invalid Aptos ED25519 Signature. deserialize signature failed.");
    }
    return publicKey.verify(
        message: message, signature: anySignature.signatureBytes());
  }
}
