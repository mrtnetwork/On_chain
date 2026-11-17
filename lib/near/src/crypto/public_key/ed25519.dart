import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/address/address.dart';
import 'package:on_chain/near/src/crypto/public_key/public_key.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';

class NearEd25519PublicKey extends NearPublicKey {
  final ED25519PublicKey publicKey;
  const NearEd25519PublicKey(this.publicKey) : super(type: NearKeyType.ed25519);
  factory NearEd25519PublicKey.fromBytes(List<int> bytes) =>
      NearEd25519PublicKey(ED25519PublicKey.fromBytes(bytes));
  factory NearEd25519PublicKey.deserializeJson(Map<String, dynamic> json) {
    return NearEd25519PublicKey.fromBytes(json.valueAsBytes("data"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        NearKeyType.ed25519.encodePublicKeyBytesLength,
        property: "data",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {"data": toBytes()};
  }

  @override
  BuBytes toBytes() {
    return publicKey.toBytes();
  }

  @override
  bool verifySignature(List<int> message, List<int> signature) {
    final verifier = ED25519Verifier(publicKey);
    return verifier.verify(message, ED25519Signature.fromBytes(signature));
  }

  @override
  NearImplicitAddress toImplicitAddress() =>
      NearImplicitAddress.fromBytes(toBytes());

  @override
  List<dynamic> get variables => [publicKey];
}
