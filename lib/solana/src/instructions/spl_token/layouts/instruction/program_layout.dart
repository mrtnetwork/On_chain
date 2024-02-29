import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

abstract class SPLTokenProgramLayout extends ProgramLayout {
  const SPLTokenProgramLayout();
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    try {
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      final instruction =
          SPLTokenProgramInstruction.getInstruction(decode["instruction"]);
      switch (instruction) {
        case SPLTokenProgramInstruction.amountToUiAmount:
          return SPLTokenAmountToUiAmountLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.approveChecked:
          return SPLTokenApproveCheckedLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.approve:
          return SPLTokenApproveLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.burnChecked:
          return SPLTokenBurnCheckedLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.burn:
          return SPLTokenBurnLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.closeAccount:
          return SPLTokenCloseAccountLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.createNativeMint:
          return SPLTokenCreateNativeMintLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.freezeAccount:
          return SPLTokenFreezAccountLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.initializeAccount:
          return SPLTokenInitializeAccountLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.initializeAccount2:
          return SPLTokenInitializeAccount2Layout.fromBuffer(data);
        case SPLTokenProgramInstruction.initializeAccount3:
          return SPLTokenInitializeAccount3Layout.fromBuffer(data);
        case SPLTokenProgramInstruction.initializeImmutableOwner:
          return SPLTokenInitializeImmutableOwnerLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.initializeMintCloseAuthority:
          return SPLTokenInitializeMintCloseAuthorityLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.initializeMint:
          return SPLTokenInitializeMintLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.initializeMint2:
          return SPLTokenInitializeMint2Layout.fromBuffer(data);
        case SPLTokenProgramInstruction.initializeMultisig:
          return SPLTokenInitializeMultisigLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.initializeNonTransferableMint:
          return SPLTokenInitializeNonTransferableMintLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.initializePermanentDelegate:
          return SPLTokenInitializePermanentDelegateLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.mintToChecked:
          return SPLTokenMintToCheckedLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.mintTo:
          return SPLTokenMintToLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.reallocate:
          return SPLTokenReallocateLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.revoke:
          return SPLTokenRevokeLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.setAuthority:
          return SPLTokenSetAuthorityLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.syncNative:
          return SPLTokenSyncNativeLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.thawAccount:
          return SPLTokenThawAccountLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.transferChecked:
          return SPLTokenTransferCheckedLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.transfer:
          return SPLTokenTransferLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.uiAmountToAmount:
          return SPLTokenUiAmountToAmountLayout.fromBuffer(data);
        default:
          return UnknownProgramLayout(data);
      }
    } catch (e) {
      return UnknownProgramLayout(data);
    }
  }
}
