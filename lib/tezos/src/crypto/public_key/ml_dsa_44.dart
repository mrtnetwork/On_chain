import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';
import 'public_key.dart';

class TezosMLDSA44PublicKey extends TezosPublicKey {
  final MLDSA44PublicKey publicKey;

  TezosMLDSA44PublicKey._(this.publicKey) : super(type: TezosKeyType.mlDsa);
  factory TezosMLDSA44PublicKey.from(MLDSA44PublicKey publicKey) {
    return TezosMLDSA44PublicKey._(publicKey);
  }

  factory TezosMLDSA44PublicKey.fromBytes(List<int> bytes) =>
      TezosMLDSA44PublicKey._(MLDSA44PublicKey.fromBytes(bytes));

  @override
  BuBytes toBytes() {
    return publicKey.toBytes();
  }

  @override
  bool verify(List<int> message, List<int> signature, {List<int>? context}) {
    return publicKey.verify(
      MLDSAVerifyingParams(
        message,
        MLDSASignature(signature),
        context: context,
      ),
    );
  }

  @override
  List<dynamic> get variables => [publicKey];
}
