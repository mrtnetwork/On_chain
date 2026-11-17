import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/crypto/public_key/public_key.dart';
import 'package:on_chain/near/src/crypto/utils/utils.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';

class NearSecp256k1PublicKey extends NearPublicKey {
  final Secp256k1PublicKey publicKey;
  const NearSecp256k1PublicKey(this.publicKey)
    : super(type: NearKeyType.secp256k1);
  factory NearSecp256k1PublicKey.fromBytes(List<int> bytes) {
    if (bytes.length == NearKeyType.secp256k1.encodePublicKeyBytesLength) {
      bytes = [...EcdsaKeysConst.pubKeyUncompressedPrefix, ...bytes];
    }
    return NearSecp256k1PublicKey(Secp256k1PublicKey.fromBytes(bytes));
  }
  factory NearSecp256k1PublicKey.deserializeJson(Map<String, dynamic> json) {
    return NearSecp256k1PublicKey.fromBytes(json.valueAsBytes("data"));
  }

  static Layout<Map<String, dynamic>> layout({String? property}) {
    return LayoutConst.struct([
      LayoutConst.fixedBlobN(
        NearKeyType.secp256k1.encodePublicKeyBytesLength,
        property: "data",
      ),
    ], property: property);
  }

  @override
  Layout<Map<String, dynamic>> toLayout({String? property}) {
    return layout(property: property);
  }

  @override
  String encode() {
    return NearCryptoUtils.encodeKey(
      type,
      toBytes(encoding: CryptoKeyEncoding.uncompressed, withPrefix: false),
    );
  }

  @override
  Map<String, dynamic> toSerializeJson() {
    return {
      "data": toBytes(
        encoding: CryptoKeyEncoding.uncompressed,
        withPrefix: false,
      ),
    };
  }

  @override
  BuBytes toBytes({
    CryptoKeyEncoding encoding = CryptoKeyEncoding.base,
    bool withPrefix = true,
  }) {
    final bytes = publicKey.toBytes(mode: encoding);
    return switch (encoding) {
      CryptoKeyEncoding.uncompressed when !withPrefix => bytes.sublist(
        EcdsaKeysConst.pubKeyUncompressedPrefix.length,
      ),
      _ => bytes,
    };
  }

  @override
  bool verifySignature(List<int> message, List<int> signature) {
    final verifier = Secp256k1Verifier(publicKey);
    return verifier.verify(
      message,
      IECDSASignature.fromBytes(signature),
      hashMessage: false,
    );
  }

  @override
  List<dynamic> get variables => [publicKey];
}
