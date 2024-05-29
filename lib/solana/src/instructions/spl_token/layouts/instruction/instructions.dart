import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class SPLTokenProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const SPLTokenProgramInstruction(this.insturction, this.name);
  static const SPLTokenProgramInstruction initializeMint =
      SPLTokenProgramInstruction(0, "InitializeMint");
  static const SPLTokenProgramInstruction initializeAccount =
      SPLTokenProgramInstruction(1, "InitializeAccount");
  static const SPLTokenProgramInstruction initializeMultisig =
      SPLTokenProgramInstruction(2, "InitializeMultisig");
  static const SPLTokenProgramInstruction transfer =
      SPLTokenProgramInstruction(3, "Transfer");
  static const SPLTokenProgramInstruction approve =
      SPLTokenProgramInstruction(4, "Approve");
  static const SPLTokenProgramInstruction revoke =
      SPLTokenProgramInstruction(5, "Revoke");
  static const SPLTokenProgramInstruction setAuthority =
      SPLTokenProgramInstruction(6, "SetAuthority");
  static const SPLTokenProgramInstruction mintTo =
      SPLTokenProgramInstruction(7, "MintTo");
  static const SPLTokenProgramInstruction burn =
      SPLTokenProgramInstruction(8, "Burn");
  static const SPLTokenProgramInstruction closeAccount =
      SPLTokenProgramInstruction(9, "CloseAccount");
  static const SPLTokenProgramInstruction freezeAccount =
      SPLTokenProgramInstruction(10, "FreezeAccount");
  static const SPLTokenProgramInstruction thawAccount =
      SPLTokenProgramInstruction(11, "ThawAccount");
  static const SPLTokenProgramInstruction transferChecked =
      SPLTokenProgramInstruction(12, "TransferChecked");
  static const SPLTokenProgramInstruction approveChecked =
      SPLTokenProgramInstruction(13, "ApproveChecked");
  static const SPLTokenProgramInstruction mintToChecked =
      SPLTokenProgramInstruction(14, "MintToChecked");
  static const SPLTokenProgramInstruction burnChecked =
      SPLTokenProgramInstruction(15, "BurnChecked");
  static const SPLTokenProgramInstruction initializeAccount2 =
      SPLTokenProgramInstruction(16, "InitializeAccount2");
  static const SPLTokenProgramInstruction syncNative =
      SPLTokenProgramInstruction(17, "SyncNative");
  static const SPLTokenProgramInstruction initializeAccount3 =
      SPLTokenProgramInstruction(18, "InitializeAccount3");
  static const SPLTokenProgramInstruction initializeMultisig2 =
      SPLTokenProgramInstruction(19, "InitializeMultisig2");
  static const SPLTokenProgramInstruction initializeMint2 =
      SPLTokenProgramInstruction(20, "InitializeMint2");
  static const SPLTokenProgramInstruction getAccountDataSize =
      SPLTokenProgramInstruction(21, "GetAccountDataSize");
  static const SPLTokenProgramInstruction initializeImmutableOwner =
      SPLTokenProgramInstruction(22, "InitializeImmutableOwner");
  static const SPLTokenProgramInstruction amountToUiAmount =
      SPLTokenProgramInstruction(23, "AmountToUiAmount");
  static const SPLTokenProgramInstruction uiAmountToAmount =
      SPLTokenProgramInstruction(24, "UiAmountToAmount");
  static const SPLTokenProgramInstruction initializeMintCloseAuthority =
      SPLTokenProgramInstruction(25, "InitializeMintCloseAuthority");
  static const SPLTokenProgramInstruction transferFeeExtension =
      SPLTokenProgramInstruction(26, "TransferFeeExtension");
  static const SPLTokenProgramInstruction confidentialTransferExtension =
      SPLTokenProgramInstruction(27, "ConfidentialTransferExtension");
  static const SPLTokenProgramInstruction defaultAccountStateExtension =
      SPLTokenProgramInstruction(28, "DefaultAccountStateExtension");
  static const SPLTokenProgramInstruction reallocate =
      SPLTokenProgramInstruction(29, "Reallocate");
  static const SPLTokenProgramInstruction memoTransferExtension =
      SPLTokenProgramInstruction(30, "MemoTransferExtension");
  static const SPLTokenProgramInstruction createNativeMint =
      SPLTokenProgramInstruction(31, "CreateNativeMint");
  static const SPLTokenProgramInstruction initializeNonTransferableMint =
      SPLTokenProgramInstruction(32, "InitializeNonTransferableMint");
  static const SPLTokenProgramInstruction interestBearingMintExtension =
      SPLTokenProgramInstruction(33, "InterestBearingMintExtension");
  static const SPLTokenProgramInstruction cpiGuardExtension =
      SPLTokenProgramInstruction(34, "CpiGuardExtension");
  static const SPLTokenProgramInstruction initializePermanentDelegate =
      SPLTokenProgramInstruction(35, "InitializePermanentDelegate");
  static const SPLTokenProgramInstruction transferHookExtension =
      SPLTokenProgramInstruction(36, "TransferHookExtension");

  static const SPLTokenProgramInstruction metadataPointerExtension =
      SPLTokenProgramInstruction(39, "MetadataPointerExtension");

  static const SPLTokenProgramInstruction groupPointerExtension =
      SPLTokenProgramInstruction(40, "GroupPointerExtension");

  static const SPLTokenProgramInstruction groupMemberPointerExtension =
      SPLTokenProgramInstruction(41, "GroupMemberPointerExtension");

  static const List<SPLTokenProgramInstruction> values = [
    initializeMint,
    initializeAccount,
    initializeMultisig,
    transfer,
    approve,
    revoke,
    setAuthority,
    mintTo,
    burn,
    closeAccount,
    freezeAccount,
    thawAccount,
    transferChecked,
    approveChecked,
    mintToChecked,
    burnChecked,
    initializeAccount2,
    syncNative,
    initializeAccount3,
    initializeMultisig2,
    initializeMint2,
    getAccountDataSize,
    initializeImmutableOwner,
    amountToUiAmount,
    uiAmountToAmount,
    initializeMintCloseAuthority,
    transferFeeExtension,
    confidentialTransferExtension,
    defaultAccountStateExtension,
    reallocate,
    memoTransferExtension,
    createNativeMint,
    initializeNonTransferableMint,
    interestBearingMintExtension,
    cpiGuardExtension,
    initializePermanentDelegate,
    transferHookExtension,
    metadataPointerExtension,
  ];
  static SPLTokenProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } on StateError {
      return null;
    }
  }
}
