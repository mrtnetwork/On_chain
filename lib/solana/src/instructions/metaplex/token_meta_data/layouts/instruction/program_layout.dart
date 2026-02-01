import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/approve_collection_authority.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/approve_use_authority.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/bubblegum_set_collection_size.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/burn_edition_nft.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/burn_nft.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/burn_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/close_escrow_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/collect.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/convert_master_edition_v1_to_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/create_escrow_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/create_master_edition.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/create_master_edition_v3.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/create_meta_data_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/create_meta_data_account_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/create_metadata_account_v3.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/create_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_authority_item_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_collection_item_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_collection_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_data_item_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_data_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_locked_transfer_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_print_delegate_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_programmable_config_item_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_programmable_config_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_sale_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_staking_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_standard_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_transfer_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/delegate_utility_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/deprecated_mint_new_edition_from_master_edition_via_printing_token.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/freeze_delegated_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/lock_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/migrate.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/mint_new_edition_from_master_edition_via_token.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/mint_new_edition_from_master_edition_via_vault_proxy.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/mint_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/print_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/print_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/puff_metadata.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/remove_creator_verification.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/revoke_use_authority.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/set_and_verify_collection.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/set_and_verify_sized_collection_item.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/set_collection_size.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/set_token_standard.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/sign_metadata.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/thaw_delegated_account.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/transfer_out_of_escrow.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/transfer_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/unlock_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/unverify.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/unverify_collection.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/unverify_sized_collection_item.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/update_as_authority_item_delegate_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/update_as_collection_delegate_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/update_as_collection_item_delegate_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/update_as_data_delegate_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/update_as_data_item_delegate_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/update_as_programmable_config_delegate_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/update_as_programmable_config_item_delegate_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/update_as_update_authority_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/update_metadata_account_v2.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/update_primary_sale_happened_via_token.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/update_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/use_v1.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/utilize.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/verify.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/verify_collection.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/layouts/verify_sized_collection_item.dart';

import 'instructions.dart';

abstract class MetaplexTokenMetaDataProgramLayout extends ProgramLayout {
  const MetaplexTokenMetaDataProgramLayout();
  static StructLayout get __layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u8(property: 'discriminator'),
      ]);

  @override
  abstract final MetaplexTokenMetaDataProgramInstruction instruction;

  static ProgramLayout fromBytes(List<int> data) {
    final decode =
        ProgramLayout.decodeAndValidateStruct(layout: __layout, bytes: data);
    MetaplexTokenMetaDataProgramInstruction? instruction =
        MetaplexTokenMetaDataProgramInstruction.getInstruction(
            decode['instruction']);
    if (instruction == null) {
      return UnknownProgramLayout(data);
    }
    if (instruction.hasDiscriminator) {
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      instruction = MetaplexTokenMetaDataProgramInstruction.getInstruction(
          decode['instruction'],
          discriminator: decode['discriminator']);
    }

    switch (instruction) {
      case MetaplexTokenMetaDataProgramInstruction.approveCollectionAuthority:
        return MetaplexTokenMetaDataApproveCollectionAuthorityLayout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.approveUseAuthority:
        return MetaplexTokenMetaDataapproveUseAuthorityLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.bubblegumSetCollectionSize:
        return MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.burnEditionNft:
        return MetaplexTokenMetaDataBurnEditionNftLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.burnNft:
        return MetaplexTokenMetaDataburnNftLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.burnV1:
        return MetaplexTokenMetaDataBurnV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.closeEscrowAccount:
        return MetaplexTokenMetaDataCloseEscrowAccountLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.collect:
        return MetaplexTokenMetaDataCollectLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.convertMasterEditionV1ToV2:
        return MetaplexTokenMetaDataConvertMasterEditionV1ToV2Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.createEscrowAccount:
        return MetaplexTokenMetaDataCreateEscrowAccountLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.createMasterEdition:
        return MetaplexTokenMetaDataCreateMasterEditionLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.createMasterEditionV3:
        return MetaplexTokenMetaDataCreateMasterEditionV3Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.createMetadataAccount:
        return MetaplexTokenMetaDataCreateMetadataAccountLayout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.createMetadataAccountV2:
        return MetaplexTokenMetaDataCreateMetadataAccountV2Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.createMetadataAccountV3:
        return MetaplexTokenMetaDataCreateMetadataAccountV3Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.createV1:
        return MetaplexTokenMetaDataCreateV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.delegateAuthorityItemV1:
        return MetaplexTokenMetaDataDelegateAuthorityItemV1Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.delegateCollectionItemV1:
        return MetaplexTokenMetaDataDelegateCollectionItemV1Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.delegateCollectionV1:
        return MetaplexTokenMetaDataDelegateCollectionV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.delegateDataItemV1:
        return MetaplexTokenMetaDataDelegateDataItemV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.delegateDataV1:
        return MetaplexTokenMetaDataDelegateDataV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.delegateLockedTransferV1:
        return MetaplexTokenMetaDataDelegateLockedTransferV1Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.delegatePrintDelegateV1:
        return MetaplexTokenMetaDataDelegatePrintDelegateV1Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction
            .delegateProgrammableConfigItemV1:
        return MetaplexTokenMetaDataDelegateProgrammableConfigItemV1Layout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.delegateProgrammableConfigV1:
        return MetaplexTokenMetaDataDelegateProgrammableConfigV1Layout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.delegateSaleV1:
        return MetaplexTokenMetaDataDelegateSaleV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.delegateStakingV1:
        return MetaplexTokenMetaDataDelegateStakingV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.delegateStandardV1:
        return MetaplexTokenMetaDataDelegateStandardV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.delegateTransferV1:
        return MetaplexTokenMetaDataDelegateTransferV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.delegateUtilityV1:
        return MetaplexTokenMetaDataDelegateUtilityV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction
            .deprecatedMintNewEditionFromMasterEditionViaPrintingToken:
        return MetaplexTokenMetaDataDeprecatedMintNewEditionFromMasterEditionViaPrintingTokenLayout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.freezeDelegatedAccount:
        return MetaplexTokenMetaDataFreezeDelegatedAccountLayout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.lockV1:
        return MetaplexTokenMetaDataLockV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.migrate:
        return MetaplexTokenMetaDataMigrateLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction
            .mintNewEditionFromMasterEditionViaToken:
        return MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaTokenLayout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction
            .mintNewEditionFromMasterEditionViaVaultProxy:
        return MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaVaultProxyLayout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.mintV1:
        return MetaplexTokenMetaDataMintV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.printV1:
        return MetaplexTokenMetaDataPrintV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.printV2:
        return MetaplexTokenMetaDataPrintV2Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.puffMetadata:
        return MetaplexTokenMetaDataPuffMetadataLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.removeCreatorVerification:
        return MetaplexTokenMetaDataRemoveCreatorVerificationLayout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.revokeUseAuthority:
        return MetaplexTokenMetaDataRevokeUseAuthorityLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.setAndVerifyCollection:
        return MetaplexTokenMetaDataSetAndVerifyCollectionLayout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction
            .setAndVerifySizedCollectionItem:
        return MetaplexTokenMetaDataSetAndVerifySizedCollectionItemLayout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.setCollectionSize:
        return MetaplexTokenMetaDataSetCollectionSizeLayout.fromBuffer(data);

      case MetaplexTokenMetaDataProgramInstruction.setTokenStandard:
        return MetaplexTokenMetaDataSetTokenStandardLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.signMetadata:
        return MetaplexTokenMetaDataSignMetadataLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.thawDelegatedAccount:
        return MetaplexTokenMetaDataThawDelegatedAccountLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.transferOutOfEscrow:
        return MetaplexTokenMetaDataTransferOutOfEscrowLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.transferV1:
        return MetaplexTokenMetaDataTransferV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.unlockV1:
        return MetaplexTokenMetaDataUnlockV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.unverifyCollection:
        return MetaplexTokenMetaDataUnverifyCollectionLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.unverifyCollectionV1:
        return MetaplexTokenMetaDataUnverifyLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.unverifySizedCollectionItem:
        return MetaplexTokenMetaDataUnverifySizedCollectionItemLayout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction
            .updateAsAuthorityItemDelegateV2:
        return MetaplexTokenMetaDataUpdateAsAuthorityItemDelegateV2Layout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.updateAsCollectionDelegateV2:
        return MetaplexTokenMetaDataUpdateAsCollectionDelegateV2Layout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction
            .updateAsCollectionItemDelegateV2:
        return MetaplexTokenMetaDataUpdateAsCollectionItemDelegateV2Layout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.updateAsDataDelegateV2:
        return MetaplexTokenMetaDataUpdateAsDataDelegateV2Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.updateAsDataItemDelegateV2:
        return MetaplexTokenMetaDataUpdateAsDataItemDelegateV2Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction
            .updateAsProgrammableConfigDelegateV2:
        return MetaplexTokenMetaDataUpdateAsProgrammableConfigDelegateV2Layout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction
            .updateAsProgrammableConfigItemDelegateV2:
        return MetaplexTokenMetaDataUpdateAsProgrammableConfigItemDelegateV2Layout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.updateAsUpdateAuthorityV2:
        return MetaplexTokenMetaDataUpdateAsUpdateAuthorityV2Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction.updateMetadataAccountV2:
        return MetaplexTokenMetaDataUpdateMetadataAccountV2Layout.fromBuffer(
            data);
      case MetaplexTokenMetaDataProgramInstruction
            .updatePrimarySaleHappenedViaToken:
        return MetaplexTokenMetaDataUpdatePrimarySaleHappenedViaTokenLayout
            .fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.updateV1:
        return MetaplexTokenMetaDataUpdateV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.useV1:
        return MetaplexTokenMetaDataUseV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.utilize:
        return MetaplexTokenMetaDataUtilizeLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.verifyCollection:
        return MetaplexTokenMetaDataVerifyCollectionLayout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.verifyCollectionV1:
        return MetaplexTokenMetaDataVerifyCollectionV1Layout.fromBuffer(data);
      case MetaplexTokenMetaDataProgramInstruction.verifySizedCollectionItem:
        return MetaplexTokenMetaDataVerifySizedCollectionItemLayout.fromBuffer(
            data);
      default:
        return UnknownProgramLayout(data);
    }
  }
}
