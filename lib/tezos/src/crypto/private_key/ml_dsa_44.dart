import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/crypto/public_key/ml_dsa_44.dart';
import 'package:on_chain/tezos/src/crypto/types/signature.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';
import 'package:on_chain/tezos/src/operations/operations/group.dart';
import 'secret_key.dart';

class TezosMLDSA44SecretKey extends TezosSecretKey<TezosMLDSA44PublicKey> {
  final MLDSA44PrivateKey privateKey;

  const TezosMLDSA44SecretKey._(this.privateKey)
    : super(type: TezosKeyType.mlDsa);

  factory TezosMLDSA44SecretKey.from(MLDSA44PrivateKey privateKey) {
    return TezosMLDSA44SecretKey._(privateKey);
  }

  factory TezosMLDSA44SecretKey.fromBytes(List<int> bytes) =>
      TezosMLDSA44SecretKey._(MLDSA44PrivateKey.fromBytes(bytes));

  factory TezosMLDSA44SecretKey.random({List<int>? seed}) {
    return TezosMLDSA44SecretKey._(MLDSA44PrivateKey.generate(seed: seed));
  }

  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  TezosMLDSA44PublicKey toPublicKey() {
    return TezosMLDSA44PublicKey.from(privateKey.verificationKey());
  }

  @override
  TezosSignature sign(
    List<int> digest, {
    List<int>? context,
    List<int>? nonce,
  }) {
    final signature = privateKey.sign(
      MLDSASigningParams(digest, context: context, nonce: nonce),
    );
    return TezosMlDsa44Signature(signature.bytes);
  }

  @override
  Future<TezosOperationGroup> signOperation(
    TezosOperationGroup operation,
  ) async {
    final signDigest = operation.signedDigest(hash: false);
    final signature = await signAsync(signDigest);
    return operation.copyWith(signature: signature);
  }

  @override
  List<dynamic> get variables => [privateKey];

  @override
  void dispose() {
    privateKey.dispose();
  }
}
