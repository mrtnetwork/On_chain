import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/crypto/public_key/public_key.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';

class TezosBlsPublicKey extends TezosPublicKey {
  final Bls12G1PublicKey publicKey;

  TezosBlsPublicKey(this.publicKey) : super(type: TezosKeyType.bls);

  factory TezosBlsPublicKey.fromBytes(List<int> bytes) =>
      TezosBlsPublicKey(Bls12G1PublicKey.fromBytes(bytes));

  @override
  BuBytes toBytes() {
    return publicKey.toBytes();
  }

  @override
  List<dynamic> get variables => [publicKey];

  @override
  bool verify(List<int> message, List<int> signature, {List<int>? domain}) {
    return publicKey.verify(
      Bls12G1VerifiyingParams(
        signature: Bls12G1Signature.fromBytes(signature),
        signingParams: Bls12SigningParams(
          message: message,
          dst: BlsG2Constants.popDst,
        ),
      ),
    );
  }
}
