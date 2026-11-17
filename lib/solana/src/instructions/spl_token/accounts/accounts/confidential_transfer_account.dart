import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class _Utils {
  // ConfidentialTransferAccount wire layout (repr C):
  // approved(1) + elgamal_pubkey(32) + pending_lo(64) + pending_hi(64) +
  // available(64) + decryptable(36: 12 nonce || 8 ct || 16 tag) +
  // allow_confidential(1) + allow_non_confidential(1) + 4 x u64 counters.
  // Total span = 295 bytes (matches current on-chain program).
  static StructLayout get layout => LayoutConst.struct([
    LayoutConst.boolean(property: 'approved'),
    LayoutConst.blob(32, property: 'elgamalPubkey'),
    LayoutConst.blob(64, property: 'pendingBalanceLo'),
    LayoutConst.blob(64, property: 'pendingBalanceHi'),
    LayoutConst.blob(64, property: 'availableBalance'),
    LayoutConst.blob(36, property: 'decryptableAvailableBalance'),
    LayoutConst.boolean(property: 'allowConfidentialCredits'),
    LayoutConst.boolean(property: 'allowNonConfidentialCredits'),
    LayoutConst.u64(property: 'pendingBalanceCreditCounter'),
    LayoutConst.u64(property: 'maximumPendingBalanceCreditCounter'),
    LayoutConst.u64(property: 'expectedPendingBalanceCreditCounter'),
    LayoutConst.u64(property: 'actualPendingBalanceCreditCounter'),
  ]);

  static int get accountSize => layout.span;

  static Map<String, dynamic> decode(List<int> extensionData) {
    try {
      if (extensionData.length < accountSize) {
        throw BuError(
          DefaultErrorType.invalidLength,
          'Account data length is insufficient.',
          details: {
            'Expected': accountSize.toString(),
            'length': extensionData.length.toString(),
          },
        );
      }
      return BorshLayoutSerializable.decode(
        bytes: extensionData,
        layout: layout,
      );
    } catch (e) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid extension bytes.',
      );
    }
  }

  static Map<String, dynamic> decodeFromAccount(List<int> accountBytes) {
    try {
      final extensionBytes =
          SPLToken2022Utils.readExtionsionBytesFromAccountData(
            accountBytes: accountBytes,
            extensionType: ExtensionType.confidentialTransferAccount,
          );
      return BorshLayoutSerializable.decode(
        bytes: extensionBytes,
        layout: layout,
      );
    } catch (e) {
      throw const BuError(
        DefaultErrorType.invalidArgument,
        'Invalid extension bytes.',
      );
    }
  }
}

/// Token-2022 confidential transfer account state (extension
/// type 5). Parsed from `getAccountInfo` data (base 165 bytes + TLV); the
/// wallet decrypts balances locally — no Zcash-style block scanning.
class ConfidentialTransferAccount extends BorshLayoutSerializable {
  /// Total wire size of the extension state.
  static int get size => _Utils.accountSize;

  /// Whether the account is approved for confidential transfers.
  final bool approved;

  /// ElGamal encryption pubkey (32 bytes).
  final List<int> elgamalPubkey;

  /// Pending balance low 16 bits (64-byte ElGamal ciphertext).
  final List<int> pendingBalanceLo;

  /// Pending balance high 32 bits (64-byte ElGamal ciphertext).
  final List<int> pendingBalanceHi;

  /// Available balance (64-byte ElGamal ciphertext).
  final List<int> availableBalance;

  /// AES-GCM-SIV decryptable available balance
  /// (36 bytes: 12 nonce || 8 ct || 16 tag).
  final List<int> decryptableAvailableBalance;

  /// Whether incoming confidential credits are accepted.
  final bool allowConfidentialCredits;

  /// Whether incoming non-confidential transfers are accepted.
  final bool allowNonConfidentialCredits;

  /// Credits to pending since last ApplyPendingBalance.
  final BigInt pendingBalanceCreditCounter;

  /// Maximum credits before ApplyPendingBalance is required.
  final BigInt maximumPendingBalanceCreditCounter;

  /// Client-supplied expected counter from last ApplyPendingBalance.
  final BigInt expectedPendingBalanceCreditCounter;

  /// Program-observed counter from last ApplyPendingBalance.
  final BigInt actualPendingBalanceCreditCounter;

  const ConfidentialTransferAccount({
    required this.approved,
    required this.elgamalPubkey,
    required this.pendingBalanceLo,
    required this.pendingBalanceHi,
    required this.availableBalance,
    required this.decryptableAvailableBalance,
    required this.allowConfidentialCredits,
    required this.allowNonConfidentialCredits,
    required this.pendingBalanceCreditCounter,
    required this.maximumPendingBalanceCreditCounter,
    required this.expectedPendingBalanceCreditCounter,
    required this.actualPendingBalanceCreditCounter,
  });

  factory ConfidentialTransferAccount.fromBuffer(List<int> extensionData) {
    final decode = _Utils.decode(extensionData);
    return ConfidentialTransferAccount(
      approved: decode['approved'],
      elgamalPubkey: (decode['elgamalPubkey'] as List).cast<int>(),
      pendingBalanceLo: (decode['pendingBalanceLo'] as List).cast<int>(),
      pendingBalanceHi: (decode['pendingBalanceHi'] as List).cast<int>(),
      availableBalance: (decode['availableBalance'] as List).cast<int>(),
      decryptableAvailableBalance:
          (decode['decryptableAvailableBalance'] as List).cast<int>(),
      allowConfidentialCredits: decode['allowConfidentialCredits'],
      allowNonConfidentialCredits: decode['allowNonConfidentialCredits'],
      pendingBalanceCreditCounter: decode['pendingBalanceCreditCounter'],
      maximumPendingBalanceCreditCounter:
          decode['maximumPendingBalanceCreditCounter'],
      expectedPendingBalanceCreditCounter:
          decode['expectedPendingBalanceCreditCounter'],
      actualPendingBalanceCreditCounter:
          decode['actualPendingBalanceCreditCounter'],
    );
  }

  factory ConfidentialTransferAccount.fromAccountBytes(List<int> accountBytes) {
    final decode = _Utils.decodeFromAccount(accountBytes);
    return ConfidentialTransferAccount(
      approved: decode['approved'],
      elgamalPubkey: (decode['elgamalPubkey'] as List).cast<int>(),
      pendingBalanceLo: (decode['pendingBalanceLo'] as List).cast<int>(),
      pendingBalanceHi: (decode['pendingBalanceHi'] as List).cast<int>(),
      availableBalance: (decode['availableBalance'] as List).cast<int>(),
      decryptableAvailableBalance:
          (decode['decryptableAvailableBalance'] as List).cast<int>(),
      allowConfidentialCredits: decode['allowConfidentialCredits'],
      allowNonConfidentialCredits: decode['allowNonConfidentialCredits'],
      pendingBalanceCreditCounter: decode['pendingBalanceCreditCounter'],
      maximumPendingBalanceCreditCounter:
          decode['maximumPendingBalanceCreditCounter'],
      expectedPendingBalanceCreditCounter:
          decode['expectedPendingBalanceCreditCounter'],
      actualPendingBalanceCreditCounter:
          decode['actualPendingBalanceCreditCounter'],
    );
  }

  @override
  StructLayout get layout => _Utils.layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'approved': approved,
      'elgamalPubkey': elgamalPubkey,
      'pendingBalanceLo': pendingBalanceLo,
      'pendingBalanceHi': pendingBalanceHi,
      'availableBalance': availableBalance,
      'decryptableAvailableBalance': decryptableAvailableBalance,
      'allowConfidentialCredits': allowConfidentialCredits,
      'allowNonConfidentialCredits': allowNonConfidentialCredits,
      'pendingBalanceCreditCounter': pendingBalanceCreditCounter,
      'maximumPendingBalanceCreditCounter': maximumPendingBalanceCreditCounter,
      'expectedPendingBalanceCreditCounter':
          expectedPendingBalanceCreditCounter,
      'actualPendingBalanceCreditCounter': actualPendingBalanceCreditCounter,
    };
  }

  @override
  String toString() {
    return 'ConfidentialTransferAccount${serialize()}';
  }
}
