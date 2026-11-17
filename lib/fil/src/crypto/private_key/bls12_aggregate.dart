import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/fil/src/crypto/public_key/bls12_aggregate.dart';
import 'package:on_chain/fil/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/fil/src/crypto/types/types.dart';

class FilBls12AggrSecretKey extends FilSecretKey<FilBls12AggrPublicKey> {
  final Bls12G1AggregatePrivateKey privateKey;

  const FilBls12AggrSecretKey(this.privateKey)
    : super(type: FilecoinKeyType.bls12);

  factory FilBls12AggrSecretKey.fromSecretKeys(List<Bls12G1PrivateKey> keys) =>
      FilBls12AggrSecretKey(Bls12G1AggregatePrivateKey.fromSecretKeys(keys));
  factory FilBls12AggrSecretKey.fromBytes(List<int> bytes) =>
      FilBls12AggrSecretKey(Bls12G1AggregatePrivateKey.fromBytes(bytes));
  factory FilBls12AggrSecretKey.random({int length = 2}) =>
      FilBls12AggrSecretKey.fromSecretKeys(
        List.generate(length, (_) => Bls12G1PrivateKey.random()),
      );

  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  FilBls12AggrPublicKey toPublicKey() =>
      FilBls12AggrPublicKey(privateKey.publicKey);

  @override
  FilSignature sign(List<int> message) {
    final signature = privateKey.signFast(
      Bls12FastAggregateSigningParams(
        message: message,
        dst: BlsG2Constants.defaultBlsDst,
      ),
    );
    return FilSignature(type: FilSigType.bls, data: signature.toBytes());
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}
