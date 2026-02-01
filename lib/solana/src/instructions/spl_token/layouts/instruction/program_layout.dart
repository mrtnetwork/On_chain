import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/group_member_pointer.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/group_pointer.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/instructions.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/interest_bearing_mint.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/meta_data_pointer.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/transfer_fee_instruction.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/instruction/transfer_hook.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/amout_to_ui_amount.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/approve.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/approve_checked.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/burn.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/burn_checked.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/close_account.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/create_native_mint.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/freeze_account.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/initialize_account.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/initialize_account2.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/initialize_account3.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/initialize_immutable_owner.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/initialize_mint.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/initialize_mint2.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/initialize_mint_close_authority.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/initialize_multisig.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/initialize_non_transferable_mint.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/initialize_permanent_delegate.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/mint_to.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/mint_to_checked.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/reallocate.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/revoke.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/set_authority.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/sync_native.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/thaw_account.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/transfer.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/transfer_checked.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/layouts/ui_amount_to_amout.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/execute.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/harvest_with_held_tokens_to_mint.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/initialize_group_member_pointer.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/initialize_group_pointer.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/initialize_interest_bearing_mint.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/initialize_meta_pointer.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/initialize_transfer_fee_config.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/initialize_transfer_hook.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/toggle_cpi_guard.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/transfer_checked_with_fee.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/update_group_member_pointer.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/update_group_pointer.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/update_meta_data_pointer.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/update_rate_interest_bearing_mint.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/update_transfer_hook.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/withdraw_with_held_tokens_from_accounts.dart';
import 'package:on_chain/solana/src/instructions/spl_token/layouts/spl_token_2022_extensions_layouts/withdraw_with_held_tokens_from_mint.dart';

abstract class SPLTokenProgramLayout extends ProgramLayout {
  const SPLTokenProgramLayout();
  @override
  SPLTokenProgramInstruction get instruction;
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);
  static ProgramLayout fromBytes(List<int> data) {
    try {
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      final instruction =
          SPLTokenProgramInstruction.getInstruction(decode['instruction']);
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
        case SPLTokenProgramInstruction.execute:
          return SPLToken2022ExecuteLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.groupMemberPointerExtension:
          final StructLayout layout = LayoutConst.struct([
            LayoutConst.u8(property: 'instruction'),
            LayoutConst.wrap(GroupMemberPointerInstruction.staticLayout,
                property: 'groupMemberPointer')
          ]);
          final decode = ProgramLayout.decodeAndValidateStruct(
              layout: layout, bytes: data);
          final type = GroupMemberPointerInstruction.fromJson(
              decode['groupMemberPointer']);
          switch (type) {
            case GroupMemberPointerInstruction.initialize:
              return SPLToken2022InitializeGroupMemberPointerLayout.fromBuffer(
                  data);
            default:
              return SPLToken2022UpdateGroupMemberPointerLayout.fromBuffer(
                  data);
          }
        case SPLTokenProgramInstruction.groupPointerExtension:
          final StructLayout layout = LayoutConst.struct([
            LayoutConst.u8(property: 'instruction'),
            LayoutConst.wrap(GroupPointerInstruction.staticLayout,
                property: 'groupPointer')
          ]);
          final decode = ProgramLayout.decodeAndValidateStruct(
              layout: layout, bytes: data);
          final type = GroupPointerInstruction.fromJson(decode['groupPointer']);
          switch (type) {
            case GroupPointerInstruction.initialize:
              return SPLToken2022InitializeGroupPointerLayout.fromBuffer(data);
            default:
              return SPLToken2022UpdateGroupPointerLayout.fromBuffer(data);
          }
        case SPLTokenProgramInstruction.metadataPointerExtension:
          final StructLayout layout = LayoutConst.struct([
            LayoutConst.u8(property: 'instruction'),
            LayoutConst.wrap(MetadataPointerInstruction.staticLayout,
                property: 'metadataPointer'),
          ]);
          final decode = ProgramLayout.decodeAndValidateStruct(
              layout: layout, bytes: data);
          final type =
              MetadataPointerInstruction.fromJson(decode['metadataPointer']);
          switch (type) {
            case MetadataPointerInstruction.initialize:
              return SPLToken2022InitializeMetadataPointerLayout.fromBuffer(
                  data);
            default:
              return SPLToken2022UpdateMetadataPointerLayout.fromBuffer(data);
          }
        case SPLTokenProgramInstruction.transferHookExtension:
          final StructLayout layout = LayoutConst.struct([
            LayoutConst.u8(property: 'instruction'),
            LayoutConst.wrap(TransferHookInstruction.staticLayout,
                property: 'transferHook'),
          ]);
          final decode = ProgramLayout.decodeAndValidateStruct(
              layout: layout, bytes: data);
          final type = TransferHookInstruction.fromJson(decode['transferHook']);
          switch (type) {
            case TransferHookInstruction.initialize:
              return SPLToken2022InitializeTransferHookLayout.fromBuffer(data);
            default:
              return SPLToken2022UpdateTransferHookLayout.fromBuffer(data);
          }
        case SPLTokenProgramInstruction.cpiGuardExtension:
          return SPLToken2022ToggleCpiGuardLayout.fromBuffer(data);
        case SPLTokenProgramInstruction.interestBearingMintExtension:
          final StructLayout layout = LayoutConst.struct([
            LayoutConst.u8(property: 'instruction'),
            LayoutConst.wrap(InterestBearingMintInstruction.staticLayout,
                property: 'interestBearingMint'),
          ]);
          final decode = ProgramLayout.decodeAndValidateStruct(
              layout: layout, bytes: data);
          final type = InterestBearingMintInstruction.fromJson(
              decode['interestBearingMint']);
          switch (type) {
            case InterestBearingMintInstruction.initialize:
              return SPLToken2022InterestBearingMintInitializeLayout.fromBuffer(
                  data);
            default:
              return SPLToken2022InterestBearingMintUpdateRateLayout.fromBuffer(
                  data);
          }
        case SPLTokenProgramInstruction.transferFeeExtension:
          final StructLayout layout = LayoutConst.struct([
            LayoutConst.u8(property: 'instruction'),
            LayoutConst.u8(property: 'transferFee'),
          ]);
          final decode = ProgramLayout.decodeAndValidateStruct(
              layout: layout, bytes: data);
          final type = TransferFeeInstructionInstruction.fromValue(
              decode['transferFee']);
          switch (type) {
            case TransferFeeInstructionInstruction.harvestWithheldTokensToMint:
              return SPLToken2022HarvestWithheldTokensToMintLayout.fromBuffer(
                  data);
            case TransferFeeInstructionInstruction.initializeTransferFeeConfig:
              return SPLToken2022InitializeTransferFeeConfigLayout.fromBuffer(
                  data);
            case TransferFeeInstructionInstruction.transferCheckedWithFee:
              return SPLToken2022TransferCheckedWithFeeLayout.fromBuffer(data);
            case TransferFeeInstructionInstruction
                  .withdrawWithheldTokensFromAccounts:
              return SPLToken2022WithdrawWithheldTokensFromAccountsLayout
                  .fromBuffer(data);
            case TransferFeeInstructionInstruction
                  .withdrawWithheldTokensFromMint:
              return SPLToken2022WithdrawWithheldTokensFromMintLayout
                  .fromBuffer(data);
            default:
              return UnknownProgramLayout(data);
          }
        default:
          throw UnimplementedError();
      }
    } on UnimplementedError {
      rethrow;
    } catch (_) {
      return UnknownProgramLayout(data);
    }
  }
}
