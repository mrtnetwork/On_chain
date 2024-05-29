import 'package:blockchain_utils/exception/exception.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/spl_token/constant.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts.dart';
import 'package:on_chain/solana/src/instructions/spl_token/utils/utils/spl_token_utils.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

class SPLToken2022ExtensionsProgram extends TransactionInstruction {
  SPLToken2022ExtensionsProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);

  /// Allow or lock all token operations to happen via CPI as normal.
  factory SPLToken2022ExtensionsProgram.toggleCpiGuard({
    /// The account to update.
    required SolAddress account,

    /// The account's owner.
    required SolAddress authority,
    required SPLToken2022ToggleCpiGuardLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,

    /// Multisignature authority
    List<SolAddress> multiSigners = const [],
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: SPLTokenUtils.buildKeys(
            keys: [account.toWritable()],
            owner: authority,
            multiSigners: multiSigners),
        programId: programId,
        layout: layout);
  }

  /// Initialize a new mint with the default state for new Accounts.
  factory SPLToken2022ExtensionsProgram.initializeDefaultAccountState(
      {
      /// The mint to initialize.
      required SolAddress mint,
      required SPLToken2022InitializeDefaultAccountStateLayout layout,
      SolAddress programId = SPLTokenProgramConst.token2022ProgramId}) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: [mint.toWritable()], programId: programId, layout: layout);
  }

  /// Update the default state for new Accounts. Only supported for mints that
  /// include the [DefaultAccountState] extension.
  factory SPLToken2022ExtensionsProgram.updateDefaultAccountState({
    /// The mint.
    required SolAddress mint,

    /// The mint freeze authority.
    required SolAddress freezeAuthority,
    required SPLToken2022UpdateDefaultAccountStateLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,

    /// Multisignature authority
    List<SolAddress> multiSigners = const [],
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: SPLTokenUtils.buildKeys(
            keys: [mint.toWritable()],
            owner: freezeAuthority,
            multiSigners: multiSigners),
        programId: programId,
        layout: layout);
  }

  /// Initialize a new mint with interest accrual.
  factory SPLToken2022ExtensionsProgram.initializeInterestBearingMint(
      {
      /// The mint to initialize.
      required SolAddress mint,
      required SPLToken2022InterestBearingMintInitializeLayout layout,
      SolAddress programId = SPLTokenProgramConst.token2022ProgramId}) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: [mint.toWritable()], programId: programId, layout: layout);
  }

  /// Update the interest rate. Only supported for mints that include the
  /// `InterestBearingConfig` extension.
  factory SPLToken2022ExtensionsProgram.updateRateInterestBearingMint({
    /// The mint.
    required SolAddress mint,

    /// The mint rate authority.
    required SolAddress rateAuthority,
    required SPLToken2022InterestBearingMintUpdateRateLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,

    /// Multisignature authority
    List<SolAddress> multiSigners = const [],
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: SPLTokenUtils.buildKeys(keys: [
          mint.toWritable(),
          if (multiSigners.isEmpty)
            rateAuthority.toSigner()
          else
            rateAuthority.toReadOnly()
        ], owner: rateAuthority, multiSigners: multiSigners),
        programId: programId,
        layout: layout);
  }

  /// Require memos or Stop requiring memos for transfers into this Account.
  factory SPLToken2022ExtensionsProgram.toggleMemoTransfers({
    /// The account to update.
    required SolAddress account,

    /// The account's owner.
    required SolAddress authority,
    required SPLToken2022ToggleMemoTransferLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,

    /// Multisignature authority
    List<SolAddress> multiSigners = const [],
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: SPLTokenUtils.buildKeys(
            keys: [account.toWritable()],
            owner: authority,
            multiSigners: multiSigners),
        programId: programId,
        layout: layout);
  }

  /// Initialize a new mint with a metadata pointer
  factory SPLToken2022ExtensionsProgram.initializeMetadataPointer(
      {
      /// The mint to initialize.
      required SolAddress mint,
      required SPLToken2022InitializeMetadataPointerLayout layout,
      SolAddress programId = SPLTokenProgramConst.token2022ProgramId}) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: [mint.toWritable()], programId: programId, layout: layout);
  }

  /// Update the metadata pointer address. Only supported for mints that
  /// include the `MetadataPointer` extension.
  factory SPLToken2022ExtensionsProgram.updateMetadataPointer({
    /// The mint.
    required SolAddress mint,

    /// The metadata pointer authority.
    required SolAddress authority,
    required SPLToken2022UpdateMetadataPointerLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,

    /// Multisignature authority
    List<SolAddress> multiSigners = const [],
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: SPLTokenUtils.buildKeys(
            keys: [mint.toWritable()],
            owner: authority,
            multiSigners: multiSigners),
        programId: programId,
        layout: layout);
  }

  /// Initialize the transfer fee on a new mint.
  factory SPLToken2022ExtensionsProgram.initializeTransferFeeConfig({
    /// The mint to initialize.
    required SolAddress mint,
    required SPLToken2022InitializeTransferFeeConfigLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: [mint.toWritable()], programId: programId, layout: layout);
  }

  /// Transfer, providing expected mint information and fees
  factory SPLToken2022ExtensionsProgram.transferCheckedWithFee({
    /// The source account. Must include the
    /// [TransferFeeAmount] extension.
    required SolAddress source,

    /// he token mint.
    required SolAddress mint,

    /// The destination account.
    required SolAddress destination,

    /// The source account's owner/delegate.
    required SolAddress authority,
    required SPLToken2022TransferCheckedWithFeeLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,

    /// Multisignature owner/delegate
    List<SolAddress> multiSigners = const [],
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: SPLTokenUtils.buildKeys(keys: [
          source.toWritable(),
          mint.toReadOnly(),
          destination.toWritable()
        ], owner: authority, multiSigners: multiSigners),
        programId: programId,
        layout: layout);
  }

  /// Transfer all withheld tokens in the mint to an account. Signed by the
  /// mint's withdraw withheld tokens authority.
  factory SPLToken2022ExtensionsProgram.withdrawWithheldTokensFromMint({
    /// The token mint.
    required SolAddress mint,

    /// The fee receiver account.
    required SolAddress destination,

    /// The mint's withdraw withheld authority.
    required SolAddress authority,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,

    /// Multisignature owner/delegate
    List<SolAddress> multiSigners = const [],
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: SPLTokenUtils.buildKeys(
            keys: [mint.toWritable(), destination.toWritable()],
            owner: authority,
            multiSigners: multiSigners),
        programId: programId,
        layout: SPLToken2022WithdrawWithheldTokensFromMintLayout());
  }

  /// Transfer all withheld tokens to an account. Signed by the mint's
  /// withdraw withheld tokens authority.
  factory SPLToken2022ExtensionsProgram.withdrawWithheldTokensFromAccounts(
      {
      /// The token mint.
      required SolAddress mint,

      /// The fee receiver account.
      required SolAddress destination,

      /// The mint's withdraw withheld authority.
      required SolAddress authority,

      /// The source accounts to withdraw from.
      required List<SolAddress> sources,
      SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
      List<SolAddress> multiSigners = const []}) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: [
          ...SPLTokenUtils.buildKeys(
              keys: [mint.toWritable(), destination.toWritable()],
              owner: authority,
              multiSigners: multiSigners),
          ...sources.map((e) => e.toWritable())
        ],
        programId: programId,
        layout: SPLToken2022WithdrawWithheldTokensFromAccountsLayout(
            numTokenAccounts: sources.length));
  }

  /// Permissionless instruction to transfer all withheld tokens to the mint.
  factory SPLToken2022ExtensionsProgram.harvestWithheldTokensToMint(
      {
      /// The mint.
      required SolAddress mint,

      /// The source accounts to harvest from.
      required List<SolAddress> sources,
      SolAddress programId = SPLTokenProgramConst.token2022ProgramId}) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: [mint.toWritable(), ...sources.map((e) => e.toWritable())],
        programId: programId,
        layout: SPLToken2022HarvestWithheldTokensToMintLayout());
  }

  /// Initialize a new mint with a transfer hook program.
  factory SPLToken2022ExtensionsProgram.initializeTransferHook(
      {
      /// The mint to initialize.
      required SolAddress mint,
      required SPLToken2022InitializeTransferHookLayout layout,
      SolAddress programId = SPLTokenProgramConst.token2022ProgramId}) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: [mint.toWritable()], programId: programId, layout: layout);
  }

  /// Update the transfer hook program id. Only supported for mints that
  /// include the `TransferHook` extension.
  factory SPLToken2022ExtensionsProgram.updateTransferHook({
    /// The mint.
    required SolAddress mint,

    /// The transfer hook authority.
    required SolAddress authority,
    required SPLToken2022UpdateTransferHookLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,

    /// Multisignature authority
    List<SolAddress> multiSigners = const [],
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: SPLTokenUtils.buildKeys(
            keys: [mint.toWritable()],
            owner: authority,
            multiSigners: multiSigners),
        programId: programId,
        layout: layout);
  }
  factory SPLToken2022ExtensionsProgram.execute(
      {required SolAddress mint,
      required SolAddress source,
      required SolAddress destination,
      required SolAddress owner,
      required SolAddress validateStatePubkey,
      required SPLToken2022ExecuteLayout layout,
      SolAddress programId = SPLTokenProgramConst.token2022ProgramId}) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(keys: [
      source.toReadOnly(),
      mint.toReadOnly(),
      destination.toReadOnly(),
      owner.toReadOnly(),
      validateStatePubkey.toReadOnly()
    ], programId: programId, layout: layout);
  }

  factory SPLToken2022ExtensionsProgram.initializeGroupMemberPointer({
    required SolAddress mint,
    required SPLToken2022InitializeGroupMemberPointerLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: [mint.toWritable()], programId: programId, layout: layout);
  }

  factory SPLToken2022ExtensionsProgram.updateGroupMemberPointer({
    required SolAddress mint,
    required SolAddress authority,
    required SPLToken2022UpdateGroupMemberPointerLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
    List<SolAddress> multiSigners = const [],
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: SPLTokenUtils.buildKeys(
            keys: [mint.toWritable()],
            owner: authority,
            multiSigners: multiSigners),
        programId: programId,
        layout: layout);
  }

  /// Initialize GroupPointer instruction
  factory SPLToken2022ExtensionsProgram.initializeGroupPointer({
    /// Token mint account
    required SolAddress mint,
    required SPLToken2022InitializeGroupPointerLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: [mint.toWritable()], programId: programId, layout: layout);
  }

  /// Update GroupPointer instruction
  factory SPLToken2022ExtensionsProgram.updateGroupPointer({
    /// The mint.
    required SolAddress mint,

    /// The transfer hook authority.
    required SolAddress authority,
    required SPLToken2022UpdateGroupPointerLayout layout,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,

    /// Multisignature authority
    List<SolAddress> multiSigners = const [],
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const MessageException("Token program does not support extensions");
    }
    return SPLToken2022ExtensionsProgram(
        keys: SPLTokenUtils.buildKeys(
            keys: [mint.toWritable()],
            owner: authority,
            multiSigners: multiSigners),
        programId: programId,
        layout: layout);
  }
}
