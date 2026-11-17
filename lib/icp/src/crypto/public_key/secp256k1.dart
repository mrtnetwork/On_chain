import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/crypto/public_key/public_key.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

class ICPSecp256k1PublicKey extends ICPPublicKey {
  final Secp256k1PublicKey publicKey;

  const ICPSecp256k1PublicKey(this.publicKey)
    : super(type: ICPKeyType.secp256k1);

  factory ICPSecp256k1PublicKey.fromBytes(List<int> bytes) =>
      ICPSecp256k1PublicKey(Secp256k1PublicKey.fromBytes(bytes));

  @override
  BuBytes toBytes({
    CryptoKeyEncoding encoding = CryptoKeyEncoding.base,
    bool withPrefix = true,
  }) {
    final bytes = publicKey.toBytes();

    return switch (encoding) {
      CryptoKeyEncoding.uncompressed when !withPrefix => bytes.sublist(
        EcdsaKeysConst.pubKeyUncompressedPrefix.length,
      ),
      _ => bytes,
    };
  }

  @override
  bool verifySignature(
    List<int> message,
    List<int> signature, {
    bool hashMessage = true,
  }) {
    final verifier = Secp256k1Verifier(publicKey);
    return verifier.verify(
      message,
      IECDSASignature.fromBytes(signature),
      hashMessage: hashMessage,
    );
  }

  @override
  List<dynamic> get variables => [publicKey];

  @override
  BuBytes toDer({
    CryptoKeyEncoding pubKeyMode = CryptoKeyEncoding.uncompressed,
  }) {
    return publicKey.toDer(pubKeyMode: pubKeyMode);
  }
}
