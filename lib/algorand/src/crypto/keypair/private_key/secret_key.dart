import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/builder/src/signer.dart';
import 'package:on_chain/algorand/src/crypto/keypair/private_key/ed25519.dart';
import 'package:on_chain/algorand/src/crypto/keypair/public_key/public_key.dart';

import 'package:on_chain/algorand/src/transaction/src/signatures.dart';
import 'package:on_chain/algorand/src/transaction/src/transaction.dart';
import 'package:on_chain/algorand/src/types/types.dart';
import 'package:on_chain/algorand/src/utils/utils.dart';

/// Abstract Algorand secret key with domain-separated signing helpers.
///
/// Concrete implementations (e.g. [AlgoEd25519SecretKey]) provide the raw
/// [sign] primitive; this base class adds transaction, bid, bytes, TEAL,
/// and program signing, plus [AlgoTransactionSigner] integration.
abstract class AlgoSecretKey<PK extends AlgoPublicKey>
    with SecretState
    implements AlgoTransactionSigner {
  const AlgoSecretKey();

  /// Reconstructs a secret key from raw private-key bytes.
  /// Currently resolves to an Ed25519 secret key.
  factory AlgoSecretKey.fromBytes(List<int> keyBytes) {
    return AlgoEd25519SecretKey.fromBytes(keyBytes).cast();
  }

  /// Serializes the secret key to its raw byte representation.
  SecretBytes toBytes();

  /// Derives the corresponding public key.
  PK toPublicKey();

  /// Signs an arbitrary message with the underlying signature scheme.
  /// Domain separation (prefixes) is applied by the higher-level helpers.
  BuBytes sign(List<int> message);

  /// Signs a transaction for submission.
  /// Message = "TX" || msgpack(transaction).
  BuBytes rawSignTransaction(AlgoTransaction transaction) {
    final bytes = transaction.rawTransactionBytesToSign();
    return sign(bytes);
  }

  /// Signs an auction bid and wraps it in a [NoteFieldType.bid] note field.
  /// Message = "aB" || msgpack(bid).
  BuBytes signBid(AlgoTypesBid bid) {
    final data = [...AlgoUtils.bidPrefix, ...bid.toSerializeBytes()];
    final signature = sign(data);
    final field = AlgoTypesNoteField(
      type: NoteFieldType.bid,
      signedBid: AlgoTypesSignedBid(bid: bid, sig: signature),
    );
    return field.toSerializeBytes();
  }

  /// Signs arbitrary bytes with the "MX" domain-separation prefix.
  /// Message = "MX" || message.
  BuBytes signBytes(List<int> message) {
    final data = [...AlgoUtils.bytesPrefix, ...message];
    return sign(data);
  }

  /// Signs data for a TEAL contract account (ProgData domain).
  /// Message = "ProgData" || contractAddr || data.
  BuBytes tealSign(List<int> data, AlgoAddress contractAddr) {
    final message = [
      ...AlgoUtils.programDataPrefix,
      ...contractAddr.toBytes(),
      ...data,
    ];
    return sign(message);
  }

  /// Signs a TEAL program for a logic signature.
  /// Message = "Program" || program (the delegated-signature message defined
  /// by the Algorand specs; the escrow address is the SHA-512/256 of it).
  BuBytes signProgram(List<int> program) {
    return sign(AlgoUtils.programToSign(program));
  }

  /// Signs [tx] asynchronously and returns an [AlgoSignedTxn].
  /// Sets [authAddr] when the transaction sender is not this key's address
  /// (rekey / delegated signing).
  @override
  Future<AlgoSignedTxn> signTransactionsAsync(AlgoTransaction tx) async {
    final signature = rawSignTransaction(tx);
    final addr = tx.sender;
    final signerAddress = toPublicKey().toAddress();
    if (addr != signerAddress) {
      return AlgoSignedTxn(
        transaction: tx,
        signature: signature,
        authAddr: signerAddress,
      );
    }
    return AlgoSignedTxn(transaction: tx, signature: signature);
  }

  /// Builds a signed transaction for dry-run / simulate without a real signature.
  /// Uses a fixed placeholder signature of all `0x01` bytes.
  @override
  Future<AlgoSignedTxn> signSimulateTransactionsAsync(
    AlgoTransaction tx,
  ) async {
    final signature = List<int>.filled(
      CryptoSignerConst.ed25519SignatureLength,
      1,
    );
    final addr = tx.sender;
    final signerAddress = toPublicKey().toAddress();
    if (addr != signerAddress) {
      return AlgoSignedTxn(
        transaction: tx,
        signature: signature,
        authAddr: signerAddress,
      );
    }
    return AlgoSignedTxn(transaction: tx, signature: signature);
  }

  /// Down-casts this key to a concrete [AlgoEd25519SecretKey] subtype [T].
  T cast<T extends AlgoSecretKey>() {
    if (this is! T) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Invalid Algorand secret key type.',
        details: {'expected': '$T', 'actual': runtimeType.toString()},
      );
    }
    return this as T;
  }
}
