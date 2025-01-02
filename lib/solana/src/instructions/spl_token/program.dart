import 'package:on_chain/solana/src/exception/exception.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/spl_token/constant.dart';
import 'package:on_chain/solana/src/instructions/spl_token/utils/utils/spl_token_utils.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';
import 'layouts/layouts.dart';

/// This class represents instructions for interacting with the SPL Token Program
class SPLTokenProgram extends TransactionInstruction {
  SPLTokenProgram({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());
  factory SPLTokenProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = SPLTokenProgramConst.tokenProgramId,
  }) {
    return SPLTokenProgram(
        layout: SPLTokenProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Convert an Amount of tokens to a UiAmount `string`, using the given
  /// mint. In this version of the program, the mint can only specify the
  /// number of decimals.
  factory SPLTokenProgram.amountToUiAmount(
      {required SPLTokenAmountToUiAmountLayout layout,

      /// The mint to calculate for
      required SolAddress mint,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId}) {
    return SPLTokenProgram(
        layout: layout, keys: [mint.toReadOnly()], programId: programId);
  }

  /// Approves a delegate.  A delegate is given the authority over tokens on
  /// behalf of the source account's owner.
  factory SPLTokenProgram.approve(
      {required SPLTokenApproveLayout layout,

      /// The source account.
      required SolAddress account,

      /// The delegate.
      required SolAddress delegate,

      /// The source account owner.
      required SolAddress owner,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId,

      /// Multisignature owner
      List<SolAddress> multiSigners = const []}) {
    return SPLTokenProgram(
        layout: layout,
        keys: SPLTokenUtils.buildKeys(
            keys: [account.toWritable(), delegate.toReadOnly()],
            owner: owner,
            multiSigners: multiSigners),
        programId: programId);
  }

  /// Approves a delegate.  A delegate is given the authority over tokens on
  /// behalf of the source account's owner.
  ///
  /// This instruction differs from Approve in that the token mint and
  /// decimals value is checked by the caller.
  factory SPLTokenProgram.approveChecked(
      {required SPLTokenApproveCheckedLayout layout,

      /// The source account.
      required SolAddress account,

      /// The token mint.
      required SolAddress mint,

      /// The delegate.
      required SolAddress delegate,

      /// The source account owner.
      required SolAddress owner,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId,

      /// The source account's multisignature owner.
      List<SolAddress> multiSigners = const []}) {
    return SPLTokenProgram(
        layout: layout,
        keys: SPLTokenUtils.buildKeys(keys: [
          account.toWritable(),
          mint.toReadOnly(),
          delegate.toReadOnly()
        ], owner: owner, multiSigners: multiSigners),
        programId: programId);
  }

  /// Burns tokens by removing them from an account. [SPLTokenProgram.burn] does not support
  /// accounts associated with the native mint, use [SPLTokenProgram.closeAccount] instead.
  factory SPLTokenProgram.burn(
      {required SPLTokenBurnLayout layout,

      ///  The account to burn from.
      required SolAddress account,

      /// The token mint.
      required SolAddress mint,

      /// The account's owner/delegate.
      required SolAddress owner,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId,

      /// Multisignature owner/delegate
      List<SolAddress> multiSigners = const []}) {
    return SPLTokenProgram(
        layout: layout,
        keys: SPLTokenUtils.buildKeys(keys: [
          account.toWritable(),
          mint.toWritable(),
        ], owner: owner, multiSigners: multiSigners),
        programId: programId);
  }

  /// Burns tokens by removing them from an account.  [SPLTokenProgram.burnChecked] does not
  /// support accounts associated with the native mint, use [SPLTokenProgram.closeAccount]
  /// instead.
  ///
  /// This instruction differs from Burn in that the decimals value is checked
  /// by the caller.
  factory SPLTokenProgram.burnChecked({
    required SPLTokenBurnCheckedLayout layout,

    /// The account to burn from.
    required SolAddress account,

    /// The token mint.
    required SolAddress mint,

    /// The account's owner/delegate.
    required SolAddress owner,
    SolAddress programId = SPLTokenProgramConst.tokenProgramId,

    /// Multisignature owner/delegate
    List<SolAddress> multiSigners = const [],
  }) {
    return SPLTokenProgram(
        layout: layout,
        keys: SPLTokenUtils.buildKeys(keys: [
          account.toWritable(),
          mint.toWritable(),
        ], owner: owner, multiSigners: multiSigners),
        programId: programId);
  }

  /// Close an account by transferring all its SOL to the destination account.
  /// Non-native accounts may only be closed if its token amount is zero.
  factory SPLTokenProgram.closeAccount(
      {
      /// The account to close.
      required SolAddress account,

      /// The destination account.
      required SolAddress destination,

      /// The account's owner.
      required SolAddress authority,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId,

      /// Multisignature owner
      List<SolAddress> multiSigners = const []}) {
    return SPLTokenProgram(
        layout: SPLTokenCloseAccountLayout(),
        keys: SPLTokenUtils.buildKeys(keys: [
          account.toWritable(),
          destination.toWritable(),
        ], owner: authority, multiSigners: multiSigners),
        programId: programId);
  }

  /// Creates the native mint.
  factory SPLTokenProgram.createNativeMint(
      {
      /// Funding account (must be a system account)
      required SolAddress payer,

      /// The native mint address
      SolAddress nativeMintId = SPLTokenProgramConst.nativeMint2022,
      SolAddress programId = SPLTokenProgramConst.token2022ProgramId}) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const SolanaPluginException(
          'Token program id does not support extensions');
    }
    return SPLTokenProgram(
        layout: SPLTokenCreateNativeMintLayout(),
        keys: [
          payer.toSignerAndWritable(),
          nativeMintId.toWritable(),
          SystemProgramConst.programId.toReadOnly()
        ],
        programId: programId);
  }

  /// Freeze an Initialized account.
  factory SPLTokenProgram.freezeAccount({
    /// The account to freeze.
    required SolAddress account,

    /// The token mint.
    required SolAddress mint,

    /// The mint freeze authority.
    required SolAddress authority,
    SolAddress programId = SPLTokenProgramConst.tokenProgramId,

    /// Multisignature owner
    List<SolAddress> multiSigners = const [],
  }) {
    return SPLTokenProgram(
        layout: SPLTokenFreezAccountLayout(),
        keys: SPLTokenUtils.buildKeys(keys: [
          account.toWritable(),
          mint.toReadOnly(),
        ], owner: authority, multiSigners: multiSigners),
        programId: programId);
  }

  /// Initializes a new account to hold tokens.  If this account is associated
  /// with the native mint then the token balance of the initialized account
  /// will be equal to the amount of SOL in the account. If this account is
  /// associated with another mint, that mint must be initialized before this
  /// command can succeed.
  ///
  factory SPLTokenProgram.initializeAccount(
      {
      /// The account to initialize.
      required SolAddress account,

      /// The mint this account will be associated with.
      required SolAddress mint,

      /// The new account's owner/multisignature.
      required SolAddress owner,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId}) {
    return SPLTokenProgram(
        layout: SPLTokenInitializeAccountLayout(),
        keys: [
          account.toWritable(),
          mint.toReadOnly(),
          owner.toReadOnly(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly(),
        ],
        programId: programId);
  }

  /// Like InitializeAccount, but the owner pubkey is passed via instruction
  /// data rather than the accounts list. This variant may be preferable
  /// when using Cross Program Invocation from an instruction that does
  /// not need the owner's AccountInfo otherwise.
  ///
  factory SPLTokenProgram.initializeAccount2(
      {required SPLTokenInitializeAccount2Layout layout,

      /// The account to initialize.
      required SolAddress account,

      /// The mint this account will be associated with.
      required SolAddress mint,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId}) {
    return SPLTokenProgram(
        layout: layout,
        keys: [
          account.toWritable(),
          mint.toReadOnly(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly(),
        ],
        programId: programId);
  }

  /// Like InitializeAccount2, but does not require the Rent sysvar to be
  /// provided
  ///
  factory SPLTokenProgram.initializeAccount3(
      {required SPLTokenInitializeAccount3Layout layout,

      /// The account to initialize.
      required SolAddress account,

      /// The mint this account will be associated with.
      required SolAddress mint,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId}) {
    return SPLTokenProgram(
        layout: layout,
        keys: [
          account.toWritable(),
          mint.toReadOnly(),
        ],
        programId: programId);
  }

  /// Initialize the Immutable Owner extension for the given token account
  factory SPLTokenProgram.initializeImmutableOwner(
      {
      /// The account to initialize.
      required SolAddress account,
      required SolAddress programId}) {
    return SPLTokenProgram(
        layout: SPLTokenInitializeImmutableOwnerLayout(),
        keys: [account.toWritable()],
        programId: programId);
  }

  /// Initializes a new mint and optionally deposits all the newly minted
  /// tokens in an account.
  factory SPLTokenProgram.initializeMint(
      {required SPLTokenInitializeMintLayout layout,

      /// The mint to initialize.
      required SolAddress mint,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId}) {
    return SPLTokenProgram(
        layout: layout,
        keys: [
          mint.toWritable(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly()
        ],
        programId: programId);
  }

  /// Like [SPLTokenProgram.initializeMint], but does not require the Rent sysvar to be
  /// provided
  factory SPLTokenProgram.initializeMint2(
      {required SPLTokenInitializeMint2Layout layout,

      /// The mint to initialize.
      required SolAddress mint,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId}) {
    return SPLTokenProgram(
        layout: layout, keys: [mint.toWritable()], programId: programId);
  }

  /// Initialize the close account authority on a new mint.
  factory SPLTokenProgram.initializeMintCloseAuthority(
      {required SPLTokenInitializeMintCloseAuthorityLayout layout,

      /// The mint to initialize.
      required SolAddress mint,
      required SolAddress programId}) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const SolanaPluginException(
          'Token program does not support extensions');
    }
    return SPLTokenProgram(
        layout: layout, keys: [mint.toWritable()], programId: programId);
  }

  /// Initializes a multisignature account with N provided signers.
  ///
  /// Multisignature accounts can used in place of any single owner/delegate
  /// accounts in any token instruction that require an owner/delegate to be
  /// present.  The variant field represents the number of signers (M)
  /// required to validate this multisignature account.
  factory SPLTokenProgram.initializeMultisig(
      {required SPLTokenInitializeMultisigLayout layout,

      /// The multisignature account to initialize.
      required SolAddress account,

      /// The signer accounts
      required List<SolAddress> signers,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId}) {
    return SPLTokenProgram(
        layout: layout,
        keys: [
          account.toWritable(),
          SystemProgramConst.sysvarRentPubkey.toReadOnly(),
          ...signers.map((e) => e.toReadOnly())
        ],
        programId: programId);
  }

  /// Initialize the non transferable extension for the given mint account
  factory SPLTokenProgram.initializeNonTransferableMint(
      {
      /// The mint account to initialize.
      required SolAddress mint,
      required SolAddress programId}) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const SolanaPluginException(
          'Token program does not support extensions');
    }
    return SPLTokenProgram(
        layout: SPLTokenInitializeNonTransferableMintLayout(),
        keys: [mint.toWritable()],
        programId: programId);
  }

  /// Initialize the permanent delegate on a new mint.
  factory SPLTokenProgram.initializePermanentDelegate(
      {required SPLTokenInitializePermanentDelegateLayout layout,
      required SolAddress mint,
      required SolAddress programId}) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const SolanaPluginException(
          'Token program does not support extensions');
    }
    return SPLTokenProgram(
        layout: layout, keys: [mint.toWritable()], programId: programId);
  }

  /// Mints new tokens to an account.  The native mint does not support
  /// minting.
  factory SPLTokenProgram.mintTo(
      {required SPLTokenMintToLayout layout,

      /// The mint.
      required SolAddress mint,

      /// The account to mint tokens to.
      required SolAddress destination,

      /// The mint's minting authority.
      required SolAddress authority,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId,
      List<SolAddress> multiSigners = const []}) {
    return SPLTokenProgram(
        layout: layout,
        keys: SPLTokenUtils.buildKeys(keys: [
          mint.toWritable(),
          destination.toWritable(),
        ], owner: authority, multiSigners: multiSigners),
        programId: programId);
  }

  /// Mints new tokens to an account.  The native mint does not support
  /// minting.
  ///
  /// This instruction differs from MintTo in that the decimals value is
  /// checked by the caller.
  factory SPLTokenProgram.mintToChecked({
    required SPLTokenMintToCheckedLayout layout,

    /// The mint.
    required SolAddress mint,

    /// The account to mint tokens to.
    required SolAddress destination,

    /// The mint's minting authority.
    required SolAddress authority,
    SolAddress programId = SPLTokenProgramConst.tokenProgramId,

    /// Multisignature
    List<SolAddress> multiSigners = const [],
  }) {
    return SPLTokenProgram(
        layout: layout,
        keys: SPLTokenUtils.buildKeys(keys: [
          mint.toWritable(),
          destination.toWritable(),
        ], owner: authority, multiSigners: multiSigners),
        programId: programId);
  }

  /// Check to see if a token account is large enough for a list of
  /// ExtensionTypes, and if not, use reallocation to increase the data
  /// size.
  factory SPLTokenProgram.reallocate({
    required SPLTokenReallocateLayout layout,

    /// The account to reallocate.
    required SolAddress account,

    /// The payer account to fund reallocation
    required SolAddress payer,

    ///  The account's owner.
    required SolAddress owner,
    SolAddress programId = SPLTokenProgramConst.token2022ProgramId,

    /// Multisignature owner
    List<SolAddress> multiSigners = const [],
  }) {
    if (programId == SPLTokenProgramConst.tokenProgramId) {
      throw const SolanaPluginException(
          'Token program does not support extensions');
    }
    return SPLTokenProgram(
        layout: layout,
        keys: SPLTokenUtils.buildKeys(keys: [
          account.toWritable(),
          payer.toSignerAndWritable(),
          SystemProgramConst.programId.toReadOnly(),
        ], owner: owner, multiSigners: multiSigners),
        programId: programId);
  }

  /// Revokes the delegate's authority.
  factory SPLTokenProgram.revoke({
    /// The source account.
    required SolAddress account,

    /// The source account's multisignature owner.
    required SolAddress owner,
    SolAddress programId = SPLTokenProgramConst.tokenProgramId,

    /// Multisignature owner
    List<SolAddress> multiSigners = const [],
  }) {
    return SPLTokenProgram(
        layout: SPLTokenRevokeLayout(),
        keys: SPLTokenUtils.buildKeys(keys: [
          account.toWritable(),
        ], owner: owner, multiSigners: multiSigners),
        programId: programId);
  }

  /// Sets a new authority of a mint or account.
  factory SPLTokenProgram.setAuthority({
    required SPLTokenSetAuthorityLayout layout,

    /// The mint or account to change the authority of.
    required SolAddress account,

    /// The current authority of the mint or account.
    required SolAddress currentAuthority,
    SolAddress programId = SPLTokenProgramConst.tokenProgramId,

    /// Multisignature authority.
    List<SolAddress> multiSigners = const [],
  }) {
    return SPLTokenProgram(
        layout: layout,
        keys: SPLTokenUtils.buildKeys(keys: [
          account.toWritable(),
        ], owner: currentAuthority, multiSigners: multiSigners),
        programId: programId);
  }

  /// Given a wrapped / native token account (a token account containing SOL)
  /// updates its amount field based on the account's underlying `lamports`.
  factory SPLTokenProgram.syncNative(
      {
      /// The native token account to sync with its underlying
      /// lamports.
      required SolAddress account,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId}) {
    return SPLTokenProgram(
        layout: SPLTokenSyncNativeLayout(),
        keys: [account.toWritable()],
        programId: programId);
  }

  /// Thaw a Frozen account.
  factory SPLTokenProgram.thawAccount({
    /// The account to freeze.
    required SolAddress account,

    /// The token mint.
    required SolAddress mint,

    /// The mint freeze authority.
    required SolAddress authority,
    SolAddress programId = SPLTokenProgramConst.tokenProgramId,

    /// Multisignature owner
    List<SolAddress> multiSigners = const [],
  }) {
    return SPLTokenProgram(
        layout: SPLTokenThawAccountLayout(),
        keys: SPLTokenUtils.buildKeys(keys: [
          account.toWritable(),
          mint.toReadOnly(),
        ], owner: authority, multiSigners: multiSigners),
        programId: programId);
  }

  /// Transfers tokens from one account to another either directly or via a
  /// delegate.  If this account is associated with the native mint then equal
  /// amounts of SOL and Tokens will be transferred to the destination
  /// account.
  factory SPLTokenProgram.transfer({
    required SPLTokenTransferLayout layout,

    /// The source account.
    required SolAddress source,

    /// The destination account.
    required SolAddress destination,

    /// The source account's owner/delegate.
    required SolAddress owner,
    SolAddress programId = SPLTokenProgramConst.tokenProgramId,

    /// Multisignature owner/delegate
    List<SolAddress> multiSigners = const [],
  }) {
    return SPLTokenProgram(
        layout: layout,
        keys: SPLTokenUtils.buildKeys(keys: [
          source.toWritable(),
          destination.toWritable(),
        ], owner: owner, multiSigners: multiSigners),
        programId: programId);
  }

  /// Transfers tokens from one account to another either directly or via a
  /// delegate.  If this account is associated with the native mint then equal
  /// amounts of SOL and Tokens will be transferred to the destination
  /// account.
  ///
  /// This instruction differs from Transfer in that the token mint and
  /// decimals value is checked by the caller.
  factory SPLTokenProgram.transferChecked({
    required SPLTokenTransferCheckedLayout layout,

    /// The source account.
    required SolAddress source,

    /// The token mint.
    required SolAddress mint,

    /// The destination account.
    required SolAddress destination,

    /// The source account's owner/delegate.
    required SolAddress owner,
    SolAddress programId = SPLTokenProgramConst.tokenProgramId,

    /// Multisignature owner/delegate
    List<SolAddress> multiSigners = const [],
  }) {
    return SPLTokenProgram(
        layout: layout,
        keys: SPLTokenUtils.buildKeys(keys: [
          source.toWritable(),
          mint.toReadOnly(),
          destination.toWritable(),
        ], owner: owner, multiSigners: multiSigners),
        programId: programId);
  }

  /// Convert a UiAmount of tokens to a little-endian `u64` raw Amount, using
  /// the given mint. In this version of the program, the mint can only
  /// specify the number of decimals.
  factory SPLTokenProgram.uiAmountToAmount(
      {required SPLTokenUiAmountToAmountLayout layout,
      required SolAddress mint,
      SolAddress programId = SPLTokenProgramConst.tokenProgramId}) {
    return SPLTokenProgram(
        layout: layout, keys: [mint.toReadOnly()], programId: programId);
  }
}
