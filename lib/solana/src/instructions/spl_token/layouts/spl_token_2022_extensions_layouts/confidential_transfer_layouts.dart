// Layouts for the Token-2022 ConfidentialTransferExtension (outer
// instruction 27). Pod wire format (repr C, little-endian):
// ElGamal pubkey = 32 bytes, ElGamal ciphertext = 64 bytes,
// decryptable balance (AeCiphertext) = 36 bytes (12 nonce || 8 ct || 16 tag),
// `COption<Pubkey>` = u32 tag (0/1) + 32 bytes, proof offsets = i8.
import 'dart:typed_data';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instruction.dart';

/// Shared Pod helpers for confidential-transfer layouts.
abstract class SPLToken2022ConfidentialTransferLayoutBase
    extends SPLTokenProgramLayout {
  const SPLToken2022ConfidentialTransferLayoutBase();

  static const int elGamalPubkeyLength = 32;
  static const int elGamalCiphertextLength = 64;
  static const int decryptableBalanceLength = 36;
  static const int cOptionTagLength = 4;

  /// Encode a `COption<32-byte key>`: u32 LE tag + 32 bytes.
  static List<int> encodeCOptionKey(List<int>? key) {
    if (key != null) {
      checkLength(key, 32, 'COption key');
    }
    return [
      ...IntUtils.toBytes(
        key == null ? 0 : 1,
        length: cOptionTagLength,
        byteOrder: Endian.little,
      ),
      ...(key ?? List<int>.filled(32, 0)),
    ];
  }

  /// Decode a `COption<32-byte key>` at [offset].
  static List<int>? decodeCOptionKey(List<int> bytes, int offset) {
    final tag = IntUtils.fromBytes(
      bytes.sublist(offset, offset + cOptionTagLength),
      byteOrder: Endian.little,
    );
    if (tag == 0) return null;
    return bytes.sublist(
      offset + cOptionTagLength,
      offset + cOptionTagLength + 32,
    );
  }

  /// Encode a `COption<SolAddress>`.
  static List<int> encodeCOptionAddress(SolAddress? address) {
    return SPLToken2022ConfidentialTransferLayoutBase.encodeCOptionKey(
      address?.toBytes(),
    );
  }

  /// Decode a `COption<SolAddress>` at [offset].
  static SolAddress? decodeCOptionAddress(List<int> bytes, int offset) {
    final key = SPLToken2022ConfidentialTransferLayoutBase.decodeCOptionKey(
      bytes,
      offset,
    );
    if (key == null) return null;
    return SolAddress.uncheckBytes(key);
  }

  /// Encode a `MaybeNull<32-byte key>` (Token-2022 style):
  /// raw 32 bytes, all-zeros = None. Unlike `COption`, there is no u32 tag.
  static List<int> encodeMaybeNullKey(List<int>? key) {
    if (key != null) {
      checkLength(key, 32, 'MaybeNull key');
      return List<int>.from(key);
    }
    return List<int>.filled(32, 0);
  }

  /// Decode a `MaybeNull<32-byte key>` at [offset].
  /// Returns null when all 32 bytes are zero.
  static List<int>? decodeMaybeNullKey(List<int> bytes, int offset) {
    final slice = bytes.sublist(offset, offset + 32);
    if (slice.every((b) => b == 0)) return null;
    return slice;
  }

  /// Encode a `MaybeNull<SolAddress>`.
  static List<int> encodeMaybeNullAddress(SolAddress? address) {
    return SPLToken2022ConfidentialTransferLayoutBase.encodeMaybeNullKey(
      address?.toBytes(),
    );
  }

  /// Decode a `MaybeNull<SolAddress>` at [offset].
  static SolAddress? decodeMaybeNullAddress(List<int> bytes, int offset) {
    final key = SPLToken2022ConfidentialTransferLayoutBase.decodeMaybeNullKey(
      bytes,
      offset,
    );
    if (key == null) return null;
    return SolAddress.uncheckBytes(key);
  }

  static void checkLength(List<int> bytes, int length, String name) {
    if (bytes.length != length) {
      throw BuError.length(what: name, expected: length, actual: bytes.length);
    }
  }

  @override
  final SPLTokenProgramInstruction instruction =
      SPLTokenProgramInstruction.confidentialTransferExtension;
}

/// InitializeMint (27, 0). Wire format is `InitializeMintData`:
/// `MaybeNull<Address>` (32 bytes, zeros = None) + `Bool` (1) +
/// `MaybeNull<PodElGamalPubkey>` (32 bytes, zeros = None).
class SPLToken2022ConfidentialInitializeMintLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  final SolAddress? authority;
  final bool autoApproveNewAccounts;
  final List<int>? auditorElGamalPubkey;
  SPLToken2022ConfidentialInitializeMintLayout({
    required this.authority,
    required this.autoApproveNewAccounts,
    required List<int>? auditorElGamalPubkey,
  }) : auditorElGamalPubkey = auditorElGamalPubkey?.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
    LayoutConst.blob(32, property: 'authority'),
    LayoutConst.u8(property: 'autoApproveNewAccounts'),
    LayoutConst.blob(32, property: 'auditorElGamalPubkey'),
  ]);

  factory SPLToken2022ConfidentialInitializeMintLayout.fromBuffer(
    List<int> bytes,
  ) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    final List<int> authorityBytes = (decode['authority'] as List).cast<int>();
    final List<int> auditorBytes =
        (decode['auditorElGamalPubkey'] as List).cast<int>();
    return SPLToken2022ConfidentialInitializeMintLayout(
      authority:
          SPLToken2022ConfidentialTransferLayoutBase.decodeMaybeNullAddress(
            authorityBytes,
            0,
          ),
      autoApproveNewAccounts: decode['autoApproveNewAccounts'] == 1,
      auditorElGamalPubkey:
          SPLToken2022ConfidentialTransferLayoutBase.decodeMaybeNullKey(
            auditorBytes,
            0,
          ),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'confidentialTransfer':
          ConfidentialTransferInstruction.initializeMint.value,
      'authority':
          SPLToken2022ConfidentialTransferLayoutBase.encodeMaybeNullAddress(
            authority,
          ),
      'autoApproveNewAccounts': autoApproveNewAccounts ? 1 : 0,
      'auditorElGamalPubkey':
          SPLToken2022ConfidentialTransferLayoutBase.encodeMaybeNullKey(
            auditorElGamalPubkey,
          ),
    };
  }
}

/// UpdateMint (27, 1). `auditorElGamalPubkey` is
/// `MaybeNull<PodElGamalPubkey>` (32 bytes, zeros = None).
class SPLToken2022ConfidentialUpdateMintLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  final bool autoApproveNewAccounts;
  final List<int>? auditorElGamalPubkey;
  SPLToken2022ConfidentialUpdateMintLayout({
    required this.autoApproveNewAccounts,
    required List<int>? auditorElGamalPubkey,
  }) : auditorElGamalPubkey = auditorElGamalPubkey?.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
    LayoutConst.u8(property: 'autoApproveNewAccounts'),
    LayoutConst.blob(32, property: 'auditorElGamalPubkey'),
  ]);

  factory SPLToken2022ConfidentialUpdateMintLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    final List<int> auditorBytes =
        (decode['auditorElGamalPubkey'] as List).cast<int>();
    return SPLToken2022ConfidentialUpdateMintLayout(
      autoApproveNewAccounts: decode['autoApproveNewAccounts'] == 1,
      auditorElGamalPubkey:
          SPLToken2022ConfidentialTransferLayoutBase.decodeMaybeNullKey(
            auditorBytes,
            0,
          ),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'confidentialTransfer': ConfidentialTransferInstruction.updateMint.value,
      'autoApproveNewAccounts': autoApproveNewAccounts ? 1 : 0,
      'auditorElGamalPubkey':
          SPLToken2022ConfidentialTransferLayoutBase.encodeMaybeNullKey(
            auditorElGamalPubkey,
          ),
    };
  }
}

/// ConfigureAccount (27, 2).
class SPLToken2022ConfidentialConfigureAccountLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  final List<int> decryptableZeroBalance;
  final BigInt maximumPendingBalanceCreditCounter;
  final int proofInstructionOffset;
  SPLToken2022ConfidentialConfigureAccountLayout({
    required List<int> decryptableZeroBalance,
    required this.maximumPendingBalanceCreditCounter,
    required this.proofInstructionOffset,
  }) : decryptableZeroBalance = decryptableZeroBalance.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
    LayoutConst.blob(36, property: 'decryptableZeroBalance'),
    LayoutConst.u64(property: 'maximumPendingBalanceCreditCounter'),
    LayoutConst.i8(property: 'proofInstructionOffset'),
  ]);

  factory SPLToken2022ConfidentialConfigureAccountLayout.fromBuffer(
    List<int> bytes,
  ) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    return SPLToken2022ConfidentialConfigureAccountLayout(
      decryptableZeroBalance:
          (decode['decryptableZeroBalance'] as List).cast<int>(),
      maximumPendingBalanceCreditCounter:
          decode['maximumPendingBalanceCreditCounter'],
      proofInstructionOffset: decode['proofInstructionOffset'],
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'confidentialTransfer':
          ConfidentialTransferInstruction.configureAccount.value,
      'decryptableZeroBalance': decryptableZeroBalance,
      'maximumPendingBalanceCreditCounter': maximumPendingBalanceCreditCounter,
      'proofInstructionOffset': proofInstructionOffset,
    };
  }
}

/// ApproveAccount (27, 3). Empty payload.
class SPLToken2022ConfidentialApproveAccountLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  const SPLToken2022ConfidentialApproveAccountLayout();

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
  ]);

  factory SPLToken2022ConfidentialApproveAccountLayout.fromBuffer(
    List<int> bytes,
  ) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    return const SPLToken2022ConfidentialApproveAccountLayout();
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'confidentialTransfer':
          ConfidentialTransferInstruction.approveAccount.value,
    };
  }
}

/// EmptyAccount (27, 4).
class SPLToken2022ConfidentialEmptyAccountLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  final int proofInstructionOffset;
  const SPLToken2022ConfidentialEmptyAccountLayout({
    required this.proofInstructionOffset,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
    LayoutConst.i8(property: 'proofInstructionOffset'),
  ]);

  factory SPLToken2022ConfidentialEmptyAccountLayout.fromBuffer(
    List<int> bytes,
  ) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    return SPLToken2022ConfidentialEmptyAccountLayout(
      proofInstructionOffset: decode['proofInstructionOffset'],
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'confidentialTransfer':
          ConfidentialTransferInstruction.emptyAccount.value,
      'proofInstructionOffset': proofInstructionOffset,
    };
  }
}

/// Deposit (27, 5).
class SPLToken2022ConfidentialDepositLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  final BigInt amount;
  final int decimals;
  const SPLToken2022ConfidentialDepositLayout({
    required this.amount,
    required this.decimals,
  });

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
    LayoutConst.u64(property: 'amount'),
    LayoutConst.u8(property: 'decimals'),
  ]);

  factory SPLToken2022ConfidentialDepositLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    return SPLToken2022ConfidentialDepositLayout(
      amount: decode['amount'],
      decimals: decode['decimals'],
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'confidentialTransfer': ConfidentialTransferInstruction.deposit.value,
      'amount': amount,
      'decimals': decimals,
    };
  }
}

/// Withdraw (27, 6).
class SPLToken2022ConfidentialWithdrawLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  final BigInt amount;
  final int decimals;
  final List<int> newDecryptableAvailableBalance;
  final int equalityProofInstructionOffset;
  final int rangeProofInstructionOffset;
  SPLToken2022ConfidentialWithdrawLayout({
    required this.amount,
    required this.decimals,
    required List<int> newDecryptableAvailableBalance,
    required this.equalityProofInstructionOffset,
    required this.rangeProofInstructionOffset,
  }) : newDecryptableAvailableBalance =
           newDecryptableAvailableBalance.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
    LayoutConst.u64(property: 'amount'),
    LayoutConst.u8(property: 'decimals'),
    LayoutConst.blob(36, property: 'newDecryptableAvailableBalance'),
    LayoutConst.i8(property: 'equalityProofInstructionOffset'),
    LayoutConst.i8(property: 'rangeProofInstructionOffset'),
  ]);

  factory SPLToken2022ConfidentialWithdrawLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    return SPLToken2022ConfidentialWithdrawLayout(
      amount: decode['amount'],
      decimals: decode['decimals'],
      newDecryptableAvailableBalance:
          (decode['newDecryptableAvailableBalance'] as List).cast<int>(),
      equalityProofInstructionOffset: decode['equalityProofInstructionOffset'],
      rangeProofInstructionOffset: decode['rangeProofInstructionOffset'],
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'confidentialTransfer': ConfidentialTransferInstruction.withdraw.value,
      'amount': amount,
      'decimals': decimals,
      'newDecryptableAvailableBalance': newDecryptableAvailableBalance,
      'equalityProofInstructionOffset': equalityProofInstructionOffset,
      'rangeProofInstructionOffset': rangeProofInstructionOffset,
    };
  }
}

/// Transfer (27, 7).
class SPLToken2022ConfidentialTransferLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  final List<int> newSourceDecryptableAvailableBalance;
  final List<int> transferAmountAuditorCiphertextLo;
  final List<int> transferAmountAuditorCiphertextHi;
  final int equalityProofInstructionOffset;
  final int ciphertextValidityProofInstructionOffset;
  final int rangeProofInstructionOffset;
  SPLToken2022ConfidentialTransferLayout({
    required List<int> newSourceDecryptableAvailableBalance,
    required List<int> transferAmountAuditorCiphertextLo,
    required List<int> transferAmountAuditorCiphertextHi,
    required this.equalityProofInstructionOffset,
    required this.ciphertextValidityProofInstructionOffset,
    required this.rangeProofInstructionOffset,
  }) : newSourceDecryptableAvailableBalance =
           newSourceDecryptableAvailableBalance.asImmutableBytes,
       transferAmountAuditorCiphertextLo =
           transferAmountAuditorCiphertextLo.asImmutableBytes,
       transferAmountAuditorCiphertextHi =
           transferAmountAuditorCiphertextHi.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
    LayoutConst.blob(36, property: 'newSourceDecryptableAvailableBalance'),
    LayoutConst.blob(64, property: 'transferAmountAuditorCiphertextLo'),
    LayoutConst.blob(64, property: 'transferAmountAuditorCiphertextHi'),
    LayoutConst.i8(property: 'equalityProofInstructionOffset'),
    LayoutConst.i8(property: 'ciphertextValidityProofInstructionOffset'),
    LayoutConst.i8(property: 'rangeProofInstructionOffset'),
  ]);

  factory SPLToken2022ConfidentialTransferLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    return SPLToken2022ConfidentialTransferLayout(
      newSourceDecryptableAvailableBalance:
          (decode['newSourceDecryptableAvailableBalance'] as List).cast<int>(),
      transferAmountAuditorCiphertextLo:
          (decode['transferAmountAuditorCiphertextLo'] as List).cast<int>(),
      transferAmountAuditorCiphertextHi:
          (decode['transferAmountAuditorCiphertextHi'] as List).cast<int>(),
      equalityProofInstructionOffset: decode['equalityProofInstructionOffset'],
      ciphertextValidityProofInstructionOffset:
          decode['ciphertextValidityProofInstructionOffset'],
      rangeProofInstructionOffset: decode['rangeProofInstructionOffset'],
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'confidentialTransfer': ConfidentialTransferInstruction.transfer.value,
      'newSourceDecryptableAvailableBalance':
          newSourceDecryptableAvailableBalance,
      'transferAmountAuditorCiphertextLo': transferAmountAuditorCiphertextLo,
      'transferAmountAuditorCiphertextHi': transferAmountAuditorCiphertextHi,
      'equalityProofInstructionOffset': equalityProofInstructionOffset,
      'ciphertextValidityProofInstructionOffset':
          ciphertextValidityProofInstructionOffset,
      'rangeProofInstructionOffset': rangeProofInstructionOffset,
    };
  }
}

/// ApplyPendingBalance (27, 8).
class SPLToken2022ConfidentialApplyPendingBalanceLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  final BigInt expectedPendingBalanceCreditCounter;
  final List<int> newDecryptableAvailableBalance;
  SPLToken2022ConfidentialApplyPendingBalanceLayout({
    required this.expectedPendingBalanceCreditCounter,
    required List<int> newDecryptableAvailableBalance,
  }) : newDecryptableAvailableBalance =
           newDecryptableAvailableBalance.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
    LayoutConst.u64(property: 'expectedPendingBalanceCreditCounter'),
    LayoutConst.blob(36, property: 'newDecryptableAvailableBalance'),
  ]);

  factory SPLToken2022ConfidentialApplyPendingBalanceLayout.fromBuffer(
    List<int> bytes,
  ) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    return SPLToken2022ConfidentialApplyPendingBalanceLayout(
      expectedPendingBalanceCreditCounter:
          decode['expectedPendingBalanceCreditCounter'],
      newDecryptableAvailableBalance:
          (decode['newDecryptableAvailableBalance'] as List).cast<int>(),
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'confidentialTransfer':
          ConfidentialTransferInstruction.applyPendingBalance.value,
      'expectedPendingBalanceCreditCounter':
          expectedPendingBalanceCreditCounter,
      'newDecryptableAvailableBalance': newDecryptableAvailableBalance,
    };
  }
}

/// Empty credit-toggle layouts (27, 9-12).
class SPLToken2022ConfidentialToggleCreditsLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  final ConfidentialTransferInstruction toggle;
  const SPLToken2022ConfidentialToggleCreditsLayout({required this.toggle});

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
  ]);

  factory SPLToken2022ConfidentialToggleCreditsLayout.fromBuffer(
    List<int> bytes,
  ) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    final type = ConfidentialTransferInstruction.fromValue(
      decode['confidentialTransfer'],
    );
    if (type == null ||
        (type != ConfidentialTransferInstruction.enableConfidentialCredits &&
            type !=
                ConfidentialTransferInstruction.disableConfidentialCredits &&
            type !=
                ConfidentialTransferInstruction.enableNonConfidentialCredits &&
            type !=
                ConfidentialTransferInstruction
                    .disableNonConfidentialCredits)) {
      throw BuError(
        DefaultErrorType.invalidArgument,
        'Unexpected credit-toggle discriminant.',
      );
    }
    return SPLToken2022ConfidentialToggleCreditsLayout(toggle: type);
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {'confidentialTransfer': toggle.value};
  }
}

/// TransferWithFee (27, 13).
class SPLToken2022ConfidentialTransferWithFeeLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  final List<int> newSourceDecryptableAvailableBalance;
  final List<int> transferAmountAuditorCiphertextLo;
  final List<int> transferAmountAuditorCiphertextHi;
  final int equalityProofInstructionOffset;
  final int transferAmountCiphertextValidityProofInstructionOffset;
  final int feeSigmaProofInstructionOffset;
  final int feeCiphertextValidityProofInstructionOffset;
  final int rangeProofInstructionOffset;
  SPLToken2022ConfidentialTransferWithFeeLayout({
    required List<int> newSourceDecryptableAvailableBalance,
    required List<int> transferAmountAuditorCiphertextLo,
    required List<int> transferAmountAuditorCiphertextHi,
    required this.equalityProofInstructionOffset,
    required this.transferAmountCiphertextValidityProofInstructionOffset,
    required this.feeSigmaProofInstructionOffset,
    required this.feeCiphertextValidityProofInstructionOffset,
    required this.rangeProofInstructionOffset,
  }) : newSourceDecryptableAvailableBalance =
           newSourceDecryptableAvailableBalance.asImmutableBytes,
       transferAmountAuditorCiphertextLo =
           transferAmountAuditorCiphertextLo.asImmutableBytes,
       transferAmountAuditorCiphertextHi =
           transferAmountAuditorCiphertextHi.asImmutableBytes;

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
    LayoutConst.blob(36, property: 'newSourceDecryptableAvailableBalance'),
    LayoutConst.blob(64, property: 'transferAmountAuditorCiphertextLo'),
    LayoutConst.blob(64, property: 'transferAmountAuditorCiphertextHi'),
    LayoutConst.i8(property: 'equalityProofInstructionOffset'),
    LayoutConst.i8(
      property: 'transferAmountCiphertextValidityProofInstructionOffset',
    ),
    LayoutConst.i8(property: 'feeSigmaProofInstructionOffset'),
    LayoutConst.i8(property: 'feeCiphertextValidityProofInstructionOffset'),
    LayoutConst.i8(property: 'rangeProofInstructionOffset'),
  ]);

  factory SPLToken2022ConfidentialTransferWithFeeLayout.fromBuffer(
    List<int> bytes,
  ) {
    final decode = ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    return SPLToken2022ConfidentialTransferWithFeeLayout(
      newSourceDecryptableAvailableBalance:
          (decode['newSourceDecryptableAvailableBalance'] as List).cast<int>(),
      transferAmountAuditorCiphertextLo:
          (decode['transferAmountAuditorCiphertextLo'] as List).cast<int>(),
      transferAmountAuditorCiphertextHi:
          (decode['transferAmountAuditorCiphertextHi'] as List).cast<int>(),
      equalityProofInstructionOffset: decode['equalityProofInstructionOffset'],
      transferAmountCiphertextValidityProofInstructionOffset:
          decode['transferAmountCiphertextValidityProofInstructionOffset'],
      feeSigmaProofInstructionOffset: decode['feeSigmaProofInstructionOffset'],
      feeCiphertextValidityProofInstructionOffset:
          decode['feeCiphertextValidityProofInstructionOffset'],
      rangeProofInstructionOffset: decode['rangeProofInstructionOffset'],
    );
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'confidentialTransfer':
          ConfidentialTransferInstruction.transferWithFee.value,
      'newSourceDecryptableAvailableBalance':
          newSourceDecryptableAvailableBalance,
      'transferAmountAuditorCiphertextLo': transferAmountAuditorCiphertextLo,
      'transferAmountAuditorCiphertextHi': transferAmountAuditorCiphertextHi,
      'equalityProofInstructionOffset': equalityProofInstructionOffset,
      'transferAmountCiphertextValidityProofInstructionOffset':
          transferAmountCiphertextValidityProofInstructionOffset,
      'feeSigmaProofInstructionOffset': feeSigmaProofInstructionOffset,
      'feeCiphertextValidityProofInstructionOffset':
          feeCiphertextValidityProofInstructionOffset,
      'rangeProofInstructionOffset': rangeProofInstructionOffset,
    };
  }
}

/// ConfigureAccountWithRegistry (27, 14). Empty payload; the
/// ElGamal registry account replaces the pubkey-validity proof.
class SPLToken2022ConfidentialConfigureAccountWithRegistryLayout
    extends SPLToken2022ConfidentialTransferLayoutBase {
  const SPLToken2022ConfidentialConfigureAccountWithRegistryLayout();

  static StructLayout get _layout => LayoutConst.struct([
    LayoutConst.u8(property: 'instruction'),
    LayoutConst.u8(property: 'confidentialTransfer'),
  ]);

  factory SPLToken2022ConfidentialConfigureAccountWithRegistryLayout.fromBuffer(
    List<int> bytes,
  ) {
    ProgramLayout.decodeAndValidateStruct(
      layout: _layout,
      bytes: bytes,
      instruction:
          SPLTokenProgramInstruction.confidentialTransferExtension.instruction,
    );
    return const SPLToken2022ConfidentialConfigureAccountWithRegistryLayout();
  }

  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {
      'confidentialTransfer':
          ConfidentialTransferInstruction.configureAccountWithRegistry.value,
    };
  }
}
