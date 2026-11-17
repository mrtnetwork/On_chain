import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/hedera/src/crypto/public_key/secp256k1.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';

class HederaSecp256k1SecretKey extends HederaSecretKey<HederaSecp256k1PublicKey>
    implements HederaEthereumSigner {
  final Secp256k1PrivateKey privateKey;

  const HederaSecp256k1SecretKey(this.privateKey)
    : super(type: HederaKeyType.secp256k1);

  factory HederaSecp256k1SecretKey.fromBytes(List<int> bytes) {
    if (bytes.length != 32) {
      throw OnChainErrors.hederaPlugin(
        'HederaSecp256k1SecretKey.fromBytes',
        reason: 'Invalid secp256k1 secret key: expected 32 bytes.',
        details: {'length': '${bytes.length}'},
      );
    }
    return HederaSecp256k1SecretKey(Secp256k1PrivateKey.fromBytes(bytes));
  }
  factory HederaSecp256k1SecretKey.random() {
    return HederaSecp256k1SecretKey(Secp256k1PrivateKey.random());
  }
  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  HederaSecp256k1PublicKey toPublicKey() =>
      HederaSecp256k1PublicKey(privateKey.publicKey);

  @override
  BuBytes sign(List<int> message, {List<int>? extraEntropy}) {
    // Hedera ECDSA: keccak-256 hash of body, then secp256k1 sign.
    final signer = ETHSigner(Secp256k1Signer(privateKey));
    final signature = signer.sign(
      message,
      hashMessage: true,
      extraEntropy: extraEntropy,
    );
    return signature.signature.toBytes();
  }

  @override
  Future<List<int>> signEthereum(
    List<int> message, {
    List<int>? extraEntropy,
  }) async {
    // Hedera ECDSA: keccak-256 hash of body, then secp256k1 sign.
    final signer = ETHSigner(Secp256k1Signer(privateKey));
    final signature = signer.sign(
      message,
      hashMessage: true,
      extraEntropy: extraEntropy,
    );
    return signature.encoded;
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}
