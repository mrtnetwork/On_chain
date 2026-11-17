import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/near/src/crypto/public_key/ed25519.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';
import 'package:on_chain/near/src/crypto/utils/utils.dart';

class NearEd25519SecretKey extends NearSecretKey<NearEd25519PublicKey> {
  final ED25519PrivateKey privateKey;
  const NearEd25519SecretKey(this.privateKey)
    : super(type: NearKeyType.ed25519);
  factory NearEd25519SecretKey.fromBytes(List<int> bytes) {
    if (bytes.length ==
        Ed25519KeysConst.privKeyByteLen + Ed25519KeysConst.pubKeyByteLen) {
      final secretKey = bytes.sublist(0, Ed25519KeysConst.privKeyByteLen);
      final key = NearEd25519SecretKey(ED25519PrivateKey.fromBytes(secretKey));
      if (!BytesUtils.bytesEqual(
        key.toPublicKey().toBytes(),
        bytes.sublist(Ed25519KeysConst.privKeyByteLen),
      )) {
        throw OnChainErrors.nearPlugin(
          "NearEd25519SecretKey.fromBytes",
          reason: "Invalid Ed25519 secret key.",
          details: {
            'expected':
                '${Ed25519KeysConst.privKeyByteLen + Ed25519KeysConst.pubKeyByteLen}',
            'actual': '${bytes.length}',
          },
        );
      }
      return key;
    }
    return NearEd25519SecretKey(ED25519PrivateKey.fromBytes(bytes));
  }

  @override
  String encode() {
    return privateKey.sk.useValue(
      (k) =>
          NearCryptoUtils.encodeKey(type, [...k, ...toPublicKey().toBytes()]),
    );
  }

  @override
  SecretBytes toBytes() {
    return privateKey.toBytes();
  }

  @override
  NearEd25519PublicKey toPublicKey() {
    return NearEd25519PublicKey(privateKey.publicKey);
  }

  @override
  BuBytes sign(List<int> message) {
    final signer = ED25519Signer(privateKey);
    return signer.sign(message).encoded;
  }

  @override
  void dispose() {
    privateKey.dispose();
  }

  @override
  List<dynamic> get variables => [privateKey];
}
