import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/fil/src/crypto/public_key/bls12.dart';
import 'package:on_chain/fil/src/crypto/types/types.dart';

class FilBls12SecretKey extends FilSecretKey<FilBls12PublicKey> {
  final Bls12G1PrivateKey privateKey;

  const FilBls12SecretKey(this.privateKey) : super(type: FilecoinKeyType.bls12);

  factory FilBls12SecretKey.fromBytes(List<int> bytes) =>
      FilBls12SecretKey(Bls12G1PrivateKey.fromBytes(bytes));
  factory FilBls12SecretKey.random() =>
      FilBls12SecretKey(Bls12G1PrivateKey.random());
  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  FilBls12PublicKey toPublicKey() => FilBls12PublicKey(privateKey.publicKey);

  @override
  FilSignature sign(List<int> message) {
    final signature = privateKey.sign(
      Bls12SigningParams(message: message, dst: BlsG2Constants.defaultBlsDst),
    );
    return FilSignature(type: FilSigType.bls, data: signature.toBytes());
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}
