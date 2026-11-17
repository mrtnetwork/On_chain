import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/fil/src/crypto/public_key/secp256k1.dart';
import 'package:on_chain/fil/src/crypto/types/types.dart';

class FilSecp256k1SecretKey extends FilSecretKey<FilecoinSecp256k1PublicKey> {
  final Secp256k1PrivateKey privateKey;

  const FilSecp256k1SecretKey(this.privateKey)
    : super(type: FilecoinKeyType.secp256k1);

  factory FilSecp256k1SecretKey.fromBytes(List<int> bytes) =>
      FilSecp256k1SecretKey(Secp256k1PrivateKey.fromBytes(bytes));

  factory FilSecp256k1SecretKey.random() {
    return FilSecp256k1SecretKey(Secp256k1PrivateKey.random());
  }
  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  FilecoinSecp256k1PublicKey toPublicKey() =>
      FilecoinSecp256k1PublicKey(privateKey.publicKey);

  @override
  FilSignature sign(List<int> message, {List<int>? extraEntropy}) {
    final signer = ETHSigner(Secp256k1Signer(privateKey));
    final signature = signer.sign(
      QuickCrypto.blake2b256Hash(message),
      extraEntropy: extraEntropy,
      hashMessage: false,
    );

    return FilSignature(
      type: FilSigType.secp256k1,
      data: signature.signature.toBytes(
        encoding: ECDSASignatureEncoding.suffixRecoveryId,
      ),
    );
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}
