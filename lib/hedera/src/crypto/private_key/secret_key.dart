import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/hedera/src/crypto/private_key/ecdsa384.dart';
import 'package:on_chain/hedera/src/crypto/private_key/ed25519.dart';
import 'package:on_chain/hedera/src/crypto/private_key/rsa3072.dart';
import 'package:on_chain/hedera/src/crypto/private_key/secp256k1.dart';
import 'package:on_chain/hedera/src/crypto/public_key/public_key.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';
import 'package:on_chain/hedera/src/crypto/utils/utils.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/basic_types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/transaction.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/src/transaction_contents.dart';

/// Secret key that can sign Hedera transactions ([HederaSigner]).
abstract class HederaSecretKey<PK extends HederaPublicKey>
    with SecretState
    implements HederaSigner {
  final HederaKeyType type;
  const HederaSecretKey({required this.type});

  factory HederaSecretKey.fromBytes({
    required List<int> keyBytes,
    required HederaKeyType type,
  }) {
    final HederaSecretKey secretKey = switch (type) {
      HederaKeyType.ed25519 => HederaEd25519SecretKey.fromBytes(keyBytes),
      HederaKeyType.secp256k1 => HederaSecp256k1SecretKey.fromBytes(keyBytes),
      HederaKeyType.ecdsa384 => HederaEcdsa384SecretKey.fromBytes(keyBytes),
      HederaKeyType.rsa3072 => HederaRsa3072SecretKey.fromBytes(keyBytes),
    };
    return secretKey.cast();
  }

  SecretBytes toBytes();

  PK toPublicKey();

  /// Sign raw message bytes (usually serialized [HederaTransactionBody]).
  BuBytes sign(List<int> message);

  bool verifySignature(List<int> message, List<int> signature) =>
      toPublicKey().verifySignature(message, signature);

  T cast<T extends HederaSecretKey>() {
    if (this is! T) {
      throw OnChainErrors.hederaPlugin(
        "HederaSecretKey.cast",
        reason: "Invalid key cast.",
        details: {"expected": "$T", "actual": "$runtimeType"},
      );
    }
    return this as T;
  }

  /// Build a single [HederaSignaturePair] for [message].
  HederaSignaturePair signToPair(List<int> message) {
    final pk = toPublicKey();
    return HederaCryptoUtils.buildSignaturePair(
      type: type,
      publicKeyBytes: pk.toBytes(),
      signature: sign(message),
    );
  }

  /// Sign body and wrap as a complete [HederaTransaction].
  HederaTransaction signAndGetSignedTransaction(HederaTransactionBody body) {
    final pairs = [signToPair(body.toBuffer())];
    final signedTx = HederaSignedTransaction(
      bodyBytes: body.toBuffer(),
      sigMap: HederaSignatureMap(sigPair: pairs),
    );
    return HederaTransaction(signedTransactionBytes: signedTx.toBuffer());
  }

  @override
  Future<List<HederaSignaturePair>> signTransaction(
    HederaTransactionBody txBody,
  ) async {
    return [signToPair(txBody.toBuffer())];
  }

  @override
  Future<HederaTransaction> signQueryPaymentTransaction({
    required HederaTransactionBody body,
    required dynamic query,
    required BigInt cost,
  }) async {
    return signAndGetSignedTransaction(body);
  }
}
