import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/crypto/keypair/private_key/secret_key.dart';
import 'package:on_chain/algorand/src/crypto/keypair/public_key/ed25519.dart';

class AlgoEd25519SecretKey extends AlgoSecretKey<AlgoEd25519PublicKey> {
  final ED25519PrivateKey privateKey;
  const AlgoEd25519SecretKey(this.privateKey);
  factory AlgoEd25519SecretKey.fromBytes(List<int> bytes) {
    return AlgoEd25519SecretKey(ED25519PrivateKey.fromBytes(bytes));
  }

  @override
  SecretBytes toBytes() {
    return privateKey.toBytes();
  }

  @override
  AlgoEd25519PublicKey toPublicKey() {
    return AlgoEd25519PublicKey(privateKey.publicKey);
  }

  @override
  BuBytes sign(List<int> message) {
    final signer = ED25519Signer(privateKey);
    return signer.sign(message).encoded;
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}
