import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataProgramInstruction
    implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const MetaplexTokenMetaDataProgramInstruction._(this.insturction, this.name);
  static const MetaplexTokenMetaDataProgramInstruction
      approveCollectionAuthority = MetaplexTokenMetaDataProgramInstruction._(
          23, "ApproveCollectionAuthority");
  static const MetaplexTokenMetaDataProgramInstruction approveUseAuthority =
      MetaplexTokenMetaDataProgramInstruction._(20, "ApproveUseAuthority");
  static const MetaplexTokenMetaDataProgramInstruction
      bubblegumSetCollectionSize = MetaplexTokenMetaDataProgramInstruction._(
          36, "BubblegumSetCollectionSize");
  static const MetaplexTokenMetaDataProgramInstruction burnEditionNft =
      MetaplexTokenMetaDataProgramInstruction._(37, "BurnEditionNft");
  static const MetaplexTokenMetaDataProgramInstruction burnNft =
      MetaplexTokenMetaDataProgramInstruction._(29, "BurnNft");
  static const MetaplexTokenMetaDataProgramInstruction burnV1 =
      MetaplexTokenMetaDataProgramInstruction._(41, "BurnV1");
  static const MetaplexTokenMetaDataProgramInstruction closeEscrowAccount =
      MetaplexTokenMetaDataProgramInstruction._(39, "CloseEscrowAccount");
  static const MetaplexTokenMetaDataProgramInstruction collect =
      MetaplexTokenMetaDataProgramInstruction._(54, "Collect");
  static const MetaplexTokenMetaDataProgramInstruction
      convertMasterEditionV1ToV2 = MetaplexTokenMetaDataProgramInstruction._(
          12, "ConvertMasterEditionV1ToV2");
  static const MetaplexTokenMetaDataProgramInstruction createEscrowAccount =
      MetaplexTokenMetaDataProgramInstruction._(38, "CreateEscrowAccount");
  static const MetaplexTokenMetaDataProgramInstruction createMasterEdition =
      MetaplexTokenMetaDataProgramInstruction._(10, "CreateMasterEdition");
  static const MetaplexTokenMetaDataProgramInstruction createMasterEditionV3 =
      MetaplexTokenMetaDataProgramInstruction._(17, "CreateMasterEditionV3");
  static const MetaplexTokenMetaDataProgramInstruction createMetadataAccount =
      MetaplexTokenMetaDataProgramInstruction._(0, "CreateMetadataAccount");
  static const MetaplexTokenMetaDataProgramInstruction createMetadataAccountV2 =
      MetaplexTokenMetaDataProgramInstruction._(16, "CreateMetadataAccountV2");
  static const MetaplexTokenMetaDataProgramInstruction createMetadataAccountV3 =
      MetaplexTokenMetaDataProgramInstruction._(33, "CreateMetadataAccountV3");
  static const MetaplexTokenMetaDataProgramInstruction createV1 =
      MetaplexTokenMetaDataProgramInstruction._(42, "CreateV1");
  static const MetaplexTokenMetaDataProgramInstruction delegateAuthorityItemV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegateAuthorityItemV1");
  static const MetaplexTokenMetaDataProgramInstruction
      delegateCollectionItemV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegateCollectionItemV1");
  static const MetaplexTokenMetaDataProgramInstruction delegateCollectionV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegateCollectionV1");
  static const MetaplexTokenMetaDataProgramInstruction delegateDataItemV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegateDataItemV1");
  static const MetaplexTokenMetaDataProgramInstruction delegateDataV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegateDataV1");
  static const MetaplexTokenMetaDataProgramInstruction
      delegateLockedTransferV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegateLockedTransferV1");
  static const MetaplexTokenMetaDataProgramInstruction delegatePrintDelegateV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegatePrintDelegateV1");
  static const MetaplexTokenMetaDataProgramInstruction
      delegateProgrammableConfigItemV1 =
      MetaplexTokenMetaDataProgramInstruction._(
          44, "DelegateProgrammableConfigItemV1");
  static const MetaplexTokenMetaDataProgramInstruction
      delegateProgrammableConfigV1 = MetaplexTokenMetaDataProgramInstruction._(
          44, "DelegateProgrammableConfigV1");
  static const MetaplexTokenMetaDataProgramInstruction delegateSaleV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegateSaleV1");
  static const MetaplexTokenMetaDataProgramInstruction delegateStakingV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegateStakingV1");
  static const MetaplexTokenMetaDataProgramInstruction delegateStandardV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegateStandardV1");
  static const MetaplexTokenMetaDataProgramInstruction delegateTransferV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegateTransferV1");
  static const MetaplexTokenMetaDataProgramInstruction delegateUtilityV1 =
      MetaplexTokenMetaDataProgramInstruction._(44, "DelegateUtilityV1");
  static const MetaplexTokenMetaDataProgramInstruction
      deprecatedMintNewEditionFromMasterEditionViaPrintingToken =
      MetaplexTokenMetaDataProgramInstruction._(
          3, "DeprecatedMintNewEditionFromMasterEditionViaPrintingToken");
  static const MetaplexTokenMetaDataProgramInstruction freezeDelegatedAccount =
      MetaplexTokenMetaDataProgramInstruction._(26, "FreezeDelegatedAccount");
  static const MetaplexTokenMetaDataProgramInstruction lockV1 =
      MetaplexTokenMetaDataProgramInstruction._(46, "LockV1");
  static const MetaplexTokenMetaDataProgramInstruction migrate =
      MetaplexTokenMetaDataProgramInstruction._(48, "Migrate");
  static const MetaplexTokenMetaDataProgramInstruction
      mintNewEditionFromMasterEditionViaToken =
      MetaplexTokenMetaDataProgramInstruction._(
          11, "MintNewEditionFromMasterEditionViaToken");
  static const MetaplexTokenMetaDataProgramInstruction
      mintNewEditionFromMasterEditionViaVaultProxy =
      MetaplexTokenMetaDataProgramInstruction._(
          13, "MintNewEditionFromMasterEditionViaVaultProxy");
  static const MetaplexTokenMetaDataProgramInstruction mintV1 =
      MetaplexTokenMetaDataProgramInstruction._(43, "MintV1");
  static const MetaplexTokenMetaDataProgramInstruction printV1 =
      MetaplexTokenMetaDataProgramInstruction._(55, "PrintV1");
  static const MetaplexTokenMetaDataProgramInstruction printV2 =
      MetaplexTokenMetaDataProgramInstruction._(55, "PrintV2");
  static const MetaplexTokenMetaDataProgramInstruction puffMetadata =
      MetaplexTokenMetaDataProgramInstruction._(14, "PuffMetadata");
  static const MetaplexTokenMetaDataProgramInstruction
      removeCreatorVerification = MetaplexTokenMetaDataProgramInstruction._(
          28, "RemoveCreatorVerification");
  static const MetaplexTokenMetaDataProgramInstruction
      revokeCollectionAuthority = MetaplexTokenMetaDataProgramInstruction._(
          24, "RevokeCollectionAuthority");
  static const MetaplexTokenMetaDataProgramInstruction revokeUseAuthority =
      MetaplexTokenMetaDataProgramInstruction._(21, "RevokeUseAuthority");
  static const MetaplexTokenMetaDataProgramInstruction revoke =
      MetaplexTokenMetaDataProgramInstruction._(45, "Revoke");
  static const MetaplexTokenMetaDataProgramInstruction setAndVerifyCollection =
      MetaplexTokenMetaDataProgramInstruction._(25, "SetAndVerifyCollection");
  static const MetaplexTokenMetaDataProgramInstruction
      setAndVerifySizedCollectionItem =
      MetaplexTokenMetaDataProgramInstruction._(
          32, "SetAndVerifySizedCollectionItem");
  static const MetaplexTokenMetaDataProgramInstruction setCollectionSize =
      MetaplexTokenMetaDataProgramInstruction._(34, "SetCollectionSize");
  static const MetaplexTokenMetaDataProgramInstruction setTokenStandard =
      MetaplexTokenMetaDataProgramInstruction._(35, "SetTokenStandard");
  static const MetaplexTokenMetaDataProgramInstruction signMetadata =
      MetaplexTokenMetaDataProgramInstruction._(7, "SignMetadata");
  static const MetaplexTokenMetaDataProgramInstruction thawDelegatedAccount =
      MetaplexTokenMetaDataProgramInstruction._(27, "ThawDelegatedAccount");
  static const MetaplexTokenMetaDataProgramInstruction transferOutOfEscrow =
      MetaplexTokenMetaDataProgramInstruction._(40, "TransferOutOfEscrow");
  static const MetaplexTokenMetaDataProgramInstruction transferV1 =
      MetaplexTokenMetaDataProgramInstruction._(49, "TransferV1");
  static const MetaplexTokenMetaDataProgramInstruction unlockV1 =
      MetaplexTokenMetaDataProgramInstruction._(47, "UnlockV1");
  static const MetaplexTokenMetaDataProgramInstruction unverifyCollection =
      MetaplexTokenMetaDataProgramInstruction._(22, "UnverifyCollection");
  static const MetaplexTokenMetaDataProgramInstruction unverifyCollectionV1 =
      MetaplexTokenMetaDataProgramInstruction._(53, "UnverifyCollectionV1");
  static const MetaplexTokenMetaDataProgramInstruction unverifyCreatorV1 =
      MetaplexTokenMetaDataProgramInstruction._(53, "UnverifyCreatorV1");
  static const MetaplexTokenMetaDataProgramInstruction
      unverifySizedCollectionItem = MetaplexTokenMetaDataProgramInstruction._(
          31, "UnverifySizedCollectionItem");
  static const MetaplexTokenMetaDataProgramInstruction
      updateAsAuthorityItemDelegateV2 =
      MetaplexTokenMetaDataProgramInstruction._(
          50, "UpdateAsAuthorityItemDelegateV2");
  static const MetaplexTokenMetaDataProgramInstruction
      updateAsCollectionDelegateV2 = MetaplexTokenMetaDataProgramInstruction._(
          50, "UpdateAsCollectionDelegateV2");
  static const MetaplexTokenMetaDataProgramInstruction
      updateAsCollectionItemDelegateV2 =
      MetaplexTokenMetaDataProgramInstruction._(
          50, "UpdateAsCollectionItemDelegateV2");
  static const MetaplexTokenMetaDataProgramInstruction updateAsDataDelegateV2 =
      MetaplexTokenMetaDataProgramInstruction._(50, "UpdateAsDataDelegateV2");
  static const MetaplexTokenMetaDataProgramInstruction
      updateAsDataItemDelegateV2 = MetaplexTokenMetaDataProgramInstruction._(
          50, "UpdateAsDataItemDelegateV2");
  static const MetaplexTokenMetaDataProgramInstruction
      updateAsProgrammableConfigDelegateV2 =
      MetaplexTokenMetaDataProgramInstruction._(
          50, "UpdateAsProgrammableConfigDelegateV2");
  static const MetaplexTokenMetaDataProgramInstruction
      updateAsProgrammableConfigItemDelegateV2 =
      MetaplexTokenMetaDataProgramInstruction._(
          50, "UpdateAsProgrammableConfigItemDelegateV2");
  static const MetaplexTokenMetaDataProgramInstruction
      updateAsUpdateAuthorityV2 = MetaplexTokenMetaDataProgramInstruction._(
          50, "UpdateAsUpdateAuthorityV2");
  static const MetaplexTokenMetaDataProgramInstruction updateMetadataAccountV2 =
      MetaplexTokenMetaDataProgramInstruction._(15, "UpdateMetadataAccountV2");
  static const MetaplexTokenMetaDataProgramInstruction
      updatePrimarySaleHappenedViaToken =
      MetaplexTokenMetaDataProgramInstruction._(
          4, "UpdatePrimarySaleHappenedViaToken");
  static const MetaplexTokenMetaDataProgramInstruction updateV1 =
      MetaplexTokenMetaDataProgramInstruction._(50, "UpdateV1");
  static const MetaplexTokenMetaDataProgramInstruction useV1 =
      MetaplexTokenMetaDataProgramInstruction._(51, "UseV1");
  static const MetaplexTokenMetaDataProgramInstruction utilize =
      MetaplexTokenMetaDataProgramInstruction._(19, "Utilize");
  static const MetaplexTokenMetaDataProgramInstruction verifyCollection =
      MetaplexTokenMetaDataProgramInstruction._(18, "VerifyCollection");
  static const MetaplexTokenMetaDataProgramInstruction verifyCollectionV1 =
      MetaplexTokenMetaDataProgramInstruction._(52, "VerifyCollectionV1");
  static const MetaplexTokenMetaDataProgramInstruction verifyCreatorV1 =
      MetaplexTokenMetaDataProgramInstruction._(52, "VerifyCreatorV1");
  static const MetaplexTokenMetaDataProgramInstruction
      verifySizedCollectionItem = MetaplexTokenMetaDataProgramInstruction._(
          30, "VerifySizedCollectionItem");

  static const List<MetaplexTokenMetaDataProgramInstruction> values = [
    approveCollectionAuthority,
    approveUseAuthority,
    bubblegumSetCollectionSize,
    burnEditionNft,
    burnNft,
    burnV1,
    closeEscrowAccount,
    collect,
    convertMasterEditionV1ToV2,
    createEscrowAccount,
    createMasterEditionV3,
    createMetadataAccountV3,
    createV1,
    delegateAuthorityItemV1,
    delegateCollectionItemV1,
    delegateCollectionV1,
    delegateDataItemV1,
    delegateDataV1,
    delegateLockedTransferV1,
    delegatePrintDelegateV1,
    delegateProgrammableConfigItemV1,
    delegateProgrammableConfigV1,
    delegateSaleV1,
    delegateStakingV1,
    delegateStandardV1,
    delegateTransferV1,
    delegateUtilityV1,
    deprecatedMintNewEditionFromMasterEditionViaPrintingToken,
    freezeDelegatedAccount,
    lockV1,
    migrate,
    mintNewEditionFromMasterEditionViaToken,
    mintNewEditionFromMasterEditionViaVaultProxy,
    mintV1,
    printV1,
    printV2,
    puffMetadata,
    removeCreatorVerification,
    revokeUseAuthority,
    setAndVerifyCollection,
    setAndVerifySizedCollectionItem,
    setCollectionSize,
    setTokenStandard,
    signMetadata,
    thawDelegatedAccount,
    transferOutOfEscrow,
    transferV1,
    unlockV1,
    unverifyCollection,
    unverifyCollectionV1,
    unverifyCreatorV1,
    unverifySizedCollectionItem,
    updateAsAuthorityItemDelegateV2,
    updateAsCollectionDelegateV2,
    updateAsCollectionItemDelegateV2,
    updateAsDataDelegateV2,
    updateAsDataItemDelegateV2,
    updateAsProgrammableConfigDelegateV2,
    updateAsProgrammableConfigItemDelegateV2,
    updateAsUpdateAuthorityV2,
    updateMetadataAccountV2,
    updatePrimarySaleHappenedViaToken,
    updateV1,
    useV1,
    utilize,
    verifyCollection,
    verifyCollectionV1,
    verifyCreatorV1,
    verifySizedCollectionItem,
  ];

  static MetaplexTokenMetaDataProgramInstruction? getInstruction(
      dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } on StateError {
      return null;
    }
  }
}
