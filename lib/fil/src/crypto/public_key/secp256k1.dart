import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/src/address/evm_address.dart';
import 'package:on_chain/fil/src/crypto/public_key/public_key.dart';
import 'package:on_chain/fil/src/crypto/types/types.dart';

class FilecoinSecp256k1PublicKey extends FilecoinPublicKey {
  final Secp256k1PublicKey publicKey;

  const FilecoinSecp256k1PublicKey(this.publicKey)
    : super(type: FilecoinKeyType.secp256k1);

  factory FilecoinSecp256k1PublicKey.fromBytes(List<int> bytes) =>
      FilecoinSecp256k1PublicKey(Secp256k1PublicKey.fromBytes(bytes));

  @override
  BuBytes toBytes({CryptoKeyEncoding encoding = CryptoKeyEncoding.base}) {
    return publicKey.toBytes(mode: encoding);
  }

  @override
  bool verifySignature(
    List<int> message,
    List<int> signature, {
    bool hashMessage = true,
  }) {
    final verifier = Secp256k1Verifier.fromKeyBytes(toBytes());
    return verifier.verify(
      message,
      IECDSASignature.fromBytes(signature),
      hashMessage: hashMessage,
    );
  }

  ETHAddress toEthAddress() {
    return ETHAddress.fromPublicKey(toBytes());
  }

  @override
  List<dynamic> get variables => [publicKey];
}
