import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/icp/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/icp/src/crypto/public_key/secp256r1.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

class ICPSecp256r1SecretKey extends ICPSecretKey<ICPSecp256r1PublicKey> {
  final Secp256r1PrivateKey privateKey;

  const ICPSecp256r1SecretKey(this.privateKey)
    : super(type: ICPKeyType.secp256r1);

  factory ICPSecp256r1SecretKey.fromBytes(List<int> bytes) =>
      ICPSecp256r1SecretKey(Secp256r1PrivateKey.fromBytes(bytes));

  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  ICPSecp256r1PublicKey toPublicKey() =>
      ICPSecp256r1PublicKey(privateKey.publicKey);

  @override
  BuBytes sign(List<int> message, {List<int>? extraEntropy}) {
    final signer = Secp256r1Signer(privateKey);
    final signature = signer.sign(message, hashMessage: true);
    return signature.encoded;
  }

  @override
  void dispose() {
    privateKey.dispose();
  }

  @override
  List<dynamic> get variables => [privateKey];
}
