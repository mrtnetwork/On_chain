import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/near/src/crypto/private_key/ed25519.dart';
import 'package:on_chain/near/src/crypto/private_key/mldsa65.dart';
import 'package:on_chain/near/src/crypto/private_key/secp256k1.dart';
import 'package:on_chain/near/src/crypto/public_key/public_key.dart';
import 'package:on_chain/near/src/crypto/utils/utils.dart';
import 'package:on_chain/near/src/transaction/src/action.dart';
import 'package:on_chain/near/src/crypto/types/types.dart';
import 'package:on_chain/near/src/transaction/src/transaction.dart';

abstract class NearSecretKey<PK extends NearPublicKey>
    with Equality, SecretState {
  final NearKeyType type;
  const NearSecretKey({required this.type});

  factory NearSecretKey.deserialize(String key) {
    final decode = NearCryptoUtils.decodeKey(key);
    return NearSecretKey.fromBytes(
      keyBytes: decode.keyBytes,
      type: decode.type,
    );
  }
  factory NearSecretKey.fromBytes({
    required List<int> keyBytes,
    required NearKeyType type,
  }) {
    final NearSecretKey secretKey = switch (type) {
      NearKeyType.ed25519 => NearEd25519SecretKey.fromBytes(keyBytes),
      NearKeyType.secp256k1 => NearSecp256k1SecretKey.fromBytes(keyBytes),
      NearKeyType.mldsa65 => NearMLDSA65SecretKey.fromBytes(keyBytes),
    };
    return secretKey.cast();
  }

  SecretBytes toBytes();

  PK toPublicKey();

  T cast<T extends NearSecretKey>() {
    if (this is! T) {
      throw OnChainErrors.nearPlugin(
        "NearSecretKey.cast",
        reason: "Invalid key cast.",
        details: {"expected": "$T", "actual": "$runtimeType"},
      );
    }
    return this as T;
  }

  BuBytes sign(List<int> message);
  bool verifySignature(List<int> message, List<int> signature) =>
      toPublicKey().verifySignature(message, signature);
  String encode() => NearCryptoUtils.encodeKey(type, toBytes());
  NearSignedTransactionWithHash signTransaction(NearTransaction transaction) {
    if (transaction.publicKey != toPublicKey()) {
      throw OnChainErrors.nearPlugin(
        "NearSecretKey.signTransaction",
        reason: "Mismatch transaction signer ID.",
      );
    }
    final bytes = transaction.toSerializeBytes();
    final hash = QuickCrypto.sha256Hash(bytes).asImmutableBytes;
    final signature = sign(hash);
    final signedTransaction = NearSignedTransaction(
      transaction: transaction,
      signature: NearSignature.fromKeyType(keyType: type, data: signature),
    );
    return NearSignedTransactionWithHash(
      signedTransaction: signedTransaction,
      hash: hash,
    );
  }

  Nep413SignedMessage signNep413Message(
    String accountId,
    Nep413MessagePayload payload, {
    String? state,
  }) {
    final message = payload.encodeSign();
    final signature = sign(message);
    return Nep413SignedMessage(
      accountId: accountId,
      publicKey: toPublicKey(),
      signature: signature,
      state: state,
    );
  }

  NearSignedDelegateAction signDelegateAction(NearDelegateAction delegate) {
    if (delegate.publicKey != toPublicKey()) {
      throw OnChainErrors.nearPlugin(
        "NearSecretKey.signDelegateAction",
        reason: "Mismatch delegate public key.",
      );
    }
    final hash = delegate.encodeSign().asImmutableBytes;
    final signature = sign(hash);
    return NearSignedDelegateAction(
      delegate: NearSignedDelegate(
        delegateAction: delegate,
        signature: NearSignature.fromKeyType(keyType: type, data: signature),
      ),
      hash: hash,
    );
  }
}
