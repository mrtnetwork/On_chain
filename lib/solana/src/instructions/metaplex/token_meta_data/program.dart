import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/associated_token_account/constant.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/layout/layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

class MetaplexTokenMetaDataProgram extends TransactionInstruction {
  MetaplexTokenMetaDataProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);

  factory MetaplexTokenMetaDataProgram.approveCollectionAuthority(
      {required SolAddress collectionAuthorityRecord,
      required SolAddress newCollectionAuthority,
      required SolAddress metadata,
      required SolAddress mint,
      required SolAddress updateAuthority,
      required SolAddress payer,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress? rent}) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          collectionAuthorityRecord.toWritable(),
          newCollectionAuthority.toReadOnly(),
          updateAuthority.toSignerAndWritable(),
          payer.toSignerAndWritable(),
          metadata.toReadOnly(),
          mint.toReadOnly(),
          systemProgram.toReadOnly(),
          if (rent != null) rent.toReadOnly()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: const MetaplexTokenMetaDataApproveCollectionAuthorityLayout());
  }
  factory MetaplexTokenMetaDataProgram.approveUseAuthority(
      {required SolAddress useAuthorityRecord,
      required SolAddress owner,
      required SolAddress payer,
      required SolAddress user,
      required SolAddress ownerTokenAccount,
      required SolAddress metadata,
      required SolAddress mint,
      required SolAddress burner,
      required MetaplexTokenMetaDataapproveUseAuthorityLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress? rent}) {
    return MetaplexTokenMetaDataProgram(keys: [
      useAuthorityRecord.toWritable(),
      owner.toSignerAndWritable(),
      payer.toSignerAndWritable(),
      user.toReadOnly(),
      ownerTokenAccount.toWritable(),
      metadata.toReadOnly(),
      mint.toReadOnly(),
      burner.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      if (rent != null) rent.toReadOnly()
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.bubblegumSetCollectionSize({
    required SolAddress collectionMetadata,
    required SolAddress collectionAuthority,
    required SolAddress collectionMint,
    required SolAddress bubblegumSigner,
    SolAddress? collectionAuthorityRecord,
    required MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout layout,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      collectionMetadata.toWritable(),
      collectionAuthority.toSignerAndWritable(),
      collectionMint.toReadOnly(),
      bubblegumSigner.toSigner(),
      if (collectionAuthorityRecord != null)
        collectionAuthorityRecord.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.burnEditionNft({
    required SolAddress metadata,
    required SolAddress owner,
    required SolAddress printEditionMint,
    required SolAddress masterEditionMint,
    required SolAddress printEditionTokenAccount,
    required SolAddress masterEditionTokenAccount,
    required SolAddress masterEditionAccount,
    required SolAddress printEditionAccount,
    required SolAddress editionMarkerAccount,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          owner.toSignerAndWritable(),
          printEditionMint.toWritable(),
          masterEditionMint.toReadOnly(),
          printEditionTokenAccount.toWritable(),
          masterEditionTokenAccount.toReadOnly(),
          masterEditionAccount.toWritable(),
          printEditionAccount.toWritable(),
          editionMarkerAccount.toWritable(),
          tokenProgram.toReadOnly(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataBurnEditionNftLayout());
  }
  factory MetaplexTokenMetaDataProgram.burnNft({
    required SolAddress metadata,
    required SolAddress owner,
    required SolAddress mint,
    required SolAddress tokenAccount,
    required SolAddress masterEditionAccount,
    SolAddress? collectionMetadata,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          owner.toSignerAndWritable(),
          mint.toWritable(),
          tokenAccount.toWritable(),
          masterEditionAccount.toWritable(),
          tokenProgram.toReadOnly(),
          if (collectionMetadata != null) collectionMetadata.toWritable()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataburnNftLayout());
  }
  factory MetaplexTokenMetaDataProgram.burnV1({
    required SolAddress authority,
    SolAddress? collectionMetadata,
    required SolAddress metadata,
    SolAddress? edition,
    required SolAddress mint,
    required SolAddress token,
    SolAddress? masterEdition,
    SolAddress? masterEditionMint,
    SolAddress? masterEditionToken,
    SolAddress? editionMarker,
    SolAddress? tokenRecord,
    required MetaplexTokenMetaDataBurnV1Layout layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress sysvarInstructions = SystemProgramConst.sysvarInstructionsPubkey,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      authority.toSignerAndWritable(),
      collectionMetadata?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      metadata.toWritable(),
      edition?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      mint.toWritable(),
      token.toWritable(),
      masterEdition?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      masterEditionMint?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      masterEditionToken?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      editionMarker?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      tokenRecord?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      tokenProgram.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.closeEscrowAccount({
    required SolAddress escrow,
    required SolAddress metadata,
    required SolAddress mint,
    required SolAddress tokenAccount,
    required SolAddress edition,
    required SolAddress payer,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress sysvarInstructions = SystemProgramConst.sysvarInstructionsPubkey,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          escrow.toWritable(),
          metadata.toWritable(),
          mint.toReadOnly(),
          tokenAccount.toReadOnly(),
          edition.toReadOnly(),
          payer.toSignerAndWritable(),
          systemProgram.toReadOnly(),
          sysvarInstructions.toReadOnly(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataCloseEscrowAccountLayout());
  }
  factory MetaplexTokenMetaDataProgram.collect({
    required SolAddress authority,
    required SolAddress recipient,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          authority.toSigner(),
          recipient.toReadOnly(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataCollectLayout());
  }
  factory MetaplexTokenMetaDataProgram.convertMasterEditionV1ToV2({
    required SolAddress masterEdition,
    required SolAddress oneTimeAuth,
    required SolAddress printingMint,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          masterEdition.toWritable(),
          oneTimeAuth.toWritable(),
          printingMint.toWritable()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataConvertMasterEditionV1ToV2Layout());
  }
  factory MetaplexTokenMetaDataProgram.createEscrowAccount({
    required SolAddress escrow,
    required SolAddress metadata,
    required SolAddress mint,
    required SolAddress tokenAccount,
    required SolAddress edition,
    required SolAddress payer,
    SolAddress? authority,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress sysvarInstructions = SystemProgramConst.sysvarInstructionsPubkey,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          escrow.toWritable(),
          metadata.toWritable(),
          mint.toReadOnly(),
          tokenAccount.toReadOnly(),
          edition.toReadOnly(),
          payer.toSignerAndWritable(),
          systemProgram.toReadOnly(),
          sysvarInstructions.toReadOnly(),
          if (authority != null) authority.toSigner()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataCreateEscrowAccountLayout());
  }
  factory MetaplexTokenMetaDataProgram.createMasterEdition({
    required SolAddress edition,
    required SolAddress mint,
    required SolAddress updateAuthority,
    required SolAddress mintAuthority,
    required SolAddress payer,
    required SolAddress metadata,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          edition.toWritable(),
          mint.toWritable(),
          updateAuthority.toSigner(),
          mintAuthority.toSigner(),
          payer.toSignerAndWritable(),
          metadata.toReadOnly(),
          tokenProgram.toReadOnly(),
          systemProgram.toReadOnly(),
          rent.toReadOnly(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataCreateMasterEditionLayout());
  }
  factory MetaplexTokenMetaDataProgram.createMasterEditionV3({
    required SolAddress edition,
    required SolAddress mint,
    required SolAddress updateAuthority,
    required SolAddress mintAuthority,
    required SolAddress payer,
    required SolAddress metadata,
    required MetaplexTokenMetaDataCreateMasterEditionV3Layout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress? rent,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      edition.toWritable(),
      mint.toWritable(),
      updateAuthority.toSigner(),
      mintAuthority.toSigner(),
      payer.toSignerAndWritable(),
      metadata.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      if (rent != null) rent.toReadOnly()
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.createMetadataAccount({
    required SolAddress metadata,
    required SolAddress mint,
    required SolAddress mintAuthority,
    required SolAddress payer,
    required SolAddress updateAuthority,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          mint.toReadOnly(),
          mintAuthority.toSigner(),
          payer.toSignerAndWritable(),
          updateAuthority.toReadOnly(),
          systemProgram.toReadOnly(),
          rent.toReadOnly(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataCreateMetadataAccountLayout());
  }
  factory MetaplexTokenMetaDataProgram.createMetadataAccountV2({
    required SolAddress metadata,
    required SolAddress mint,
    required SolAddress mintAuthority,
    required SolAddress payer,
    required SolAddress updateAuthority,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? rent,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          mint.toReadOnly(),
          mintAuthority.toSigner(),
          payer.toSignerAndWritable(),
          updateAuthority.toReadOnly(),
          systemProgram.toReadOnly(),
          if (rent != null) rent.toReadOnly(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataCreateMetadataAccountV2Layout());
  }
  factory MetaplexTokenMetaDataProgram.createMetadataAccountV3({
    required SolAddress metadata,
    required SolAddress mint,
    required SolAddress mintAuthority,
    required SolAddress payer,
    required SolAddress updateAuthority,
    required MetaplexTokenMetaDataCreateMetadataAccountV3Layout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? rent,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      metadata.toWritable(),
      mint.toReadOnly(),
      mintAuthority.toSigner(),
      payer.toSignerAndWritable(),
      updateAuthority.toReadOnly(),
      systemProgram.toReadOnly(),
      if (rent != null) rent.toReadOnly()
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.createV1({
    required SolAddress metadata,
    SolAddress? masterEdition,
    required SolAddress mint,
    required SolAddress authority,
    required SolAddress payer,
    required SolAddress updateAuthority,
    required MetaplexTokenMetaDataCreateV1Layout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress sysvarInstructions = SystemProgramConst.sysvarInstructionsPubkey,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      metadata.toWritable(),
      masterEdition?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      mint.toWritable(),
      authority.toSigner(),
      payer.toSignerAndWritable(),
      updateAuthority.toReadOnly(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      tokenProgram.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.delegate({
    required SolAddress delegate,
    required SolAddress metadata,
    required SolAddress mint,
    required SolAddress authority,
    required SolAddress payer,
    required SolAddress sysvarInstructions,
    required MetaplexTokenMetaDataDelegateProgramLayout layout,
    SolAddress? delegateRecord,
    SolAddress? masterEdition,
    SolAddress? tokenRecord,
    SolAddress? token,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? splTokenProgram,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      delegateRecord?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      delegate.toReadOnly(),
      metadata.toWritable(),
      masterEdition?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      (tokenRecord?.toReadOnly() ??
              MetaplexTokenMetaDataProgramConst.programId.toReadOnly())
          .copyWith(isWritable: tokenRecord != null),
      mint.toReadOnly(),
      (token?.toReadOnly() ??
              MetaplexTokenMetaDataProgramConst.programId.toReadOnly())
          .copyWith(isWritable: token != null),
      authority.toSigner(),
      payer.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      splTokenProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRulesProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRules?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }

  factory MetaplexTokenMetaDataProgram.deprecatedMintNewEditionFromMasterEditionViaPrintingToken({
    required SolAddress metadata,
    required SolAddress edition,
    required SolAddress masterEdition,
    required SolAddress mint,
    required SolAddress mintAuthority,
    required SolAddress printingMint,
    required SolAddress masterTokenAccount,
    required SolAddress editionMarker,
    required SolAddress burnAuthority,
    required SolAddress payer,
    required SolAddress masterUpdateAuthority,
    required SolAddress masterMetadata,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
    SolAddress? reservationList,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          edition.toWritable(),
          masterEdition.toWritable(),
          mint.toWritable(),
          mintAuthority.toSigner(),
          printingMint.toWritable(),
          masterTokenAccount.toWritable(),
          editionMarker.toWritable(),
          burnAuthority.toSigner(),
          payer.toSigner(),
          masterUpdateAuthority.toReadOnly(),
          masterMetadata.toReadOnly(),
          tokenProgram.toReadOnly(),
          systemProgram.toReadOnly(),
          rent.toReadOnly(),
          if (reservationList != null) reservationList.toWritable()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout:
            MetaplexTokenMetaDataDeprecatedMintNewEditionFromMasterEditionViaPrintingTokenLayout());
  }
  factory MetaplexTokenMetaDataProgram.freezeDelegatedAccount({
    required SolAddress delegate,
    required SolAddress tokenAccount,
    required SolAddress edition,
    required SolAddress mint,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          delegate.toSignerAndWritable(),
          tokenAccount.toWritable(),
          edition.toReadOnly(),
          mint.toReadOnly(),
          tokenProgram.toReadOnly(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataFreezeDelegatedAccountLayout());
  }
  factory MetaplexTokenMetaDataProgram.lockV1({
    required SolAddress authority,
    required SolAddress token,
    required SolAddress mint,
    required SolAddress metadata,
    required SolAddress payer,
    required SolAddress sysvarInstructions,
    required MetaplexTokenMetaDataLockV1Layout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? tokenOwner,
    SolAddress? edition,
    SolAddress? tokenRecord,
    SolAddress? splTokenProgram,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      authority.toSigner(),
      tokenOwner?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      token.toWritable(),
      mint.toReadOnly(),
      metadata.toWritable(),
      edition?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      tokenRecord?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      payer.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      splTokenProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRulesProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRules?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.migrate({
    required SolAddress metadata,
    required SolAddress edition,
    required SolAddress token,
    required SolAddress tokenOwner,
    required SolAddress mint,
    required SolAddress payer,
    required SolAddress authority,
    required SolAddress collectionMetadata,
    required SolAddress delegateRecord,
    required SolAddress tokenRecord,
    SolAddress systemProgram = SystemProgramConst.programId,
    required SolAddress sysvarInstructions,
    required SolAddress splTokenProgram,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          edition.toWritable(),
          token.toWritable(),
          tokenOwner.toReadOnly(),
          mint.toReadOnly(),
          payer.toSignerAndWritable(),
          authority.toSigner(),
          collectionMetadata.toReadOnly(),
          delegateRecord.toReadOnly(),
          tokenRecord.toWritable(),
          systemProgram.toReadOnly(),
          sysvarInstructions.toReadOnly(),
          splTokenProgram.toReadOnly(),
          authorizationRulesProgram?.toReadOnly() ??
              MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
          authorizationRules?.toReadOnly() ??
              MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataMigrateLayout());
  }
  factory MetaplexTokenMetaDataProgram.mintNewEditionFromMasterEditionViaToken({
    required SolAddress newMetadata,
    required SolAddress newEdition,
    required SolAddress masterEdition,
    required SolAddress newMint,
    required SolAddress editionMarkPda,
    required SolAddress newMintAuthority,
    required SolAddress payer,
    required SolAddress tokenAccountOwner,
    required SolAddress tokenAccount,
    required SolAddress newMetadataUpdateAuthority,
    required SolAddress metadata,
    required MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaTokenLayout
        layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? rent,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      newMetadata.toWritable(),
      newEdition.toWritable(),
      masterEdition.toWritable(),
      newMint.toWritable(),
      editionMarkPda.toWritable(),
      newMintAuthority.toSigner(),
      payer.toSignerAndWritable(),
      tokenAccountOwner.toSigner(),
      tokenAccount.toReadOnly(),
      newMetadataUpdateAuthority.toReadOnly(),
      metadata.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      if (rent != null) rent.toReadOnly()
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.mintNewEditionFromMasterEditionViaVaultProxy({
    required SolAddress newMetadata,
    required SolAddress newEdition,
    required SolAddress masterEdition,
    required SolAddress newMint,
    required SolAddress editionMarkPda,
    required SolAddress newMintAuthority,
    required SolAddress payer,
    required SolAddress vaultAuthority,
    required SolAddress safetyDepositStore,
    required SolAddress safetyDepositBox,
    required SolAddress vault,
    required SolAddress newMetadataUpdateAuthority,
    required SolAddress metadata,
    required SolAddress tokenVaultProgram,
    required MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaVaultProxyLayout
        layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? rent,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      newMetadata.toWritable(),
      newEdition.toWritable(),
      masterEdition.toWritable(),
      newMint.toWritable(),
      editionMarkPda.toWritable(),
      newMintAuthority.toSigner(),
      payer.toSignerAndWritable(),
      vaultAuthority.toSigner(),
      safetyDepositStore.toReadOnly(),
      safetyDepositBox.toReadOnly(),
      vault.toReadOnly(),
      newMetadataUpdateAuthority.toReadOnly(),
      metadata.toReadOnly(),
      tokenProgram.toReadOnly(),
      tokenVaultProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      if (rent != null) rent.toReadOnly()
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.mintV1({
    required SolAddress token,
    required SolAddress mint,
    required SolAddress authority,
    required SolAddress payer,
    required SolAddress sysvarInstructions,
    required SolAddress splTokenProgram,
    required SolAddress splAtaProgram,
    required SolAddress metadata,
    required MetaplexTokenMetaDataMintV1Layout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? tokenOwner,
    SolAddress? masterEdition,
    SolAddress? tokenRecord,
    SolAddress? delegateRecord,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      token.toWritable(),
      tokenOwner?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      metadata.toReadOnly(),
      masterEdition?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      tokenRecord?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      mint.toWritable(),
      authority.toSigner(),
      delegateRecord?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      payer.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      splTokenProgram.toReadOnly(),
      splAtaProgram.toReadOnly(),
      authorizationRulesProgram?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRules?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.printV1({
    required SolAddress editionMetadata,
    required SolAddress edition,
    required SolAddress editionMint,
    required SolAddress editionTokenAccountOwner,
    required SolAddress editionTokenAccount,
    required SolAddress editionMintAuthority,
    required SolAddress masterEdition,
    required SolAddress editionMarkerPda,
    required SolAddress payer,
    required SolAddress masterTokenAccountOwner,
    required SolAddress masterTokenAccount,
    required SolAddress masterMetadata,
    required SolAddress updateAuthority,
    required SolAddress splTokenProgram,
    required SolAddress splAtaProgram,
    required SolAddress sysvarInstructions,
    required MetaplexTokenMetaDataPrintV1Layout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? editionTokenRecord,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      editionMetadata.toWritable(),
      edition.toWritable(),
      editionMint.toWritable(),
      editionTokenAccountOwner.toReadOnly(),
      editionTokenAccount.toWritable(),
      editionMintAuthority.toSigner(),
      editionTokenRecord?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      masterEdition.toWritable(),
      editionMarkerPda.toWritable(),
      payer.toSignerAndWritable(),
      masterTokenAccountOwner.toSigner(),
      masterTokenAccount.toReadOnly(),
      masterMetadata.toReadOnly(),
      updateAuthority.toReadOnly(),
      splTokenProgram.toReadOnly(),
      splAtaProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      systemProgram.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.puffMetadata(
      {required SolAddress metadata}) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataPuffMetadataLayout());
  }
  factory MetaplexTokenMetaDataProgram.removeCreatorVerification(
      {required SolAddress metadata, required SolAddress creator}) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          creator.toSigner(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataRemoveCreatorVerificationLayout());
  }
  factory MetaplexTokenMetaDataProgram.revoke({
    required SolAddress delegate,
    required SolAddress metadata,
    required SolAddress authority,
    required SolAddress payer,
    required SolAddress mint,
    required SolAddress sysvarInstructions,
    required MetaplexTokenMetaDataRevokeLayout layout,
    SolAddress? delegateRecord,
    SolAddress? masterEdition,
    SolAddress? tokenRecord,
    SolAddress? token,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? splTokenProgram,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      delegateRecord?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      delegate.toReadOnly(),
      metadata.toWritable(),
      masterEdition?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      tokenRecord?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      mint.toReadOnly(),
      token?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authority.toSigner(),
      payer.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      splTokenProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRulesProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRules?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.revokeCollectionAuthority({
    required SolAddress collectionAuthorityRecord,
    required SolAddress delegateAuthority,
    required SolAddress revokeAuthority,
    required SolAddress metadata,
    required SolAddress mint,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          collectionAuthorityRecord.toWritable(),
          delegateAuthority.toWritable(),
          revokeAuthority.toSignerAndWritable(),
          metadata.toReadOnly(),
          mint.toReadOnly(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataRevokeCollectionAuthorityLayout());
  }
  factory MetaplexTokenMetaDataProgram.revokeUseAuthority({
    required SolAddress useAuthorityRecord,
    required SolAddress owner,
    required SolAddress user,
    required SolAddress ownerTokenAccount,
    required SolAddress mint,
    required SolAddress metadata,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress? rent,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          useAuthorityRecord.toWritable(),
          owner.toSignerAndWritable(),
          user.toReadOnly(),
          ownerTokenAccount.toWritable(),
          mint.toReadOnly(),
          metadata.toReadOnly(),
          tokenProgram.toReadOnly(),
          systemProgram.toReadOnly(),
          if (rent != null) rent.toReadOnly()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataRevokeUseAuthorityLayout());
  }
  factory MetaplexTokenMetaDataProgram.setAndVerifyCollection({
    required SolAddress metadata,
    required SolAddress collectionAuthority,
    required SolAddress payer,
    required SolAddress updateAuthority,
    required SolAddress collectionMint,
    required SolAddress collection,
    required SolAddress collectionMasterEditionAccount,
    SolAddress? collectionAuthorityRecord,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          collectionAuthority.toSignerAndWritable(),
          payer.toSignerAndWritable(),
          updateAuthority.toReadOnly(),
          collectionMint.toReadOnly(),
          collection.toReadOnly(),
          collectionMasterEditionAccount.toReadOnly(),
          if (collectionAuthorityRecord != null)
            collectionAuthorityRecord.toReadOnly()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataSetAndVerifyCollectionLayout());
  }
  factory MetaplexTokenMetaDataProgram.setAndVerifySizedCollectionItem({
    required SolAddress metadata,
    required SolAddress collectionAuthority,
    required SolAddress payer,
    required SolAddress updateAuthority,
    required SolAddress collectionMint,
    required SolAddress collection,
    required SolAddress collectionMasterEditionAccount,
    SolAddress? collectionAuthorityRecord,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          collectionAuthority.toSigner(),
          payer.toSignerAndWritable(),
          updateAuthority.toReadOnly(),
          collectionMint.toReadOnly(),
          collection.toWritable(),
          collectionMasterEditionAccount.toWritable(),
          if (collectionAuthorityRecord != null)
            collectionAuthorityRecord.toReadOnly()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataSetAndVerifySizedCollectionItemLayout());
  }
  factory MetaplexTokenMetaDataProgram.setCollectionSize({
    required SolAddress collectionMetadata,
    required SolAddress collectionAuthority,
    required SolAddress collectionMint,
    SolAddress? collectionAuthorityRecord,
    required MetaplexTokenMetaDataSetCollectionSizeLayout layout,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      collectionMetadata.toWritable(),
      collectionAuthority.toSignerAndWritable(),
      collectionMint.toReadOnly(),
      if (collectionAuthorityRecord != null)
        collectionAuthorityRecord.toReadOnly()
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.setTokenStandard({
    required SolAddress metadata,
    required SolAddress updateAuthority,
    required SolAddress mint,
    SolAddress? edition,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          updateAuthority.toSigner(),
          mint.toReadOnly(),
          if (edition != null) edition.toReadOnly()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataSetTokenStandardLayout());
  }
  factory MetaplexTokenMetaDataProgram.signMetadata({
    required SolAddress metadata,
    required SolAddress creator,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [metadata.toWritable(), creator.toSigner()],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataSignMetadataLayout());
  }
  factory MetaplexTokenMetaDataProgram.thawDelegatedAccount({
    required SolAddress delegate,
    required SolAddress tokenAccount,
    required SolAddress edition,
    required SolAddress mint,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          delegate.toSignerAndWritable(),
          tokenAccount.toWritable(),
          edition.toReadOnly(),
          mint.toReadOnly(),
          tokenProgram.toReadOnly()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataThawDelegatedAccountLayout());
  }
  factory MetaplexTokenMetaDataProgram.transferOutOfEscrow({
    required SolAddress escrow,
    required SolAddress metadata,
    required SolAddress payer,
    required SolAddress attributeMint,
    required SolAddress attributeSrc,
    required SolAddress attributeDst,
    required SolAddress escrowMint,
    required SolAddress escrowAccount,
    required SolAddress sysvarInstructions,
    required MetaplexTokenMetaDataTransferOutOfEscrowLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress ataProgram =
        AssociatedTokenAccountProgramConst.associatedTokenProgramId,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress? authority,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      escrow.toReadOnly(),
      metadata.toWritable(),
      payer.toSignerAndWritable(),
      attributeMint.toReadOnly(),
      attributeSrc.toWritable(),
      attributeDst.toWritable(),
      escrowMint.toReadOnly(),
      escrowAccount.toReadOnly(),
      systemProgram.toReadOnly(),
      ataProgram.toReadOnly(),
      tokenProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      if (authority != null) authority.toSigner()
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.transferV1({
    required SolAddress token,
    required SolAddress tokenOwner,
    required SolAddress destination,
    required SolAddress destinationOwner,
    required SolAddress mint,
    required SolAddress metadata,
    required SolAddress authority,
    required SolAddress payer,
    required SolAddress sysvarInstructions,
    required SolAddress splTokenProgram,
    required SolAddress splAtaProgram,
    required MetaplexTokenMetaDataTransferV1Layout layout,
    SolAddress? edition,
    SolAddress? ownerTokenRecord,
    SolAddress? destinationTokenRecord,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      token.toWritable(),
      tokenOwner.toReadOnly(),
      destination.toWritable(),
      destinationOwner.toReadOnly(),
      mint.toReadOnly(),
      metadata.toWritable(),
      edition?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      ownerTokenRecord?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      destinationTokenRecord?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authority.toSigner(),
      payer.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      splTokenProgram.toReadOnly(),
      splAtaProgram.toReadOnly(),
      authorizationRulesProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRules?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.unlockV1({
    required SolAddress authority,
    required SolAddress token,
    required SolAddress mint,
    required SolAddress metadata,
    required SolAddress payer,
    required SolAddress sysvarInstructions,
    required MetaplexTokenMetaDataUnlockV1Layout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? tokenOwner,
    SolAddress? edition,
    SolAddress? tokenRecord,
    SolAddress? splTokenProgram,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      authority.toSigner(),
      tokenOwner?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      token.toWritable(),
      mint.toReadOnly(),
      metadata.toWritable(),
      edition?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      tokenRecord?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      payer.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      splTokenProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRulesProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRules?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.unverify({
    required SolAddress authority,
    required SolAddress metadata,
    required SolAddress sysvarInstructions,
    required MetaplexTokenMetaDataUnverifyLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? collectionMint,
    SolAddress? collectionMetadata,
    SolAddress? delegateRecord,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      authority.toSigner(),
      delegateRecord?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      metadata.toWritable(),
      collectionMint?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      collectionMetadata?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly()
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.unverifyCollection({
    required SolAddress metadata,
    required SolAddress collectionAuthority,
    required SolAddress collectionMint,
    required SolAddress collection,
    required SolAddress collectionMasterEditionAccount,
    SolAddress? collectionAuthorityRecord,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          collectionAuthority.toSignerAndWritable(),
          collectionMint.toReadOnly(),
          collection.toReadOnly(),
          collectionMasterEditionAccount.toReadOnly(),
          if (collectionAuthorityRecord != null)
            collectionAuthorityRecord.toReadOnly()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataUnverifyCollectionLayout());
  }
  factory MetaplexTokenMetaDataProgram.unverifySizedCollectionItem({
    required SolAddress metadata,
    required SolAddress collectionAuthority,
    required SolAddress payer,
    required SolAddress collectionMint,
    required SolAddress collection,
    required SolAddress collectionMasterEditionAccount,
    SolAddress? collectionAuthorityRecord,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          collectionAuthority.toSigner(),
          payer.toSignerAndWritable(),
          collectionMint.toReadOnly(),
          collection.toWritable(),
          collectionMasterEditionAccount.toReadOnly(),
          if (collectionAuthorityRecord != null)
            collectionAuthorityRecord.toReadOnly()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataUnverifySizedCollectionItemLayout());
  }
  factory MetaplexTokenMetaDataProgram.update({
    required SolAddress authority,
    required SolAddress mint,
    required SolAddress metadata,
    required SolAddress payer,
    required SolAddress sysvarInstructions,
    required MetaplexTokenMetaDataUpdateProgramLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? delegateRecord,
    SolAddress? token,
    SolAddress? edition,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      authority.toSigner(),
      delegateRecord?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      token?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      mint.toReadOnly(),
      metadata.toWritable(),
      edition?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      payer.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      authorizationRulesProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRules?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.updateMetadataAccountV2({
    required SolAddress metadata,
    required SolAddress updateAuthority,
    required MetaplexTokenMetaDataUpdateMetadataAccountV2Layout layout,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      metadata.toWritable(),
      updateAuthority.toSigner(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.updatePrimarySaleHappenedViaToken({
    required SolAddress metadata,
    required SolAddress owner,
    required SolAddress token,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          owner.toSigner(),
          token.toReadOnly(),
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataUpdatePrimarySaleHappenedViaTokenLayout());
  }
  factory MetaplexTokenMetaDataProgram.useV1({
    required SolAddress authority,
    required SolAddress mint,
    required SolAddress metadata,
    required SolAddress payer,
    required SolAddress sysvarInstructions,
    required MetaplexTokenMetaDataUseV1Layout layout,
    SolAddress? delegateRecord,
    SolAddress? token,
    SolAddress? edition,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress? splTokenProgram,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      authority.toSigner(),
      delegateRecord?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      token?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      mint.toReadOnly(),
      metadata.toWritable(),
      edition?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      payer.toSigner(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      splTokenProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRulesProgram?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      authorizationRules?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.utilize({
    required SolAddress metadata,
    required SolAddress tokenAccount,
    required SolAddress mint,
    required SolAddress useAuthority,
    required SolAddress owner,
    required MetaplexTokenMetaDataUtilizeLayout layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress ataProgram =
        AssociatedTokenAccountProgramConst.associatedTokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress rent = SystemProgramConst.sysvarRentPubkey,
    SolAddress? useAuthorityRecord,
    SolAddress? burner,
  }) {
    if (burner != null) {
      if (useAuthorityRecord == null) {
        throw MessageException(
            "When providing 'burner' then 'accounts.useAuthorityRecord' need(s) to be provided as well.");
      }
    }
    return MetaplexTokenMetaDataProgram(keys: [
      metadata.toWritable(),
      tokenAccount.toWritable(),
      mint.toWritable(),
      useAuthority.toSignerAndWritable(),
      owner.toReadOnly(),
      tokenProgram.toReadOnly(),
      ataProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
      if (useAuthorityRecord != null) useAuthorityRecord.toWritable(),
      if (burner != null) burner.toReadOnly()
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.verify({
    required SolAddress authority,
    required SolAddress metadata,
    required SolAddress sysvarInstructions,
    required MetaplexTokenMetaDataVerifyCollectionV1Layout layout,
    SolAddress? delegateRecord,
    SolAddress? collectionMint,
    SolAddress? collectionMetadata,
    SolAddress? collectionMasterEdition,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexTokenMetaDataProgram(keys: [
      authority.toSigner(),
      delegateRecord?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      metadata.toWritable(),
      collectionMint?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      collectionMetadata?.toWritable() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      collectionMasterEdition?.toReadOnly() ??
          MetaplexTokenMetaDataProgramConst.programId.toReadOnly(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly()
    ], programId: MetaplexTokenMetaDataProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenMetaDataProgram.verifyCollection({
    required SolAddress metadata,
    required SolAddress collectionAuthority,
    required SolAddress payer,
    required SolAddress collectionMint,
    required SolAddress collection,
    required SolAddress collectionMasterEditionAccount,
    SolAddress? collectionAuthorityRecord,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          collectionAuthority.toSignerAndWritable(),
          payer.toSignerAndWritable(),
          collectionMint.toReadOnly(),
          collection.toReadOnly(),
          collectionMasterEditionAccount.toReadOnly(),
          if (collectionAuthorityRecord != null)
            collectionAuthorityRecord.toReadOnly()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataVerifyCollectionLayout());
  }
  factory MetaplexTokenMetaDataProgram.verifySizedCollection({
    required SolAddress metadata,
    required SolAddress collectionAuthority,
    required SolAddress payer,
    required SolAddress collectionMint,
    required SolAddress collection,
    required SolAddress collectionMasterEditionAccount,
    SolAddress? collectionAuthorityRecord,
  }) {
    return MetaplexTokenMetaDataProgram(
        keys: [
          metadata.toWritable(),
          collectionAuthority.toSigner(),
          payer.toSignerAndWritable(),
          collectionMint.toReadOnly(),
          collection.toWritable(),
          collectionMasterEditionAccount.toReadOnly(),
          if (collectionAuthorityRecord != null)
            collectionAuthorityRecord.toReadOnly()
        ],
        programId: MetaplexTokenMetaDataProgramConst.programId,
        layout: MetaplexTokenMetaDataVerifySizedCollectionItemLayout());
  }
}
