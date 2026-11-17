import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/fil/src/crypto/cid/cid.dart';
import 'package:on_chain/fil/src/crypto/private_key/secp256k1.dart';
import 'package:on_chain/fil/src/crypto/private_key/bls12.dart';
import 'package:on_chain/fil/src/crypto/public_key/public_key.dart';
import 'package:on_chain/fil/src/crypto/types/types.dart';
import 'package:on_chain/fil/src/types/message/message.dart';

abstract class FilSecretKey<PK extends FilecoinPublicKey>
    with SecretState
    implements FilSigner {
  final FilecoinKeyType type;
  const FilSecretKey({required this.type});

  factory FilSecretKey.fromBytes({
    required List<int> keyBytes,
    required FilecoinKeyType type,
  }) {
    final FilSecretKey secretKey = switch (type) {
      FilecoinKeyType.secp256k1 => FilSecp256k1SecretKey.fromBytes(keyBytes),
      FilecoinKeyType.bls12 => FilBls12SecretKey.fromBytes(keyBytes),
    };
    return secretKey.cast();
  }

  SecretBytes toBytes();

  PK toPublicKey();

  FilSignature sign(List<int> message);

  bool verifySignature(List<int> message, List<int> signature) =>
      toPublicKey().verifySignature(message, signature);

  T cast<T extends FilSecretKey>() {
    if (this is! T) {
      throw OnChainErrors.filPlugin(
        "FilSecretKey.cast",
        reason: "Invalid secret key cast.",
        details: {"expected": "$T", "actual": "$runtimeType"},
      );
    }
    return this as T;
  }

  @override
  Future<FilSignature> signAsync(List<int> message) async {
    return sign(message);
  }

  @override
  Future<FilSignedMessage> signFilMessage(FilMessage message) async {
    final cid = CidBuilder.filecoinDagCbor(message.toCbor().encode());
    final signature = sign(cid.toBinary());
    return FilSignedMessage(message: message, signature: signature);
  }
}
