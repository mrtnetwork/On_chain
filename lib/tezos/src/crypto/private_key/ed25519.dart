import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/crypto/public_key/ed25519.dart';
import 'package:on_chain/tezos/src/crypto/types/signature.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';
import 'package:on_chain/tezos/src/crypto/utils/utils.dart';
import 'secret_key.dart';

/// Ed25519 secret key (tz1 / edpk / edsig).
class TezosEd25519SecretKey extends TezosSecretKey<TezosEd25519PublicKey> {
  final ED25519PrivateKey privateKey;

  const TezosEd25519SecretKey(this.privateKey)
    : super(type: TezosKeyType.ed25519);

  factory TezosEd25519SecretKey.fromBytes(List<int> bytes) {
    return TezosEd25519SecretKey(ED25519PrivateKey.fromBytes(bytes));
  }

  factory TezosEd25519SecretKey.random() {
    return TezosEd25519SecretKey(ED25519PrivateKey.random());
  }

  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  TezosEd25519PublicKey toPublicKey() =>
      TezosEd25519PublicKey(privateKey.publicKey);

  @override
  TezosSignature sign(List<int> digest) {
    final signer = ED25519Signer(privateKey);
    return TezosGenericSignature(signer.sign(digest).encoded);
  }

  @override
  List<dynamic> get variables => [privateKey];

  @override
  String encode({bool expanded = false}) {
    return TezosCryptoUtils.encodeSecretKey(this, ed25519Expanded: expanded);
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}
