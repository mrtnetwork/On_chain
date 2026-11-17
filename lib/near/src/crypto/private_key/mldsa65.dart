import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/near/src/crypto/private_key/secret_key.dart';
import 'package:on_chain/near/src/crypto/public_key/mldsa65.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';

class NearMLDSA65SecretKey extends NearSecretKey<NearMLDSA65PublicKey> {
  final MLDSA65PrivateKey privateKey;
  NearMLDSA65SecretKey._(this.privateKey) : super(type: NearKeyType.mldsa65);
  factory NearMLDSA65SecretKey.from(MLDSA65PrivateKey privateKey) {
    return NearMLDSA65SecretKey._(privateKey);
  }
  factory NearMLDSA65SecretKey.fromBytes(List<int> bytes) {
    return NearMLDSA65SecretKey.from(MLDSA65PrivateKey.fromBytes(bytes));
  }
  @override
  SecretBytes toBytes() {
    return privateKey.toBytes();
  }

  @override
  NearMLDSA65PublicKey toPublicKey() {
    return NearMLDSA65PublicKey.from(privateKey.verificationKey());
  }

  @override
  BuBytes sign(List<int> message, {List<int>? context, List<int>? nonce}) {
    return privateKey
        .sign(MLDSASigningParams(message, context: context, nonce: nonce))
        .bytes;
  }

  @override
  void dispose() {
    privateKey.dispose();
  }

  @override
  List<dynamic> get variables => [privateKey];
}
