import 'package:blockchain_utils/chain/signer/const/constants.dart';

import 'package:blockchain_utils/helper/helper.dart';
import 'package:on_chain/algorand/src/crypto/crypto.dart';
import 'package:on_chain/algorand/src/account/core/account.dart';
import 'package:on_chain/algorand/src/address/address.dart';
import 'package:on_chain/algorand/src/transaction/src/signatures.dart';
import 'package:on_chain/algorand/src/transaction/src/transaction.dart';
import 'package:on_chain/algorand/src/utils/utils.dart';
import 'package:on_chain/exception/onchain_error.dart';

/// Marker interface for multi-signature account public keys.
abstract class AlgoMultiAccountPublicKey<PK extends AlgoPublicKey>
    implements AlgoAccountPublicKey {}

/// Marker interface for multi-signature accounts that can sign transactions.
abstract class AlgoMultiAccount<PA extends AlgoMultiAccountPublicKey>
    implements AlgoAccount<PA> {}

/// Ed25519 multi-signature public-key account (M-of-N).
///
/// Address is derived as:
///   SHA-512/256("MultisigAddr" || version || threshold || pk1 || pk2 || …)
class AlgoMultiEd25519AccountPublicKey
    implements AlgoMultiAccountPublicKey<AlgoEd25519PublicKey> {
  /// Ordered list of participant public keys.
  final List<AlgoEd25519PublicKey> publicKeys;

  /// Multisig protocol version (currently only version 1 is supported).
  final int version;

  /// Minimum number of signatures required to authorize a transaction.
  final int threshold;

  AlgoMultiEd25519AccountPublicKey._({
    required List<AlgoEd25519PublicKey> publicKeys,
    required this.version,
    required this.threshold,
  }) : publicKeys = publicKeys.immutable;

  /// Attempts to reconstruct a multisig public account from an [AlgoMultisigSig].
  /// Returns `null` if the structure is invalid or keys cannot be parsed.
  static AlgoMultiEd25519AccountPublicKey? fromMultisig(
    AlgoMultisigSig multisig,
  ) {
    try {
      return AlgoMultiEd25519AccountPublicKey(
        publicKeys:
            multisig.subsigs
                .map((e) => AlgoEd25519PublicKey.fromBytes(e.publicKey))
                .toList(),
        threshold: multisig.threshold.asSafeInt,
        version: multisig.version.asSafeInt,
      );
    } catch (_) {
      return null;
    }
  }

  /// Creates a validated multisig public account.
  ///
  /// Throws if [version] is unsupported, [threshold] is zero / exceeds key
  /// count / exceeds 255, or [publicKeys] is empty.
  factory AlgoMultiEd25519AccountPublicKey({
    required List<AlgoEd25519PublicKey> publicKeys,
    required int threshold,
    int version = AlgoUtils.defaultMultisigAccountVersion,
  }) {
    if (version != AlgoUtils.defaultMultisigAccountVersion) {
      throw OnChainErrors.algoPlugin(
        "AlgoMultiEd25519AccountPublicKey",
        reason: "Unsupported multisig account version.",
      );
    }
    if (threshold == 0 || publicKeys.isEmpty || threshold > publicKeys.length) {
      throw OnChainErrors.algoPlugin(
        "AlgoMultiEd25519AccountPublicKey",
        reason: "Mismatch between threshold and public key length.",
      );
    }
    if (threshold > 255) {
      throw OnChainErrors.algoPlugin(
        "AlgoMultiEd25519AccountPublicKey",
        reason: "Invalid multisig threshold. Must be within 1-255.",
      );
    }
    return AlgoMultiEd25519AccountPublicKey._(
      publicKeys: publicKeys,
      version: version,
      threshold: threshold,
    );
  }

  /// Derives the multisig address from version, threshold, and all public keys.
  @override
  AlgoAddress toAddress() {
    final keys = publicKeys.expand((e) => e.toBytes()).toList();
    final bytes = [
      ...AlgoUtils.multisigAddrPrefix.codeUnits,
      version,
      threshold,
      ...keys,
    ];
    final hash = AlgoUtils.hashData(bytes);
    return AlgoAddress.fromBytes(hash);
  }

  /// Verifies that [signatures] satisfy the threshold over [message].
  ///
  /// Optionally checks that [address] matches this account's derived address.
  /// Each signed sub-signature must belong to a known public key and verify.
  bool verifyMultisig({
    required List<int> message,
    required List<AlgoMultisigSubsig> signatures,
    AlgoAddress? address,
  }) {
    if ((address != null && address != toAddress()) ||
        signatures.fold<int>(0, (p, c) => p + (c.signed() ? 1 : 0)) <
            threshold) {
      return false;
    }
    int signed = 0;
    for (final i in signatures) {
      final signature = i.signature;
      if (signature == null || !i.signed()) continue;
      final publicKey = AlgoEd25519PublicKey.fromBytes(i.publicKey);
      if (!publicKeys.contains(publicKey)) return false;
      if (!publicKey.verify(message, signature)) return false;
      signed++;
    }
    return signed >= threshold;
  }
}

/// Ed25519 multi-signature account holding optional local signers.
///
/// Combines a [AlgoMultiEd25519AccountPublicKey] with zero or more secret keys
/// that can contribute signatures toward the threshold.
class AlgoMultiEd25519Account
    implements AlgoMultiAccount<AlgoMultiEd25519AccountPublicKey> {
  /// Local secret keys available for signing (subset of the multisig participants).
  final List<AlgoEd25519SecretKey> signers;

  /// The multisig public-key configuration (keys, version, threshold).
  final AlgoMultiEd25519AccountPublicKey publicKeyAccount;

  const AlgoMultiEd25519Account(
    this.publicKeyAccount, {
    this.signers = const [],
  });

  /// Produces a single [AlgoMultisigSubsig] for [transaction] using [signer].
  /// Throws if [signer]'s public key is not part of this multisig account.
  AlgoMultisigSubsig singleSignTransaction(
    AlgoTransaction transaction,
    AlgoEd25519SecretKey signer,
  ) {
    final signature = signer.rawSignTransaction(transaction);
    final publicKey = signer.toPublicKey();
    if (!publicKeyAccount.publicKeys.contains(publicKey)) {
      throw OnChainErrors.algoPlugin(
        "singleSignTransaction",
        reason:
            "Invalid secret key. Signer public key not found in multisig account.",
      );
    }
    return AlgoMultisigSubsig(
      publicKey: publicKey.toBytes(),
      signature: signature,
    );
  }

  /// Internal signing path shared by real and simulate flows.
  ///
  /// Builds a full [AlgoMultisigSig] ordered to match [publicKeyAccount.publicKeys].
  /// When [simulate] is true, fills the first [threshold] slots with placeholder
  /// signatures (all `0x01`) instead of signing.
  AlgoSignedTxn _signTransactions(
    AlgoTransaction transaction, {
    List<AlgoEd25519SecretKey> availableSigners = const [],
    bool stopAfterThreshold = true,
    bool requireThreshold = true,
    bool simulate = false,
  }) {
    List<AlgoMultisigSubsig> signatures =
        publicKeyAccount.publicKeys
            .map((e) => AlgoMultisigSubsig(publicKey: e.toBytes()))
            .toList();
    if (!simulate) {
      final allSigners = [...availableSigners, ...signers];
      int signatureCount = 0;
      for (final i in publicKeyAccount.publicKeys.indexed) {
        final signer = allSigners.firstWhereNullable(
          (e) => e.toPublicKey() == i.$2,
        );
        if (signer == null) continue;
        final signature = singleSignTransaction(transaction, signer);
        signatures[i.$1] = signature;
        signatureCount++;
        if (stopAfterThreshold &&
            signatureCount >= publicKeyAccount.threshold) {
          break;
        }
      }
      if (requireThreshold && signatureCount < publicKeyAccount.threshold) {
        throw OnChainErrors.algoPlugin(
          "signTransactions",
          reason: "Not enough valid signers to reach multisig threshold",
        );
      }
    } else {
      // Dry-run / simulate: placeholder signatures, no private-key use.
      final signature = List<int>.filled(
        CryptoSignerConst.ed25519SignatureLength,
        1,
      );
      for (int i = 0; i < publicKeyAccount.threshold; i++) {
        signatures[i] = AlgoMultisigSubsig(
          publicKey: signatures[i].publicKey,
          signature: signature,
        );
      }
    }
    AlgoAddress? authAddr;
    final address = publicKeyAccount.toAddress();
    if (address != transaction.sender) {
      authAddr = address;
    }

    return AlgoSignedTxn(
      transaction: transaction,
      authAddr: authAddr,
      msig: AlgoMultisigSig(
        version: BigInt.from(publicKeyAccount.version),
        threshold: BigInt.from(publicKeyAccount.threshold),
        subsigs: signatures,
      ),
    );
  }

  /// Signs [transaction] with available local / extra signers.
  ///
  /// [stopAfterThreshold] stops once enough signatures are collected.
  /// [requireThreshold] throws if the threshold cannot be met.
  AlgoSignedTxn signTransactions(
    AlgoTransaction transaction, {
    List<AlgoEd25519SecretKey> availableSigners = const [],
    bool stopAfterThreshold = true,
    bool requireThreshold = true,
  }) {
    return _signTransactions(
      transaction,
      availableSigners: availableSigners,
      requireThreshold: requireThreshold,
      stopAfterThreshold: stopAfterThreshold,
      simulate: false,
    );
  }

  /// Assembles a signed transaction from pre-collected [availableSignatures]
  /// without requiring local secret keys.
  ///
  /// Matches each sub-signature to the ordered public-key list and enforces
  /// threshold rules the same way as [signTransactions].
  AlgoSignedTxn buildSignedTransaction({
    required AlgoTransaction transaction,
    required List<AlgoMultisigSubsig> availableSignatures,
    bool stopAfterThreshold = true,
    bool requireThreshold = true,
  }) {
    final publicKey =
        availableSignatures
            .map((e) => AlgoEd25519PublicKey.fromBytes(e.publicKey))
            .indexed
            .toList();
    List<AlgoMultisigSubsig> signatures =
        publicKeyAccount.publicKeys
            .map((e) => AlgoMultisigSubsig(publicKey: e.toBytes()))
            .toList();
    int signatureCount = 0;
    for (final i in publicKeyAccount.publicKeys.indexed) {
      final pk = publicKey.firstWhereNullable((e) => e.$2 == i.$2);
      if (pk == null) continue;
      final signature = availableSignatures[pk.$1];
      if (!signature.signed()) continue;
      signatures[i.$1] = signature;
      signatureCount++;
      if (stopAfterThreshold && signatureCount >= publicKeyAccount.threshold) {
        break;
      }
    }
    if (requireThreshold && signatureCount < publicKeyAccount.threshold) {
      throw OnChainErrors.algoPlugin(
        "buildSignedTransaction",
        reason: "Not enough valid signatures to reach multisig threshold.",
      );
    }
    AlgoAddress? authAddr;
    final address = publicKeyAccount.toAddress();
    if (address != transaction.sender) {
      authAddr = address;
    }

    return AlgoSignedTxn(
      transaction: transaction,
      authAddr: authAddr,
      msig: AlgoMultisigSig(
        version: BigInt.from(publicKeyAccount.version),
        threshold: BigInt.from(publicKeyAccount.threshold),
        subsigs: signatures,
      ),
    );
  }

  @override
  AlgoMultiEd25519AccountPublicKey toPublicAccount() {
    return publicKeyAccount;
  }

  /// Async wrapper around [signTransactions] for [AlgoAccount] compatibility.
  @override
  Future<AlgoSignedTxn> signTransactionsAsync(
    AlgoTransaction tx, {
    List<AlgoEd25519SecretKey> availableSigners = const [],
    bool stopAfterThreshold = true,
    bool requireThreshold = true,
  }) async {
    return signTransactions(
      tx,
      availableSigners: availableSigners,
      requireThreshold: requireThreshold,
      stopAfterThreshold: stopAfterThreshold,
    );
  }

  /// Builds a signed transaction for dry-run / simulate and fee calculation without real signatures.
  @override
  Future<AlgoSignedTxn> signSimulateTransactionsAsync(
    AlgoTransaction tx,
  ) async {
    return _signTransactions(tx, simulate: true);
  }
}
