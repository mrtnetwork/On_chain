import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/crypto/public_key/secp256k1.dart';
import 'package:on_chain/tezos/src/crypto/types/signature.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';

import 'secret_key.dart';

/// secp256k1 secret key (tz2 / sppk / spsig).
class TezosSecp256k1SecretKey extends TezosSecretKey<TezosSecp256k1PublicKey> {
  final Secp256k1PrivateKey privateKey;

  const TezosSecp256k1SecretKey(this.privateKey)
    : super(type: TezosKeyType.secp256k1);

  factory TezosSecp256k1SecretKey.fromBytes(List<int> bytes) =>
      TezosSecp256k1SecretKey(Secp256k1PrivateKey.fromBytes(bytes));

  factory TezosSecp256k1SecretKey.random() {
    return TezosSecp256k1SecretKey(Secp256k1PrivateKey.random());
  }

  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  TezosSecp256k1PublicKey toPublicKey() =>
      TezosSecp256k1PublicKey(privateKey.publicKey);

  @override
  TezosSignature sign(List<int> digest, {List<int>? extraEntropy}) {
    final signer = Secp256k1Signer(privateKey);
    return TezosGenericSignature(
      signer
          .sign(digest, hashMessage: false, extraEntropy: extraEntropy)
          .encoded,
    );
  }

  @override
  List<dynamic> get variables => [privateKey];

  @override
  void dispose() {
    privateKey.dispose();
  }
}
