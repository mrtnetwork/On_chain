import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/near/src/crypto/public_key/secp256k1.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';
import 'package:on_chain/near/src/crypto/utils/utils.dart';

class NearSecp256k1SecretKey extends NearSecretKey<NearSecp256k1PublicKey> {
  final Secp256k1PrivateKey privateKey;
  const NearSecp256k1SecretKey(this.privateKey)
    : super(type: NearKeyType.secp256k1);
  factory NearSecp256k1SecretKey.fromBytes(List<int> bytes) {
    if (bytes.length ==
        EcdsaKeysConst.privKeyByteLen +
            (EcdsaKeysConst.pubKeyUncompressedByteLen -
                EcdsaKeysConst.pubKeyUncompressedPrefix.length)) {
      final secretKey = bytes.sublist(0, EcdsaKeysConst.privKeyByteLen);
      final key = NearSecp256k1SecretKey(
        Secp256k1PrivateKey.fromBytes(secretKey),
      );
      if (!BytesUtils.bytesEqual(
        key.toPublicKey().toBytes(
          withPrefix: false,
          encoding: CryptoKeyEncoding.uncompressed,
        ),
        bytes.sublist(EcdsaKeysConst.privKeyByteLen),
      )) {
        throw OnChainErrors.nearPlugin(
          "NearSecp256k1SecretKey.fromBytes",
          reason: "Invalid Secp256k1 secret key.",
          details: {
            'expected':
                '${EcdsaKeysConst.privKeyByteLen + (EcdsaKeysConst.pubKeyUncompressedByteLen - EcdsaKeysConst.pubKeyUncompressedPrefix.length)}',
            'actual': '${bytes.length}',
          },
        );
      }
      return key;
    }
    return NearSecp256k1SecretKey(Secp256k1PrivateKey.fromBytes(bytes));
  }

  @override
  SecretBytes toBytes() {
    return privateKey.toBytes();
  }

  @override
  NearSecp256k1PublicKey toPublicKey() {
    return NearSecp256k1PublicKey(privateKey.publicKey);
  }

  @override
  String encode() {
    return privateKey.takeSecretKey().useValue(
      (k) => NearCryptoUtils.encodeKey(type, [
        ...k,
        ...toPublicKey().toBytes(
          encoding: CryptoKeyEncoding.uncompressed,
          withPrefix: false,
        ),
      ]),
    );
  }

  @override
  BuBytes sign(List<int> message, {List<int>? extraEntropy}) {
    final signer = ETHSigner(Secp256k1Signer(privateKey));
    final signature = signer.sign(
      message,
      hashMessage: false,
      extraEntropy: extraEntropy,
    );
    return signature.signature.toBytes(
      encoding: ECDSASignatureEncoding.suffixRecoveryId,
    );
  }

  @override
  void dispose() {
    privateKey.dispose();
  }

  @override
  List<dynamic> get variables => [privateKey];
}
