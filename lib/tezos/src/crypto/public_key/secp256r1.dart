import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tezos/src/crypto/types/types.dart';

import 'public_key.dart';

/// NIST P-256 public key.
class TezosSecp256r1PublicKey extends TezosPublicKey {
  final Secp256r1PublicKey publicKey;

  TezosSecp256r1PublicKey(this.publicKey) : super(type: TezosKeyType.secp256r1);

  factory TezosSecp256r1PublicKey.fromBytes(List<int> bytes) =>
      TezosSecp256r1PublicKey(Secp256r1PublicKey.fromBytes(bytes));

  @override
  BuBytes toBytes({CryptoKeyEncoding encoding = CryptoKeyEncoding.base}) {
    return publicKey.toBytes(mode: encoding);
  }

  @override
  bool verify(List<int> message, List<int> signature) {
    final verifier = Secp256r1Verifier(publicKey);
    return verifier.verify(
      message,
      IECDSASignature.fromBytes(signature),
      hashMessage: false,
    );
  }

  @override
  List<dynamic> get variables => [publicKey];
}
