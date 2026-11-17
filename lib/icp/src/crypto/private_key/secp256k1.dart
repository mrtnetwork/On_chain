import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/icp/src/crypto/public_key/secp256k1.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

class ICPSecp256k1SecretKey extends ICPSecretKey<ICPSecp256k1PublicKey> {
  final Secp256k1PrivateKey privateKey;

  const ICPSecp256k1SecretKey(this.privateKey)
    : super(type: ICPKeyType.secp256k1);

  factory ICPSecp256k1SecretKey.fromBytes(List<int> bytes) =>
      ICPSecp256k1SecretKey(Secp256k1PrivateKey.fromBytes(bytes));

  factory ICPSecp256k1SecretKey.random() {
    return ICPSecp256k1SecretKey(Secp256k1PrivateKey.random());
  }
  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  ICPSecp256k1PublicKey toPublicKey() =>
      ICPSecp256k1PublicKey(privateKey.publicKey);

  @override
  BuBytes sign(List<int> message, {List<int>? extraEntropy}) {
    final signer = Secp256k1Signer(privateKey);
    final signature =
        signer
            .sign(message, hashMessage: true, extraEntropy: extraEntropy)
            .encoded;
    return signature;
  }

  @override
  void dispose() {
    privateKey.dispose();
  }

  @override
  List<dynamic> get variables => [privateKey];
}
