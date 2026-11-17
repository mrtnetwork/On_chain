import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/crypto/keypair/public_key/public_key.dart';
import 'package:on_chain/algorand/src/address/address.dart';

class AlgoEd25519PublicKey extends AlgoPublicKey {
  final ED25519PublicKey publicKey;
  const AlgoEd25519PublicKey(this.publicKey) : super();
  factory AlgoEd25519PublicKey.fromBytes(List<int> bytes) =>
      AlgoEd25519PublicKey(ED25519PublicKey.fromBytes(bytes));
  static AlgoEd25519PublicKey? tryFromBytes(List<int> bytes) {
    try {
      return AlgoEd25519PublicKey(ED25519PublicKey.fromBytes(bytes));
    } catch (_) {
      return null;
    }
  }

  @override
  BuBytes toBytes() {
    return publicKey.toBytes();
  }

  @override
  List<dynamic> get variables => [publicKey];

  @override
  AlgoAddress toAddress() {
    return AlgoAddress.fromBytes(toBytes());
  }

  @override
  bool verify(List<int> message, List<int> signature) {
    final verifier = ED25519Verifier(publicKey);
    return verifier.verify(message, ED25519Signature.fromBytes(signature));
  }
}
