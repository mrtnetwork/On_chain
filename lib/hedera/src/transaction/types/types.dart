import 'package:on_chain/hedera/src/address/src/address.dart';
import 'package:on_chain/hedera/src/crypto/public_key/public_key.dart';
import 'package:on_chain/hedera/src/crypto/types/types.dart';
import 'package:on_chain/hedera/src/proto_messages/proto/models.dart';
import 'package:on_chain/hedera/src/rpc/api/api/types/types.dart';
import 'package:on_chain/hedera/src/transaction/fee/fee.dart';
import 'package:on_chain/hedera/src/transaction/signer/transaction_body_signers.dart';
import 'package:on_chain/hedera/src/transaction/utils/utils.dart';
import 'package:on_chain/transaction/transaction.dart';

/// Snapshot of a Hedera [HederaTransactionBody] as an [IOnchainTransaction].
class HederaOnchainTransaction implements IOnchainTransaction {
  final HederaTransactionBody body;

  const HederaOnchainTransaction(this.body);
}

class HederaGetTransactionParams implements IOnchainTransactionParams {
  const HederaGetTransactionParams();
}

/// Parameters for [HederaTransactionBuilder.fillTransaction].
///
/// Fills the transaction envelope (payer / transaction ID, node, valid
/// duration, memo, record flag) and resolves [transactionFee] when it is
/// not supplied.
///
/// ## Fee resolution order
///
/// 1. If [transactionFee] is set and `> 0`, that value is written on the body
///    as the max fee (no estimation).
/// 2. Else if [totalSignatures] is set, fee is estimated using that signature
///    count (no signer lookup).
/// 3. Else signers are resolved via [lockupSignerParams] (body + optional
///    state keys) so [requiredSigners] / key slots can be counted for the
///    fee schedule or mirror estimate; then [feeSafetyMultiplier] is applied.
///
/// On Hedera, `TransactionBody.transactionFee` is the **max non-gas fee**.
/// EVM gas HBAR is charged separately and is not limited by this field.
class HederaFillTransactionParams implements IOnchainFillTransactionParams {
  /// Account that pays fees and is set as `transactionID.accountID`.
  ///
  /// Must be an on-chain account id (not a bare EVM alias) when the network
  /// requires a numeric payer for the transaction id.
  final HederaAddress payer;

  /// Multiplier applied after the raw fee estimate to form the body max fee.
  ///
  /// Example: `1.1` → +10% headroom. Token transfers and multi-sig often need
  /// `1.5`–`2.0` to avoid [INSUFFICIENT_TX_FEE]. Ignored when [transactionFee]
  /// is provided explicitly.
  final double feeSafetyMultiplier;

  /// Consensus node that should receive the transaction.
  ///
  /// If null, the builder uses the client’s configured node account id.
  final HederaAccountID? nodeAccountID;

  /// How long the transaction remains valid after `transactionValidStart`.
  ///
  /// Network maximum is typically 180 seconds; default comes from
  /// [HederaTransactionBuilderUtils.maxTransactionValidDuration] (usually 120s).
  final Duration transactionValidDuration;

  /// Optional memo stored on the transaction body (UTF-8, length-limited by
  /// the network).
  final String? memo;

  /// When true, requests a transaction record in addition to the receipt
  /// (`generateRecord` on the body).
  final bool generateRecord;

  /// Explicit max fee in **tinybars** written to `TransactionBody.transactionFee`.
  ///
  /// When non-null and `> 0`, fee estimation is skipped entirely.
  /// This is a ceiling for **non-gas** fees only; it does not cover EVM gas.
  final BigInt? transactionFee;

  /// How to resolve required signers when estimating fees (signature count).
  ///
  /// Used only when neither [transactionFee] nor [totalSignatures] is set.
  /// Controls body-only vs state key lookup (`resolveStateKeys`), and optional
  /// [TxBodySignerLookupParams.providedKeys] so known keys do not need network
  /// queries.
  ///
  /// Skipped if [transactionFee] or [totalSignatures] is provided.
  final TxBodySignerLookupParams lockupSignerParams;

  /// Explicit total signature count for fee estimation (accounts + key slots).
  ///
  /// When set, signer lookup via [lockupSignerParams] is skipped. Use this when
  /// you already know how many signatures will be attached (e.g. 1 for a
  /// single Ed25519 payer, or N for a threshold key).
  ///
  /// Skipped if [transactionFee] is provided (no estimate at all).
  final int? totalSignatures;

  HederaFillTransactionParams({
    required this.payer,
    this.lockupSignerParams = const TxBodySignerLookupParams(),
    this.transactionFee,
    this.feeSafetyMultiplier = 1.1,
    this.nodeAccountID,
    this.transactionValidDuration =
        HederaTransactionBuilderUtils.maxTransactionValidDuration,
    this.memo,
    this.generateRecord = false,
    this.totalSignatures,
  });
}

/// Binds one or more [HederaPublicKey]s to a single signing callback.
///
/// Use this when one logical signer can produce signatures for **several**
/// public keys — for example:
/// - a **threshold** account (M-of-N): [publicKeys] is the full participant set
/// - a **KeyList** (N-of-N): every key in the list
/// - a **single** key: [publicKeys] has length 1
///
/// During [HederaTransactionBuilder.signTransaction], pending key requirements
/// are matched against [publicKeys]. For each still-unsigned matching key, the
/// builder calls [signer] once and applies the returned [HederaSigner] to the
/// transaction body (the signer may emit one or many [HederaSignaturePair]s).
///
/// ## Example (2-of-3 threshold)
///
/// ```dart
/// HederaTransactionSigner(
///   publicKeys: [pk1, pk2, pk3],
///   signer: (publicKey) async => myThresholdWallet.signerFor(publicKey),
/// )
/// ```
class HederaTransactionSigner {
  /// Public keys this entry can satisfy.
  ///
  /// For a threshold / KeyList account, include **all** participant keys the
  /// wallet controls (or the full set if one device holds every share).
  /// Matching is by key bytes; order does not need to match the on-chain KeyList.
  final List<HederaPublicKey> publicKeys;

  /// Resolves a concrete [HederaSigner] for a specific [HederaPublicKey].
  ///
  /// Invoked only for keys that are still pending on the transaction.
  /// Return `null` to skip this key on this pass (allows multi-pass signing).
  final CbGetHederaPublicKeySigner signer;

  const HederaTransactionSigner({
    required this.publicKeys,
    required this.signer,
  });
}

/// Returns a [HederaSigner] able to sign for [publicKey], or `null` to skip.
typedef CbGetHederaPublicKeySigner =
    Future<HederaSigner?> Function(HederaPublicKey publicKey);

/// Resolves how to sign for a detected requirement.
///
/// Called once per still-pending [TxRequiredSigner] when [HederaSignTransactionParams.signers]
/// and [HederaSignTransactionParams.signatures] are not enough to finish the tx.
///
/// - [role]: semantic role (payer, token supply key, debit account, …).
/// - [key]: set when the requirement is a [HederaKey] (threshold / KeyList / single).
/// - [account]: set when the requirement is an account id that must authorize.
///
/// Return a [HederaTransactionSigner] (one or more public keys + callback), or
/// `null` to skip this requirement on this pass (multi-pass signing).
typedef CbGetKeySigner =
    Future<HederaTransactionSigner?> Function({
      required TxSignerRole role,
      HederaKey? key,
      HederaAddress? account,
    });

/// Parameters for [HederaTransactionBuilder.signTransaction].
///
/// ## Resolution order (first match wins per pass)
///
/// 1. **[signatures]** — if non-null, those pairs are merged into the session
///    as already-collected signatures (can be an empty map to mean “none yet”).
///    Signer lookup / [signerCallback] are not used for keys already covered.
/// 2. **[signers]** — if non-null, each [HederaSigner] is asked to sign the body;
///    pairs are merged. When non-null (including empty list), [signerCallback]
///    and [lockupSignerParams] are skipped for this call’s “provide signers”
///    path as documented below.
/// 3. **Detection + [signerCallback]** — if requirements are not fully satisfied:
///    - load/refresh required signers via [lockupSignerParams] (unless skipped
///      by session state from a previous pass);
///    - for each still-pending role, call [signerCallback];
///    - only pending accounts/keys are requested (multi-pass safe).
///
/// Phase becomes [TxBuilderPhase.signed] only when the session is
/// **ready to broadcast** (no pending account/key requirements left).
///
/// ## Skipping lookup
///
/// - If [signatures] is provided: treat as pre-attached material; still may need
///   more signers if not complete.
/// - If [signers] is provided: do **not** run [lockupSignerParams] / detection
///   for this path—sign only with the given list (empty list = add no sigs).
/// - If both [signatures] and [signers] are null: run detection (see
///   [lockupSignerParams]) and [signerCallback] for pending roles only.
class HederaSignTransactionParams implements IOnchainSignTransactionParams {
  /// Called for each pending requirement when not fully covered by [signers]
  /// / [signatures].
  ///
  /// Return `null` to leave that
  /// [HederaTransactionBuilder.signTransaction] call.
  final CbGetKeySigner signerCallback;

  /// Optional signer detection options (state keys, `providedKeys`, etc.).
  ///
  /// Used when requirements must be discovered or refreshed. Ignored when
  /// [signers] is non-null (caller supplies signing material only).
  /// If null, the builder uses `const TxBodySignerLookupParams()`.
  final TxBodySignerLookupParams? lockupSignerParams;

  /// Pre-built signature map to merge into the signing session.
  ///
  /// When non-null (including empty), pairs are applied before callbacks.
  /// Useful for offline co-signing or resuming a partial `sigMap`.
  final HederaSignatureMap? signatures;

  /// Explicit signers to invoke for this pass (no role matching).
  ///
  /// When non-null (including empty):
  /// - [lockupSignerParams] detection is skipped for this “provided signers” path;
  /// - [signerCallback] is not used to resolve roles;
  /// - each entry signs the filled body and pairs are merged.
  ///
  /// When null, the builder uses detection + [signerCallback] instead.
  final List<HederaSigner>? signers;

  const HederaSignTransactionParams({
    required this.signerCallback,
    this.signers,
    this.signatures,
    this.lockupSignerParams,
  });
}

class HederaSignedTransactionResult implements IOnchainSignedTransactionResult {
  final HederaTransaction transaction;
  final HederaTransactionBody body;
  final HederaSignatureMap sigMap;
  final List<TxSigningRequirement>? requirementSigners;

  const HederaSignedTransactionResult({
    required this.transaction,
    required this.body,
    required this.sigMap,
    this.requirementSigners,
  });
}

class HederaFinalizeTransactionParams
    implements IOnchainFinalizeTransactionParams {
  const HederaFinalizeTransactionParams();
}

class HederaFinalizedTransactionResult
    implements IOnchainFinalizedTransactionResult {
  final HederaTransaction transaction;
  final HederaSignedTransactionResult signed;

  const HederaFinalizedTransactionResult({
    required this.transaction,
    required this.signed,
  });
}

class HederaSubmitTransactionParams implements IOnchainSubmitTransactionParams {
  final bool waitForReceipt;
  final Duration timeout;

  const HederaSubmitTransactionParams({
    this.waitForReceipt = true,
    this.timeout = const Duration(seconds: 60),
  });
}

class HederaSubmitTransactionResult implements IOnchainSubmitTransactionResult {
  final HederaTransactionResponse response;
  final HederaTransactionReceipt? receipt;
  final String transactionId;
  final bool success;

  const HederaSubmitTransactionResult({
    required this.response,
    this.receipt,
    required this.success,
    required this.transactionId,
  });

  Map<String, dynamic> toJson() {
    return {
      "response": response.toJson(),
      "receipt": receipt?.toJson(),
      "success": success,
      "transactionId": transactionId,
    };
  }
}

/// Hedera specialization of [IOnchainTxBuilder].
typedef IHederaTxBuilder =
    IOnchainTxBuilder<
      HederaOnchainTransaction,
      HederaGetTransactionParams,
      HederaFillTransactionParams,
      HederaFillTransactionResult,
      HederaSignTransactionParams,
      HederaSignedTransactionResult,
      HederaFinalizeTransactionParams,
      HederaFinalizedTransactionResult,
      HederaSubmitTransactionParams,
      HederaSubmitTransactionResult
    >;

class HederaFillTransactionResult implements IOnchainFillTransactionResult {
  final HederaFeeEstimate fee;
  final List<TxSignerRole>? missingKeys;

  const HederaFillTransactionResult({required this.fee, this.missingKeys});

  Map<String, dynamic> toJson() {
    return {
      "fee": fee.toJson(),
      "missingKeys": missingKeys?.map((e) => e.name).toList(),
    };
  }
}

class HederaPrepareContractCreateTransactionBody {
  final HederaContractCreateTransactionBody body;
  final HederaContractCallResult? estimateResult;
  const HederaPrepareContractCreateTransactionBody({
    required this.body,
    required this.estimateResult,
  });
}

class HederaPrepareContractCallTransactionBody {
  final HederaContractCallTransactionBody body;
  final HederaContractCallResult? estimateResult;
  const HederaPrepareContractCallTransactionBody({
    required this.body,
    required this.estimateResult,
  });
}
