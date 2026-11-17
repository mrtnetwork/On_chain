import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/crypto/public_key/bls12.dart';
import 'package:on_chain/fil/src/crypto/public_key/public_key.dart';
import 'package:on_chain/fil/src/crypto/types/types.dart';

class FilBls12AggrPublicKey extends FilecoinPublicKey {
  final Bls12G1AggregatePublicKey publicKey;

  const FilBls12AggrPublicKey(this.publicKey)
    : super(type: FilecoinKeyType.bls12);

  factory FilBls12AggrPublicKey.fromBytes(List<int> bytes) =>
      FilBls12AggrPublicKey(Bls12G1AggregatePublicKey.fromBytes(bytes));
  factory FilBls12AggrPublicKey.fromPubKeys(List<FilBls12PublicKey> keys) =>
      FilBls12AggrPublicKey(
        Bls12G1AggregatePublicKey.fromPubKeys(
          keys.map((e) => e.publicKey).toList(),
        ),
      );

  @override
  BuBytes toBytes() {
    return publicKey.toBytes();
  }

  @override
  bool verifySignature(List<int> message, List<int> signature) {
    return BlsMinPubkeyAggregateUtils.fastAggregateVerify(
      aggregatePublicKey: publicKey.toBytes(),
      message: message,
      aggregateSignature: Bls12G1Signature.fromBytes(signature),
      dst: BlsG2Constants.defaultBlsDst,
    );
  }

  @override
  List<dynamic> get variables => [publicKey];
}
