import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/models.dart';

class MetaplexNFTPacksProgram extends TransactionInstruction {
  MetaplexNFTPacksProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, data: layout.toBytes(), programId: programId);
  factory MetaplexNFTPacksProgram.activate({
    required SolAddress packSet,
    required SolAddress authority,
  }) {
    return MetaplexNFTPacksProgram(
        keys: [packSet.toWritable(), authority.toSigner()],
        programId: MetaplexNFTPacksProgramConst.programId,
        layout: const MetaplexNFTPacksActivateLayout());
  }
  factory MetaplexNFTPacksProgram.addCardToPack(
      {required SolAddress packSet,
      required SolAddress packConfig,
      required SolAddress packCard,
      required SolAddress authority,
      required SolAddress masterEdition,
      required SolAddress masterMetadata,
      required SolAddress mint,
      required SolAddress source,
      required SolAddress tokenAccount,
      required SolAddress programAuthority,
      required SolAddress store,
      required MetaplexNFTPacksAddCardToPackLayout layout,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexNFTPacksProgram(keys: [
      packSet.toWritable(),
      packConfig.toWritable(),
      packCard.toWritable(),
      authority.toSigner(),
      masterEdition.toReadOnly(),
      masterMetadata.toReadOnly(),
      mint.toReadOnly(),
      source.toWritable(),
      tokenAccount.toWritable(),
      programAuthority.toReadOnly(),
      store.toReadOnly(),
      rent.toReadOnly(),
      systemProgram.toReadOnly(),
      tokenProgram.toReadOnly(),
    ], programId: MetaplexNFTPacksProgramConst.programId, layout: layout);
  }
  factory MetaplexNFTPacksProgram.addVoucherToPack(
      {required SolAddress packSet,
      required SolAddress packVoucher,
      required SolAddress authority,
      required SolAddress voucherOwner,
      required SolAddress masterEdition,
      required SolAddress masterMetadata,
      required SolAddress mint,
      required SolAddress source,
      required SolAddress store,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexNFTPacksProgram(
        keys: [
          packSet.toWritable(),
          packVoucher.toWritable(),
          authority.toSignerAndWritable(),
          voucherOwner.toSigner(),
          masterEdition.toReadOnly(),
          masterMetadata.toReadOnly(),
          mint.toReadOnly(),
          source.toWritable(),
          store.toReadOnly(),
          rent.toReadOnly(),
          systemProgram.toReadOnly(),
          tokenProgram.toReadOnly(),
        ],
        programId: MetaplexNFTPacksProgramConst.programId,
        layout: const MetaplexNFTPacksAddVoucherToPackLayout());
  }
  factory MetaplexNFTPacksProgram.claimPack(
      {required SolAddress packSet,
      required SolAddress provingProcess,
      required SolAddress userWallet,
      required SolAddress packCard,
      required SolAddress userToken,
      required SolAddress newMetadata,
      required SolAddress newEdition,
      required SolAddress masterEdition,
      required SolAddress newMint,
      required SolAddress newMintAuthority,
      required SolAddress metadata,
      required SolAddress metadataMint,
      required SolAddress editionMarker,
      required SolAddress tokenMetadataProgram,
      required MetaplexNFTPacksClaimPackLayout layout,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexNFTPacksProgram(keys: [
      packSet.toReadOnly(),
      provingProcess.toWritable(),
      userWallet.toSigner(),
      packCard.toWritable(),
      userToken.toWritable(),
      newMetadata.toReadOnly(),
      newEdition.toReadOnly(),
      masterEdition.toReadOnly(),
      newMint.toReadOnly(),
      newMintAuthority.toSigner(),
      metadata.toReadOnly(),
      metadataMint.toReadOnly(),
      editionMarker.toReadOnly(),
      rent.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
    ], programId: MetaplexNFTPacksProgramConst.programId, layout: layout);
  }
  factory MetaplexNFTPacksProgram.cleanUp(
      {required SolAddress packSet, required SolAddress packConfig}) {
    return MetaplexNFTPacksProgram(
        keys: [
          packSet.toWritable(),
          packConfig.toWritable(),
        ],
        programId: MetaplexNFTPacksProgramConst.programId,
        layout: const MetaplexNFTPacksCleanUpLayout());
  }
  factory MetaplexNFTPacksProgram.closePack({
    required SolAddress packSet,
    required SolAddress authority,
    required SolAddress clock,
  }) {
    return MetaplexNFTPacksProgram(
        keys: [packSet.toWritable(), authority.toSigner(), clock.toReadOnly()],
        programId: MetaplexNFTPacksProgramConst.programId,
        layout: const MetaplexNFTPacksClosePackLayout());
  }
  factory MetaplexNFTPacksProgram.deactivate({
    required SolAddress packSet,
    required SolAddress authority,
  }) {
    return MetaplexNFTPacksProgram(
        keys: [packSet.toWritable(), authority.toSigner()],
        programId: MetaplexNFTPacksProgramConst.programId,
        layout: const MetaplexNFTPacksDeactivateLayout());
  }
  factory MetaplexNFTPacksProgram.deletePack({
    required SolAddress packSet,
    required SolAddress authority,
    required SolAddress refunder,
  }) {
    return MetaplexNFTPacksProgram(
        keys: [
          packSet.toWritable(),
          authority.toSigner(),
          refunder.toWritable()
        ],
        programId: MetaplexNFTPacksProgramConst.programId,
        layout: const MetaplexNFTPacksDeletePackLayout());
  }
  factory MetaplexNFTPacksProgram.deletePackCard(
      {required SolAddress packSet,
      required SolAddress packCard,
      required SolAddress authority,
      required SolAddress refunder,
      required SolAddress newMasterEditionOwner,
      required SolAddress tokenAccount,
      required SolAddress programAuthority,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexNFTPacksProgram(
        keys: [
          packSet.toWritable(),
          packCard.toWritable(),
          authority.toSigner(),
          refunder.toWritable(),
          newMasterEditionOwner.toWritable(),
          tokenAccount.toWritable(),
          programAuthority.toReadOnly(),
          rent.toReadOnly(),
          tokenProgram.toReadOnly()
        ],
        programId: MetaplexNFTPacksProgramConst.programId,
        layout: const MetaplexNFTPacksDeletePackCardLayout());
  }
  factory MetaplexNFTPacksProgram.deletePackConfig({
    required SolAddress packSet,
    required SolAddress packConfig,
    required SolAddress refunder,
    required SolAddress authority,
  }) {
    return MetaplexNFTPacksProgram(
        keys: [
          packSet.toReadOnly(),
          packConfig.toWritable(),
          refunder.toWritable(),
          authority.toSigner()
        ],
        programId: MetaplexNFTPacksProgramConst.programId,
        layout: const MetaplexNFTPacksDeletePackConfigLayout());
  }
  factory MetaplexNFTPacksProgram.deletePackVoucher({
    required SolAddress packSet,
    required SolAddress packVoucher,
    required SolAddress authority,
    required SolAddress refunder,
  }) {
    return MetaplexNFTPacksProgram(
        keys: [
          packSet.toWritable(),
          packVoucher.toWritable(),
          authority.toSigner(),
          refunder.toWritable(),
        ],
        programId: MetaplexNFTPacksProgramConst.programId,
        layout: const MetaplexNFTPacksDeletePackVoucherLayout());
  }
  factory MetaplexNFTPacksProgram.editPack(
      {required SolAddress packSet,
      required SolAddress authority,
      required MetaplexNFTPacksEditPackLayout layout}) {
    return MetaplexNFTPacksProgram(
        keys: [packSet.toWritable(), authority.toSigner()],
        programId: MetaplexNFTPacksProgramConst.programId,
        layout: layout);
  }
  factory MetaplexNFTPacksProgram.initPack({
    required SolAddress packSet,
    required SolAddress authority,
    required SolAddress store,
    required SolAddress clock,
    SolAddress? whitelistedCreator,
    required MetaplexNFTPacksInitPackLayout layout,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
  }) {
    return MetaplexNFTPacksProgram(keys: [
      packSet.toWritable(),
      authority.toSigner(),
      store.toReadOnly(),
      rent.toReadOnly(),
      clock.toReadOnly(),
      if (whitelistedCreator != null) whitelistedCreator.toReadOnly()
    ], programId: MetaplexNFTPacksProgramConst.programId, layout: layout);
  }
  factory MetaplexNFTPacksProgram.requestCardForRedeem({
    required SolAddress packSet,
    required SolAddress packConfig,
    required SolAddress store,
    required SolAddress edition,
    required SolAddress editionMint,
    required SolAddress packVoucher,
    required SolAddress provingProcess,
    required SolAddress userWallet,
    required SolAddress recentSlothashes,
    required SolAddress clock,
    SolAddress? userToken,
    required MetaplexNFTPacksRequestCardForRedeemLayout layout,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexNFTPacksProgram(keys: [
      packSet.toReadOnly(),
      packConfig.toWritable(),
      store.toReadOnly(),
      edition.toReadOnly(),
      editionMint.toReadOnly(),
      packVoucher.toReadOnly(),
      provingProcess.toWritable(),
      userWallet.toSigner(),
      recentSlothashes.toReadOnly(),
      clock.toReadOnly(),
      rent.toReadOnly(),
      systemProgram.toReadOnly(),
      if (userToken != null) userToken.toReadOnly()
    ], programId: MetaplexNFTPacksProgramConst.programId, layout: layout);
  }
  factory MetaplexNFTPacksProgram.transferPackAuthority({
    required SolAddress packSet,
    required SolAddress currentAuthority,
    required SolAddress newAuthority,
  }) {
    return MetaplexNFTPacksProgram(
        keys: [
          packSet.toWritable(),
          currentAuthority.toSigner(),
          newAuthority.toReadOnly()
        ],
        programId: MetaplexNFTPacksProgramConst.programId,
        layout: const MetaplexNFTPacksTransferPackAuthorityLayout());
  }
}
