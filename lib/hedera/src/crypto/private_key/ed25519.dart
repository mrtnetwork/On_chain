import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/hedera/src/crypto/public_key/ed25519.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';

class HederaEd25519SecretKey extends HederaSecretKey<HederaEd25519PublicKey> {
  final ED25519PrivateKey privateKey;

  const HederaEd25519SecretKey(this.privateKey)
    : super(type: HederaKeyType.ed25519);

  factory HederaEd25519SecretKey.fromBytes(List<int> bytes) {
    if (bytes.length ==
        Ed25519KeysConst.privKeyByteLen + Ed25519KeysConst.pubKeyByteLen) {
      final secretKey = bytes.sublist(0, Ed25519KeysConst.privKeyByteLen);
      final key = HederaEd25519SecretKey(
        ED25519PrivateKey.fromBytes(secretKey),
      );
      if (!BytesUtils.bytesEqual(
        key.toPublicKey().toBytes(),
        bytes.sublist(Ed25519KeysConst.privKeyByteLen),
      )) {
        throw OnChainErrors.hederaPlugin(
          'HederaEd25519SecretKey.fromBytes',
          reason: 'Invalid Ed25519 secret key.',
          details: {
            'expected':
                '${Ed25519KeysConst.privKeyByteLen + Ed25519KeysConst.pubKeyByteLen}',
            'actual': '${bytes.length}',
          },
        );
      }
      return key;
    }
    return HederaEd25519SecretKey(ED25519PrivateKey.fromBytes(bytes));
  }
  factory HederaEd25519SecretKey.random() {
    return HederaEd25519SecretKey(ED25519PrivateKey.random());
  }

  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  HederaEd25519PublicKey toPublicKey() =>
      HederaEd25519PublicKey(privateKey.publicKey);

  @override
  BuBytes sign(List<int> message) {
    final signer = ED25519Signer(privateKey);
    return signer.sign(message).encoded;
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}
