import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/crypto/public_key/public_key.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';

class HederaEd25519PublicKey extends HederaPublicKey {
  final ED25519PublicKey publicKey;

  const HederaEd25519PublicKey(this.publicKey)
    : super(type: HederaKeyType.ed25519);

  factory HederaEd25519PublicKey.fromBytes(List<int> bytes) =>
      HederaEd25519PublicKey(ED25519PublicKey.fromBytes(bytes));

  @override
  BuBytes toBytes() {
    return publicKey.toBytes();
  }

  @override
  bool verifySignature(List<int> message, List<int> signature) {
    final verifier = ED25519Verifier(publicKey);
    return verifier.verify(message, ED25519Signature.fromBytes(signature));
  }

  @override
  List<dynamic> get variables => [publicKey];

  @override
  HederaKey toHederaKey() => HederaKey(ed25519: toBytes());
}
