import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/crypto/public_key/public_key.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';

class NearMLDSA65PublicKey extends NearPublicKey {
  final MLDSA65PublicKey publicKey;
  NearMLDSA65PublicKey._(this.publicKey) : super(type: NearKeyType.mldsa65);

  factory NearMLDSA65PublicKey.from(MLDSA65PublicKey publicKey) {
    return NearMLDSA65PublicKey._(publicKey);
  }
  factory NearMLDSA65PublicKey.fromBytes(List<int> bytes) {
    return NearMLDSA65PublicKey.from(MLDSA65PublicKey.fromBytes(bytes));
  }
  factory NearMLDSA65PublicKey.deserializeJson(Map<String, dynamic> json) {
    return NearMLDSA65PublicKey.fromBytes(json.valueAsBytes("data"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        NearKeyType.mldsa65.encodePublicKeyBytesLength,
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
  bool verifySignature(
    List<int> message,
    List<int> signature, {
    List<int>? context,
  }) {
    return publicKey.verify(
      MLDSAVerifyingParams(
        message,
        MLDSASignature(signature),
        context: context,
      ),
    );
  }

  @override
  List<dynamic> get variables => [publicKey];
}
