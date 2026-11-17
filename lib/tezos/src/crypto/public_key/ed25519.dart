import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';
import 'public_key.dart';

/// Ed25519 public key (32 bytes, no DER, no prefix).
class TezosEd25519PublicKey extends TezosPublicKey {
  final ED25519PublicKey publicKey;
  TezosEd25519PublicKey(this.publicKey) : super(type: TezosKeyType.ed25519);
  factory TezosEd25519PublicKey.fromBytes(List<int> bytes) {
    return TezosEd25519PublicKey(ED25519PublicKey.fromBytes(bytes));
  }

  @override
  BuBytes toBytes() {
    return publicKey.toBytes();
  }

  @override
  bool verify(List<int> message, List<int> signature) {
    final verifier = ED25519Verifier(publicKey);
    return verifier.verify(message, ED25519Signature.fromBytes(signature));
  }

  @override
  List<dynamic> get variables => [publicKey];
}
