import 'package:blockchain_utils/blockchain_utils.dart';

import 'package:on_chain/exception/onchain_error.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/address_lockup_table/accounts/accounts/account_lookup_table.dart';
import 'package:on_chain/solana/src/keypair/private_key.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/transaction/constant/solana_transaction_constant.dart';
import 'package:on_chain/solana/src/transaction/core/core.dart';
import 'package:on_chain/solana/src/transaction/message/transaction_v1_config.dart';
import 'package:on_chain/solana/src/transaction/utils/utils.dart';

class TransactionSerializeEncoding {
  final String name;
  const TransactionSerializeEncoding._(this.name);
  static const TransactionSerializeEncoding base58 =
      TransactionSerializeEncoding._('base58');
  static const TransactionSerializeEncoding base64 =
      TransactionSerializeEncoding._('base64');
  static const TransactionSerializeEncoding hex =
      TransactionSerializeEncoding._('hex');
  String encode(List<int> data) {
    switch (this) {
      case TransactionSerializeEncoding.base58:
        return Base58Encoder.encode(data);
      case TransactionSerializeEncoding.base64:
        return StringUtils.decode(data, encoding: StringEncoding.base64);
      default:
        return BytesUtils.toHexString(data);
    }
  }
}

/// A class representing a Solana transaction.
class SolanaTransaction {
  /// The type of the transaction.
  TransactionType get type => message.version;

  /// The message of the transaction.
  final VersionedMessage message;

  /// The serialized message of the transaction.
  final List<int> _serializeMessage;

  /// The signatures of the transaction.
  List<List<int>> _signatures;

  /// Gets the signatures of the transaction.
  List<List<int>> get signatures => _signatures;

  /// Constructs a [SolanaTransaction] with required parameters.
  SolanaTransaction._(this._signatures, {required this.message})
    : _serializeMessage = List<int>.unmodifiable(message.serialize());

  /// Constructs a Solana transaction with provided parameters.
  factory SolanaTransaction({
    required SolAddress payerKey,
    required List<TransactionInstruction> instructions,
    required SolAddress recentBlockhash,
    List<List<int>> signatures = const [],
    TransactionType? type,
    List<AddressLookupTableAccount> addressLookupTableAccounts = const [],
    TransactionV1Config config = const TransactionV1Config.empty(),
  }) {
    if (type == null) {
      if (addressLookupTableAccounts.isNotEmpty) {
        type = TransactionType.v0;
      } else {
        type = TransactionType.legacy;
      }
    } else {
      if (type == TransactionType.legacy &&
          addressLookupTableAccounts.isNotEmpty) {
        throw const BuError(
          DefaultErrorType.invalidAddress,
          'Do not use addressLookupTableAccounts in legacy transactions.',
        );
      }
      if (type == TransactionType.v1 && addressLookupTableAccounts.isNotEmpty) {
        throw const BuError(
          DefaultErrorType.unsupported,
          'V1 transactions do not support address lookup tables.',
        );
      }
    }
    VersionedMessage message;
    if (type == TransactionType.legacy) {
      message = VersionedMessage.toLegacy(
        payerKey: payerKey,
        recentBlockhash: recentBlockhash,
        instructions: instructions,
      );
    } else if (type == TransactionType.v1) {
      message = VersionedMessage.toV1(
        payerKey: payerKey,
        recentBlockhash: recentBlockhash,
        instructions: instructions,
        config: config,
      );
    } else {
      message = VersionedMessage.toV0(
        payerKey: payerKey,
        recentBlockhash: recentBlockhash,
        instructions: instructions,
        addressLookupTableAccounts: addressLookupTableAccounts,
      );
    }
    if (signatures.isNotEmpty) {
      if (signatures.length != message.header.numRequiredSignatures) {
        throw const BuError(
          DefaultErrorType.invalidLength,
          'The expected length of signatures should match the number of required signatures.',
        );
      }
    } else {
      signatures = List.generate(
        message.header.numRequiredSignatures,
        (index) => List<int>.unmodifiable(
          List<int>.filled(SolanaTransactionConstant.signatureLengthInBytes, 0),
        ),
      );
    }
    return SolanaTransaction._(
      List<List<int>>.unmodifiable(signatures),
      message: message,
    );
  }

  /// Deserializes a Solana transaction from a serialized buffer.
  factory SolanaTransaction.deserialize(
    List<int> serializedTransaction, {
    bool verifySignatures = false,
  }) {
    final emptySignatureBytes = List<int>.unmodifiable(
      List<int>.filled(SolanaTransactionConstant.signatureLengthInBytes, 0),
    );
    final message = SolanaTransactionUtils.deserializeTransaction(
      serializedTransaction,
    );

    final transaction = SolanaTransaction._(
      List.generate(
        message.$1.header.numRequiredSignatures,
        (index) => List<int>.unmodifiable(emptySignatureBytes),
      ),
      message: message.$1,
    );
    final signerPubkeys = message.$1.accountKeys.sublist(
      0,
      message.$1.header.numRequiredSignatures,
    );
    for (int i = 0; i < message.$2.length; i++) {
      if (BytesUtils.bytesEqual(emptySignatureBytes, message.$2.elementAt(i))) {
        continue;
      }
      transaction.addSignature(
        signerPubkeys.elementAt(i),
        message.$2.elementAt(i),
        verifySignature: verifySignatures,
      );
    }

    return transaction;
  }
  factory SolanaTransaction.fromJson(
    Map<String, dynamic> json, {
    TransactionType? version,

    /// Resolved LUT addresses (see `VersionedMessage.fromJson`).
    AccountLookupKeys? resolvedLookupKeys,
  }) {
    final message = VersionedMessage.fromJson(
      (json['message'] as Map).cast<String, dynamic>(),
      type: version,
      resolvedLookupKeys: resolvedLookupKeys,
    );

    final List<List<int>> signatures =
        (json['signatures'] as List)
            .map<List<int>>((e) => Base58Decoder.decode(e))
            .toList();
    final transaction = SolanaTransaction._(
      List.generate(
        message.header.numRequiredSignatures,
        (index) => List<int>.unmodifiable(
          List<int>.filled(SolanaTransactionConstant.signatureLengthInBytes, 0),
        ),
      ),
      message: message,
    );
    final signerPubkeys = message.accountKeys.sublist(
      0,
      message.header.numRequiredSignatures,
    );
    for (int i = 0; i < signatures.length; i++) {
      transaction.addSignature(
        signerPubkeys.elementAt(i),
        signatures.elementAt(i),

        // Skips verification for `jsonParsed` messages (no `header`):
        // rebuilt bytes are display-grade, not the exact signed bytes.
        verifySignature:
            version != null && (json['message'] as Map)['header'] != null,
      );
    }
    return transaction;
  }

  factory SolanaTransaction.fromMessage(VersionedMessage message) {
    return SolanaTransaction._(
      List.generate(
        message.header.numRequiredSignatures,
        (index) => List<int>.unmodifiable(
          List<int>.filled(SolanaTransactionConstant.signatureLengthInBytes, 0),
        ),
      ),
      message: message,
    );
  }

  /// Serializes the message of the transaction.
  List<int> serializeMessage() {
    return _serializeMessage;
  }

  /// Serializes the message of the transaction to hexadecimal format.
  String serializeMessageString({
    TransactionSerializeEncoding encoding = TransactionSerializeEncoding.hex,
  }) {
    return encoding.encode(serializeMessage());
  }

  /// Serializes the transaction.
  List<int> serialize({bool verifySignatures = false}) {
    if (verifySignatures) {
      if (!areSignaturesReady()) {
        throw const BuError(
          OnChainErrorType.solanaPlugin,
          'Not all transaction signatures are ready.',
        );
      }
    }
    return SolanaTransactionUtils.serializeTransaction(message, _signatures);
  }

  /// Serializes the transaction to string format.
  String serializeString({
    TransactionSerializeEncoding encoding = TransactionSerializeEncoding.base58,
    bool verifySignatures = false,
  }) {
    final ser = serialize(verifySignatures: verifySignatures);
    return encoding.encode(ser);
  }

  /// Signs the transaction with provided signers.
  void sign(List<SolanaPrivateKey> signers) {
    final messageBytes = serializeMessage();
    for (final signer in signers) {
      final address = signer.publicKey().toAddress();
      final signature = signer.sign(messageBytes);
      addSignature(address, signature);
    }
  }

  /// Checks if all signatures of the transaction are ready.
  bool areSignaturesReady() {
    final signerPubkeys = message.accountKeys.sublist(
      0,
      message.header.numRequiredSignatures,
    );
    if (signerPubkeys.isEmpty) return false;
    for (int i = 0; i < signerPubkeys.length; i++) {
      final signer = signerPubkeys[i].toPublicKey();
      final signerSignature = _signatures[i];
      if (!signer.verify(
        message: serializeMessage(),
        signature: signerSignature,
      )) {
        return false;
      }
    }
    return true;
  }

  /// signers of the transaction
  List<SolAddress> get signers =>
      message.accountKeys.sublist(0, message.header.numRequiredSignatures);

  /// Adds a signature to the transaction.
  void addSignature(
    SolAddress address,
    List<int> signature, {
    bool verifySignature = true,
  }) {
    if (signature.length != SolanaTransactionConstant.signatureLengthInBytes) {
      throw const BuError(
        DefaultErrorType.invalidLength,
        'Signature must be 64 bytes long.',
      );
    }
    final signerPubkeys = message.accountKeys.sublist(
      0,
      message.header.numRequiredSignatures,
    );
    final signerIndex = signerPubkeys.indexWhere(
      (pubkey) => pubkey.address == address.address,
    );
    if (signerIndex < 0) {
      throw BuError(
        DefaultErrorType.invalidAddress,
        'Cannot add signature, $address is not required to sign this transaction',
      );
    }
    if (verifySignature &&
        !address.toPublicKey().verify(
          message: serializeMessage(),
          signature: signature,
        )) {
      throw const BuError(
        DefaultErrorType.cryptoVerifyFailed,
        'Transaction signature verification failed.',
      );
    }
    final List<List<int>> currentSigs = List.from(_signatures);
    currentSigs[signerIndex] = List<int>.unmodifiable(signature);
    _signatures = List<List<int>>.unmodifiable(currentSigs);
  }
}
