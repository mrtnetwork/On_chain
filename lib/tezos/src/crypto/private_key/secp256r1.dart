import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/crypto/public_key/secp256r1.dart';
import 'package:on_chain/tezos/src/crypto/types/signature.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';
import 'secret_key.dart';

class TezosSecp256r1SecretKey extends TezosSecretKey<TezosSecp256r1PublicKey> {
  final Secp256r1PrivateKey privateKey;

  const TezosSecp256r1SecretKey(this.privateKey)
    : super(type: TezosKeyType.secp256r1);

  factory TezosSecp256r1SecretKey.fromBytes(List<int> bytes) =>
      TezosSecp256r1SecretKey(Secp256r1PrivateKey.fromBytes(bytes));

  factory TezosSecp256r1SecretKey.random() {
    return TezosSecp256r1SecretKey(Secp256r1PrivateKey.random());
  }

  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  TezosSecp256r1PublicKey toPublicKey() {
    return TezosSecp256r1PublicKey(privateKey.publicKey);
  }

  @override
  TezosSignature sign(List<int> digest) {
    final signer = Secp256r1Signer(privateKey);
    return TezosGenericSignature(
      signer.sign(digest, hashMessage: false).encoded,
    );
  }

  @override
  List<dynamic> get variables => [privateKey];

  @override
  void dispose() {
    privateKey.dispose();
  }
}
