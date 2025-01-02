import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexBubblegumProgram extends TransactionInstruction {
  MetaplexBubblegumProgram({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());
  factory MetaplexBubblegumProgram.burn(
      {required SolAddress treeAuthority,
      required SolAddress leafOwner,
      required SolAddress leafDelegate,
      required SolAddress merkleTree,
      required SolAddress logWrapper,
      required SolAddress compressionProgram,
      required MetaplexBubblegumBurnLayout layout,
      List<AccountMeta> anchorRemainingAccounts = const [],
      SolAddress systemProgram = SystemProgramConst.programId}) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toReadOnly(),
      leafOwner.toReadOnly(),
      leafDelegate.toReadOnly(),
      merkleTree.toWritable(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.cancelRedeem(
      {required SolAddress treeAuthority,
      required SolAddress leafOwner,
      required SolAddress merkleTree,
      required SolAddress voucher,
      required SolAddress logWrapper,
      required SolAddress compressionProgram,
      required MetaplexBubblegumCancelRedeemLayout layout,
      List<AccountMeta> anchorRemainingAccounts = const [],
      SolAddress systemProgram = SystemProgramConst.programId}) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toReadOnly(),
      leafOwner.toSignerAndWritable(),
      merkleTree.toWritable(),
      voucher.toWritable(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.compress({
    required SolAddress treeAuthority,
    required SolAddress leafOwner,
    required SolAddress leafDelegate,
    required SolAddress merkleTree,
    required SolAddress tokenAccount,
    required SolAddress mint,
    required SolAddress metadata,
    required SolAddress masterEdition,
    required SolAddress payer,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required SolAddress tokenMetadataProgram,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
  }) {
    return MetaplexBubblegumProgram(
        keys: [
          treeAuthority.toReadOnly(),
          leafOwner.toSigner(),
          leafDelegate.toReadOnly(),
          merkleTree.toReadOnly(),
          tokenAccount.toWritable(),
          mint.toWritable(),
          metadata.toWritable(),
          masterEdition.toWritable(),
          payer.toSignerAndWritable(),
          logWrapper.toReadOnly(),
          compressionProgram.toReadOnly(),
          tokenProgram.toReadOnly(),
          tokenMetadataProgram.toReadOnly(),
          systemProgram.toReadOnly(),
          ...anchorRemainingAccounts
        ],
        programId: MetaplexBubblegumProgramConst.programId,
        layout: const MetaplexBubblegumCompressLayout());
  }
  factory MetaplexBubblegumProgram.createTree({
    required SolAddress treeAuthority,
    required SolAddress merkleTree,
    required SolAddress payer,
    required SolAddress treeCreator,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required MetaplexBubblegumCreateTreeLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toWritable(),
      merkleTree.toWritable(),
      payer.toSignerAndWritable(),
      treeCreator.toSigner(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.decompressV1({
    required SolAddress voucher,
    required SolAddress leafOwner,
    required SolAddress tokenAccount,
    required SolAddress mint,
    required SolAddress mintAuthority,
    required SolAddress metadata,
    required SolAddress masterEdition,
    required SolAddress sysvarRent,
    required SolAddress tokenMetadataProgram,
    required SolAddress associatedTokenProgram,
    required SolAddress logWrapper,
    required MetaplexBubblegumDecompressV1Layout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
  }) {
    return MetaplexBubblegumProgram(keys: [
      voucher.toWritable(),
      leafOwner.toSignerAndWritable(),
      tokenAccount.toWritable(),
      mint.toWritable(),
      mintAuthority.toWritable(),
      metadata.toWritable(),
      masterEdition.toWritable(),
      systemProgram.toReadOnly(),
      sysvarRent.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      tokenProgram.toReadOnly(),
      associatedTokenProgram.toReadOnly(),
      logWrapper.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.delegate({
    required SolAddress treeAuthority,
    required SolAddress leafOwner,
    required SolAddress previousLeafDelegate,
    required SolAddress newLeafDelegate,
    required SolAddress merkleTree,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required MetaplexBubblegumDelegateLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toReadOnly(),
      leafOwner.toSigner(),
      previousLeafDelegate.toReadOnly(),
      newLeafDelegate.toReadOnly(),
      merkleTree.toWritable(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.mintToCollectionV1({
    required SolAddress treeAuthority,
    required SolAddress leafOwner,
    required SolAddress leafDelegate,
    required SolAddress merkleTree,
    required SolAddress payer,
    required SolAddress treeDelegate,
    required SolAddress collectionAuthority,
    required SolAddress collectionAuthorityRecordPda,
    required SolAddress collectionMint,
    required SolAddress collectionMetadata,
    required SolAddress editionAccount,
    required SolAddress bubblegumSigner,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required SolAddress tokenMetadataProgram,
    required MetaplexBubblegumMintToCollectionV1Layout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toWritable(),
      leafOwner.toReadOnly(),
      leafDelegate.toReadOnly(),
      merkleTree.toWritable(),
      payer.toSigner(),
      treeDelegate.toSigner(),
      collectionAuthority.toSigner(),
      collectionAuthorityRecordPda.toReadOnly(),
      collectionMint.toReadOnly(),
      collectionMetadata.toWritable(),
      editionAccount.toReadOnly(),
      bubblegumSigner.toReadOnly(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.mintV1({
    required SolAddress treeAuthority,
    required SolAddress leafOwner,
    required SolAddress leafDelegate,
    required SolAddress merkleTree,
    required SolAddress payer,
    required SolAddress treeDelegate,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required MetaplexBubblegumMintV1Layout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toWritable(),
      leafOwner.toReadOnly(),
      leafDelegate.toReadOnly(),
      merkleTree.toWritable(),
      payer.toSigner(),
      treeDelegate.toSigner(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.redeem({
    required SolAddress treeAuthority,
    required SolAddress leafOwner,
    required SolAddress leafDelegate,
    required SolAddress merkleTree,
    required SolAddress voucher,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required MetaplexBubblegumRedeemLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toReadOnly(),
      leafOwner.toSignerAndWritable(),
      leafDelegate.toReadOnly(),
      merkleTree.toWritable(),
      voucher.toWritable(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.setAndVerifyCollection({
    required SolAddress treeAuthority,
    required SolAddress leafOwner,
    required SolAddress leafDelegate,
    required SolAddress merkleTree,
    required SolAddress payer,
    required SolAddress treeDelegate,
    required SolAddress collectionAuthority,
    required SolAddress collectionAuthorityRecordPda,
    required SolAddress collectionMint,
    required SolAddress collectionMetadata,
    required SolAddress editionAccount,
    required SolAddress bubblegumSigner,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required SolAddress tokenMetadataProgram,
    required MetaplexBubblegumSetAndVerifyCollectionLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toReadOnly(),
      leafOwner.toReadOnly(),
      leafDelegate.toReadOnly(),
      merkleTree.toWritable(),
      payer.toSigner(),
      treeDelegate.toReadOnly(),
      collectionAuthority.toSigner(),
      collectionAuthorityRecordPda.toReadOnly(),
      collectionMint.toReadOnly(),
      collectionMetadata.toWritable(),
      editionAccount.toReadOnly(),
      bubblegumSigner.toReadOnly(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.setDecompressibleState({
    required SolAddress treeAuthority,
    required SolAddress treeCreator,
    required MetaplexBubblegumSetDecompressibleStateLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toWritable(),
      treeCreator.toSigner(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.setTreeDelegate({
    required SolAddress treeAuthority,
    required SolAddress treeCreator,
    required SolAddress newTreeDelegate,
    required SolAddress merkleTree,
    SolAddress systemProgram = SystemProgramConst.programId,
    List<AccountMeta> anchorRemainingAccounts = const [],
  }) {
    return MetaplexBubblegumProgram(
        keys: [
          treeAuthority.toWritable(),
          treeCreator.toSigner(),
          newTreeDelegate.toReadOnly(),
          merkleTree.toReadOnly(),
          systemProgram.toReadOnly(),
          ...anchorRemainingAccounts
        ],
        programId: MetaplexBubblegumProgramConst.programId,
        layout: const MetaplexBubblegumSetTreeDelegateLayout());
  }
  factory MetaplexBubblegumProgram.transfer({
    required SolAddress treeAuthority,
    required SolAddress leafOwner,
    required SolAddress leafDelegate,
    required SolAddress newLeafOwner,
    required SolAddress merkleTree,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required MetaplexBubblegumTransferLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    List<AccountMeta> anchorRemainingAccounts = const [],
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toReadOnly(),
      leafOwner.toReadOnly(),
      leafDelegate.toReadOnly(),
      newLeafOwner.toReadOnly(),
      merkleTree.toWritable(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.unverifyCollection({
    required SolAddress treeAuthority,
    required SolAddress leafOwner,
    required SolAddress leafDelegate,
    required SolAddress merkleTree,
    required SolAddress payer,
    required SolAddress treeDelegate,
    required SolAddress collectionAuthority,
    required SolAddress collectionAuthorityRecordPda,
    required SolAddress collectionMint,
    required SolAddress collectionMetadata,
    required SolAddress editionAccount,
    required SolAddress bubblegumSigner,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required SolAddress tokenMetadataProgram,
    required MetaplexBubblegumUnverifyCollectionLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    List<AccountMeta> anchorRemainingAccounts = const [],
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toReadOnly(),
      leafOwner.toReadOnly(),
      leafDelegate.toReadOnly(),
      merkleTree.toWritable(),
      payer.toSigner(),
      treeDelegate.toReadOnly(),
      collectionAuthority.toSigner(),
      collectionAuthorityRecordPda.toReadOnly(),
      collectionMint.toReadOnly(),
      collectionMetadata.toWritable(),
      editionAccount.toReadOnly(),
      bubblegumSigner.toReadOnly(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.unverifyCreator({
    required SolAddress treeAuthority,
    required SolAddress leafOwner,
    required SolAddress leafDelegate,
    required SolAddress merkleTree,
    required SolAddress payer,
    required SolAddress creator,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required MetaplexBubblegumUnverifyCreatorLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toReadOnly(),
      leafOwner.toReadOnly(),
      leafDelegate.toReadOnly(),
      merkleTree.toWritable(),
      payer.toSigner(),
      creator.toSigner(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.updateMetadata({
    required SolAddress treeAuthority,
    required SolAddress authority,
    SolAddress? collectionMint,
    SolAddress? collectionMetadata,
    SolAddress? collectionAuthorityRecordPda,
    required SolAddress leafOwner,
    required SolAddress leafDelegate,
    required SolAddress payer,
    required SolAddress merkleTree,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required SolAddress tokenMetadataProgram,
    required MetaplexBubblegumUpdateMetadataLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toReadOnly(),
      authority.toSigner(),
      collectionMint?.toReadOnly() ??
          MetaplexBubblegumProgramConst.programId.toReadOnly(),
      collectionMetadata?.toReadOnly() ??
          MetaplexBubblegumProgramConst.programId.toReadOnly(),
      collectionAuthorityRecordPda?.toReadOnly() ??
          MetaplexBubblegumProgramConst.programId.toReadOnly(),
      leafOwner.toReadOnly(),
      leafDelegate.toReadOnly(),
      payer.toSigner(),
      merkleTree.toWritable(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.verifyCollection({
    required SolAddress treeAuthority,
    required SolAddress leafOwner,
    required SolAddress leafDelegate,
    required SolAddress merkleTree,
    required SolAddress payer,
    required SolAddress treeDelegate,
    required SolAddress collectionAuthority,
    required SolAddress collectionAuthorityRecordPda,
    required SolAddress collectionMint,
    required SolAddress collectionMetadata,
    required SolAddress editionAccount,
    required SolAddress bubblegumSigner,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required SolAddress tokenMetadataProgram,
    required MetaplexBubblegumVerifyCollectionLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toReadOnly(),
      leafOwner.toReadOnly(),
      leafDelegate.toReadOnly(),
      merkleTree.toWritable(),
      payer.toSigner(),
      treeDelegate.toReadOnly(),
      collectionAuthority.toSigner(),
      collectionAuthorityRecordPda.toReadOnly(),
      collectionMint.toReadOnly(),
      collectionMetadata.toWritable(),
      editionAccount.toReadOnly(),
      bubblegumSigner.toReadOnly(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.verifyCreator({
    required SolAddress treeAuthority,
    required SolAddress leafOwner,
    required SolAddress leafDelegate,
    required SolAddress merkleTree,
    required SolAddress payer,
    required SolAddress creator,
    required SolAddress logWrapper,
    required SolAddress compressionProgram,
    required MetaplexBubblegumVerifyCreatorLayout layout,
    List<AccountMeta> anchorRemainingAccounts = const [],
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexBubblegumProgram(keys: [
      treeAuthority.toReadOnly(),
      leafOwner.toReadOnly(),
      leafDelegate.toReadOnly(),
      merkleTree.toWritable(),
      payer.toSigner(),
      creator.toSigner(),
      logWrapper.toReadOnly(),
      compressionProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      ...anchorRemainingAccounts
    ], programId: MetaplexBubblegumProgramConst.programId, layout: layout);
  }
  factory MetaplexBubblegumProgram.verifyLeaf({
    required SolAddress merkleTree,
    required MetaplexBubblegumVerifyLeafLayout layout,
    SolAddress programId = MetaplexBubblegumProgramConst.compressionProgram,
    List<AccountMeta> anchorRemainingAccounts = const [],
  }) {
    return MetaplexBubblegumProgram(
        keys: [merkleTree.toReadOnly(), ...anchorRemainingAccounts],
        programId: programId,
        layout: layout);
  }
}
