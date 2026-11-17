import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/tezos/src/crypto/public_key/bls12.dart';
import 'package:on_chain/tezos/src/crypto/types/signature.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';
import 'package:on_chain/tezos/src/operations/operations/group.dart';

class TezosBlsSecretKey extends TezosSecretKey<TezosBlsPublicKey> {
  final Bls12G1PrivateKey privateKey;
  const TezosBlsSecretKey(this.privateKey) : super(type: TezosKeyType.bls);
  factory TezosBlsSecretKey.fromBytes(List<int> bytes) =>
      TezosBlsSecretKey(Bls12G1PrivateKey.fromBytes(bytes));
  factory TezosBlsSecretKey.random() =>
      TezosBlsSecretKey(Bls12G1PrivateKey.random());
  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  TezosBlsPublicKey toPublicKey() => TezosBlsPublicKey(privateKey.publicKey);

  @override
  TezosBlsSignature sign(List<int> digest, {List<int>? domain}) {
    final signature = privateKey.sign(
      Bls12SigningParams(message: digest, dst: domain ?? BlsG2Constants.popDst),
    );
    return TezosBlsSignature(signature.signature.toBytes());
  }

  @override
  Future<TezosBlsSignature> signAsync(
    List<int> digest, {
    List<int>? domain,
  }) async {
    return sign(digest, domain: domain);
  }

  Future<TezosBlsSignature> proof() async {
    const proofDomain = "BLS_POP_BLS12381G2_XMD:SHA-256_SSWU_RO_POP_";
    return signAsync(
      toPublicKey().toBytes(),
      domain: StringUtils.encode(proofDomain),
    );
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
