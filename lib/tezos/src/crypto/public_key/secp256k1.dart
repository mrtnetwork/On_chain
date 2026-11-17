import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';
import 'public_key.dart';

/// secp256k1 public key (compressed by default). No DER.
class TezosSecp256k1PublicKey extends TezosPublicKey {
  final Secp256k1PublicKey publicKey;

  TezosSecp256k1PublicKey(this.publicKey) : super(type: TezosKeyType.secp256k1);

  factory TezosSecp256k1PublicKey.fromBytes(List<int> bytes) =>
      TezosSecp256k1PublicKey(Secp256k1PublicKey.fromBytes(bytes));

  @override
  BuBytes toBytes({CryptoKeyEncoding encoding = CryptoKeyEncoding.base}) {
    return publicKey.toBytes(mode: encoding);
  }

  @override
  bool verify(List<int> message, List<int> signature) {
    final verifier = Secp256k1Verifier.fromKeyBytes(toBytes());
    return verifier.verify(
      message,
      IECDSASignature.fromBytes(signature),
      hashMessage: false,
    );
  }

  @override
  List<dynamic> get variables => [publicKey];
}
