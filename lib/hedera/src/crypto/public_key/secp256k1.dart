import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/hedera/src/crypto/public_key/public_key.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';

class HederaSecp256k1PublicKey extends HederaPublicKey {
  final Secp256k1PublicKey publicKey;

  const HederaSecp256k1PublicKey(this.publicKey)
    : super(type: HederaKeyType.secp256k1);

  factory HederaSecp256k1PublicKey.fromBytes(List<int> bytes) =>
      HederaSecp256k1PublicKey(Secp256k1PublicKey.fromBytes(bytes));

  @override
  BuBytes toBytes({
    CryptoKeyEncoding encoding = CryptoKeyEncoding.base,
    bool withPrefix = true,
  }) {
    final bytes = publicKey.toBytes(mode: encoding);
    return switch (encoding) {
      CryptoKeyEncoding.uncompressed when !withPrefix => bytes.sublist(
        EcdsaKeysConst.pubKeyUncompressedPrefix.length,
      ),
      _ => bytes,
    };
  }

  @override
  bool verifySignature(List<int> message, List<int> signature) {
    final verifier = ETHVerifier(Secp256k1Verifier(publicKey));
    return verifier.verify(message, signature, hashMessage: true);
  }

  @override
  List<dynamic> get variables => [publicKey];

  @override
  HederaKey toHederaKey() => HederaKey(ecdsaSecp256k1: toBytes());
}
