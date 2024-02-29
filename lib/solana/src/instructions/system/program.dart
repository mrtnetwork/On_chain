import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/program_layouts/core/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/layouts.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

class SystemProgram extends TransactionInstruction {
  SystemProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);

  factory SystemProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = SystemProgramConst.programId,
  }) {
    return SystemProgram(
        layout: SystemProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Transfer system transaction
  factory SystemProgram.transfer({
    required SystemTransferLayout layout,

    /// Account that will transfer lamports
    required SolAddress from,

    /// Account that will receive transferred lamports
    required SolAddress to,
  }) {
    return SystemProgram(
        layout: layout,
        keys: [
          AccountMeta(publicKey: from, isSigner: true, isWritable: true),
          AccountMeta(publicKey: to, isSigner: false, isWritable: true)
        ],
        programId: SystemProgramConst.programId);
  }

  /// Create account system transaction
  factory SystemProgram.createAccount({
    /// The account that will transfer lamports to the created account
    required SolAddress from,

    /// address of the created account
    required SolAddress newAccountPubKey,
    required SystemCreateLayout layout,
  }) {
    return SystemProgram(
        layout: layout,
        keys: [
          AccountMeta(publicKey: from, isSigner: true, isWritable: true),
          AccountMeta(
              publicKey: newAccountPubKey, isSigner: true, isWritable: true)
        ],
        programId: SystemProgramConst.programId);
  }

  /// Transfer with seed system transaction
  factory SystemProgram.transferWithSeed({
    /// Account that will transfer lamports
    required SolAddress from,

    /// Account that will receive transferred lamports
    required SolAddress to,

    /// base address to use to derive the funding account address
    required SolAddress baseAccount,
    required SystemTransferWithSeedLayout layout,
  }) {
    return SystemProgram(
        layout: layout,
        keys: [
          AccountMeta(publicKey: from, isSigner: false, isWritable: true),
          AccountMeta(
              publicKey: baseAccount, isSigner: true, isWritable: false),
          AccountMeta(publicKey: to, isSigner: false, isWritable: true)
        ],
        programId: SystemProgramConst.programId);
  }

  /// Create account with seed system transaction
  factory SystemProgram.createAccountWithSeed({
    /// The account that will transfer lamports to the created account
    required SolAddress from,

    /// address of the created account.
    required SolAddress newAccount,

    /// Base address to use to derive the address of the created account
    required SolAddress baseAccount,
    required SystemCreateWithSeedLayout layout,
  }) {
    return SystemProgram(
        layout: layout,
        keys: [
          AccountMeta(publicKey: from, isSigner: true, isWritable: true),
          AccountMeta(publicKey: newAccount, isSigner: false, isWritable: true)
        ],
        programId: SystemProgramConst.programId);
  }

  /// Assign system transaction
  factory SystemProgram.assign({
    /// address of the account which will be assigned a new owner
    required SolAddress account,
    required SystemAssignLayout layout,
  }) {
    return SystemProgram(
        layout: layout,
        keys: [
          AccountMeta(publicKey: account, isSigner: true, isWritable: true)
        ],
        programId: SystemProgramConst.programId);
  }

  /// Assign account with seed system transaction
  factory SystemProgram.assignWithSeed({
    /// address of the account which will be assigned a new owner
    required SolAddress account,
    required SystemAssignWithSeedLayout layout,
  }) {
    return SystemProgram(
        layout: layout,
        keys: [
          AccountMeta(publicKey: account, isSigner: false, isWritable: true),
          AccountMeta(publicKey: layout.base, isSigner: true, isWritable: true)
        ],
        programId: SystemProgramConst.programId);
  }

  /// Initialize nonce account system
  factory SystemProgram.nonceInitialize(
      {
      /// Nonce account which will be initialized
      required SolAddress noncePubKey,
      required SystemInitializeNonceAccountLayout layout}) {
    return SystemProgram(
        layout: layout,
        keys: [
          noncePubKey.toWritable(),
          SystemProgramConst.sysvarRecentBlockhashesPubkey.toReadOnly(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly(),
        ],
        programId: SystemProgramConst.programId);
  }

  /// Advance nonce account system
  factory SystemProgram.nonceAdvance({
    /// Public key of the nonce authority
    required SolAddress authorizedPubkey,

    /// Nonce account
    required SolAddress noncePubKey,
  }) {
    return SystemProgram(
        layout: SystemAdvanceNonceLayout(),
        keys: [
          noncePubKey.toWritable(),
          SystemProgramConst.sysvarRecentBlockhashesPubkey.toReadOnly(),
          authorizedPubkey.toSigner()
        ],
        programId: SystemProgramConst.programId);
  }

  /// Withdraw nonce account system transaction
  factory SystemProgram.nonceWithdraw({
    /// address of the nonce authority
    required SolAddress authorizedPubkey,

    /// Nonce account
    required SolAddress noncePubKey,

    /// address of the account which will receive the withdrawn nonce account balance
    required SolAddress toPubKey,
    required SystemWithdrawNonceLayout layout,
  }) {
    return SystemProgram(
        layout: layout,
        keys: [
          noncePubKey.toWritable(),
          toPubKey.toWritable(),
          SystemProgramConst.sysvarRecentBlockhashesPubkey.toReadOnly(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly(),
          authorizedPubkey.toSigner(),
        ],
        programId: SystemProgramConst.programId);
  }

  /// Authorize nonce account system transaction
  factory SystemProgram.nonceAuthorize(
      {
      /// address of the current nonce authority
      required SolAddress authorizedPubkey,

      /// Nonce account
      required SolAddress noncePubKey,
      required SystemAuthorizeNonceAccountLayout layout}) {
    return SystemProgram(
        layout: layout,
        keys: [
          AccountMeta(
              publicKey: noncePubKey, isSigner: false, isWritable: true),
          AccountMeta(
              publicKey: authorizedPubkey, isSigner: true, isWritable: false)
        ],
        programId: SystemProgramConst.programId);
  }

  /// Allocate account system transaction
  factory SystemProgram.allocate({
    /// Account to allocate
    required SolAddress accountPubkey,
    required SystemAllocateLayout layout,
  }) {
    return SystemProgram(
        layout: layout,
        keys: [accountPubkey.toSignerAndWritable()],
        programId: SystemProgramConst.programId);
  }

  /// Allocate account with seed system transaction
  factory SystemProgram.allocateWithcSeed(
      {
      /// Account to allocate
      required SolAddress accountPubkey,
      required SystemAllocateWithSeedLayout layout}) {
    return SystemProgram(
        layout: layout,
        keys: [
          AccountMeta(
              publicKey: accountPubkey, isSigner: false, isWritable: true),
          layout.base.toSigner(),
        ],
        programId: SystemProgramConst.programId);
  }
}
