import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/spl_token/accounts/accounts/confidential_transfer_account.dart';

/// Read-path helpers for Token-2022 confidential transfers.
/// No proving here: Dart validates wire types and tracks credit counters;
/// dalek Bulletproofs + Sigma proving lives in the Rust `solana_zk` backend.
///
/// Solana model reminder (account-based, no Zcash-style block scanning):
/// one `getAccountInfo` returns the pending + available ElGamal ciphertexts,
/// the wallet decrypts locally with keys derived at `ConfigureAccount`.
///
/// Decrypted confidential balances for one token account.
class SolanaConfidentialBalances {
  /// Pending low 16-bit component (ElGamal decrypted).
  final BigInt pendingLo;

  /// Pending high 32-bit component (ElGamal decrypted).
  final BigInt pendingHi;

  /// Pending total = `pendingLo + 2^16 * pendingHi`.
  BigInt get pendingTotal =>
      pendingLo + (pendingHi << SolanaConfidentialZkUtils.pendingHiShift);

  /// Exact available balance (AES decryptable sidecar).
  final BigInt available;

  const SolanaConfidentialBalances({
    required this.pendingLo,
    required this.pendingHi,
    required this.available,
  });
}

/// Static read/decrypt helpers (see class docs above).
class SolanaConfidentialZkUtils {
  /// ElGamal pubkey length (compressed Ristretto).
  static const int elGamalPubkeyLen = 32;

  /// ElGamal ciphertext length (commitment || handle).
  static const int elGamalCiphertextLen = 64;

  /// AES decryptable-balance length (12 nonce || 8 ct || 16 tag).
  static const int aeCiphertextLen = 36;

  /// Validate an ElGamal pubkey (length + Ristretto decode).
  /// Returns false for malformed input, never throws for bad length.
  static bool isValidElGamalPubkey(List<int> bytes) {
    try {
      SolanaElGamalPubkey.fromBytes(bytes);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Validate an ElGamal ciphertext (length + halves decode).
  static bool isValidElGamalCiphertext(List<int> bytes) {
    try {
      SolanaElGamalCiphertext.fromBytes(bytes);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Bit shift combining pending lo/hi (lo holds 16 bits).
  static const int pendingHiShift = 16;

  /// Parse a Token-2022 account blob into its confidential
  /// transfer state (base 165 bytes + TLV). Throws on missing extension.
  /// Caller fetches the blob with one `getAccountInfo` (no block scanning).
  static ConfidentialTransferAccount parseConfidentialState(
    List<int> accountBytes,
  ) {
    return ConfidentialTransferAccount.fromAccountBytes(accountBytes);
  }

  /// Decrypt the pending lo/hi ElGamal ciphertexts with the
  /// ElGamal secret key (BSGS table lives in the Rust backend, 0..2^32).
  /// Returns `(pendingLo, pendingHi)`; total = `lo + 2^16 * hi`.
  static (BigInt, BigInt) decryptPending({
    required SolanaZkApi api,
    required List<int> elGamalSecret,
    required ConfidentialTransferAccount state,
  }) {
    final lo = api.decryptU32(
      secret: elGamalSecret,
      ciphertext: SolanaElGamalCiphertext.fromBytes(state.pendingBalanceLo),
    );
    final hi = api.decryptU32(
      secret: elGamalSecret,
      ciphertext: SolanaElGamalCiphertext.fromBytes(state.pendingBalanceHi),
    );
    return (BigInt.from(lo), BigInt.from(hi));
  }

  /// Decrypt the exact available balance with the 16-byte AES
  /// key (AES-128-GCM-SIV, 36-byte sidecar: 12 nonce || 8 ct || 16 tag).
  static BigInt decryptAvailable({
    required SolanaZkApi api,
    required List<int> aeKey16,
    required ConfidentialTransferAccount state,
  }) {
    return api.aeDecrypt(
      key16: aeKey16,
      ae: SolanaAeCiphertext.fromBytes(state.decryptableAvailableBalance).bytes,
    );
  }

  /// Full local read: pending (ElGamal) + available (AES).
  /// One RPC fetch + local decrypts; no scanning, no proving.
  static SolanaConfidentialBalances readBalances({
    required SolanaZkApi api,
    required List<int> accountBytes,
    required List<int> elGamalSecret,
    required List<int> aeKey16,
  }) {
    final state = parseConfidentialState(accountBytes);
    final (lo, hi) = decryptPending(
      api: api,
      elGamalSecret: elGamalSecret,
      state: state,
    );
    final available = decryptAvailable(
      api: api,
      aeKey16: aeKey16,
      state: state,
    );
    return SolanaConfidentialBalances(
      pendingLo: lo,
      pendingHi: hi,
      available: available,
    );
  }

  /// Resolve a `proofInstructionOffset` (i8) to an absolute
  /// instruction index. `0` means a context-state account, otherwise the
  /// offset is relative to the confidential-transfer instruction.
  /// Mirrors zk-token-proof placement rules; throws on out-of-range index.
  static int resolveProofInstructionIndex({
    required int transferInstructionIndex,
    required int proofOffset,
  }) {
    if (proofOffset == 0) return transferInstructionIndex;
    final resolved = transferInstructionIndex + proofOffset;
    if (resolved < 0) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'proofInstructionOffset resolves before index 0.',
      );
    }
    return resolved;
  }

  /// Build the AES `decryptableZeroBalance` seed payload for
  /// `ConfigureAccount`: 36 zero bytes encrypted under the account key.
  /// Actual AES happens caller-side; this returns the canonical zero input.
  static List<int> decryptableZeroBalanceSeed() => List<int>.filled(36, 0);
}
