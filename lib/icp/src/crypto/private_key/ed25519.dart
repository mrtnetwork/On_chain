import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/icp/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/icp/src/crypto/public_key/ed25519.dart';
import 'package:on_chain/icp/src/crypto/types/types.dart';

class ICPEd25519SecretKey extends ICPSecretKey<ICPEd25519PublicKey> {
  final ED25519PrivateKey privateKey;

  const ICPEd25519SecretKey(this.privateKey) : super(type: ICPKeyType.ed25519);

  factory ICPEd25519SecretKey.fromBytes(List<int> bytes) {
    if (bytes.length ==
        Ed25519KeysConst.privKeyByteLen + Ed25519KeysConst.pubKeyByteLen) {
      final secretKey = bytes.sublist(0, Ed25519KeysConst.privKeyByteLen);
      final key = ICPEd25519SecretKey(ED25519PrivateKey.fromBytes(secretKey));
      if (!BytesUtils.bytesEqual(
        key.toPublicKey().toBytes(),
        bytes.sublist(Ed25519KeysConst.privKeyByteLen),
      )) {
        throw OnChainErrors.icpPlugin(
          'ICPEd25519SecretKey.fromBytes',
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
    return ICPEd25519SecretKey(ED25519PrivateKey.fromBytes(bytes));
  }
  factory ICPEd25519SecretKey.random() {
    return ICPEd25519SecretKey(ED25519PrivateKey.random());
  }

  @override
  ICPEd25519PublicKey toPublicKey() =>
      ICPEd25519PublicKey(privateKey.publicKey);

  @override
  BuBytes sign(List<int> message) {
    final signer = ED25519Signer(privateKey);
    return signer.sign(message).encoded;
  }

  @override
  SecretBytes toBytes() => privateKey.toBytes();

  @override
  void dispose() {
    privateKey.dispose();
  }

  @override
  List<dynamic> get variables => [privateKey];
}
