import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/crypto/public_key/public_key.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

class ICPSecp256r1PublicKey extends ICPPublicKey {
  final Secp256r1PublicKey publicKey;

  const ICPSecp256r1PublicKey(this.publicKey)
    : super(type: ICPKeyType.secp256r1);

  factory ICPSecp256r1PublicKey.fromBytes(List<int> bytes) =>
      ICPSecp256r1PublicKey(Secp256r1PublicKey.fromBytes(bytes));

  @override
  BuBytes toBytes() {
    return publicKey.toBytes();
  }

  @override
  bool verifySignature(
    List<int> message,
    List<int> signature, {
    bool hashMessage = true,
  }) {
    final verifier = Secp256r1Verifier(publicKey);
    return verifier.verify(
      message,
      IECDSASignature.fromBytes(signature),
      hashMessage: hashMessage,
    );
  }

  @override
  BuBytes toDer({
    CryptoKeyEncoding pubKeyMode = CryptoKeyEncoding.uncompressed,
  }) {
    return publicKey.toDer(pubKeyMode: pubKeyMode);
  }

  @override
  List<dynamic> get variables => [publicKey];
}
