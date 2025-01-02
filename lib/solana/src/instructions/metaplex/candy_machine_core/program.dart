import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/layouts.dart';
import 'package:on_chain/solana/src/instructions/spl_token/constant.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/models.dart';
import 'constant.dart';

class MetaplexCandyMachineCoreProgram extends TransactionInstruction {
  MetaplexCandyMachineCoreProgram({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());
  factory MetaplexCandyMachineCoreProgram.addConfigLines(
      {required SolAddress candyMachine,
      required SolAddress authority,
      required MetaplexCandyMachineAddConfigLinesLayout layout,
      SolAddress programId =
          MetaplexCandyMachineCoreProgramConst.candyMachineV3programId}) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyMachine.toWritable(),
      authority.toSigner(),
    ], programId: programId, layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.createCandyGuard(
      {required SolAddress candyGuard,
      required SolAddress base,
      required SolAddress authority,
      required SolAddress payer,
      required MetaplexCandyMachineCreateCandyGuardLayout layout,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress programId =
          MetaplexCandyMachineCoreProgramConst.candyGuardProgramId}) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyGuard.toWritable(),
      base.toSigner(),
      authority.toReadOnly(),
      payer.toSignerAndWritable(),
      systemProgram.toReadOnly(),
    ], programId: programId, layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.deleteCandyGuard(
      {required SolAddress candyGuard,
      required SolAddress authority,
      SolAddress programId =
          MetaplexCandyMachineCoreProgramConst.candyGuardProgramId}) {
    return MetaplexCandyMachineCoreProgram(
        keys: [
          candyGuard.toWritable(),
          authority.toSignerAndWritable(),
        ],
        programId: programId,
        layout: const MetaplexCandyMachineDeleteCandyGuardLayout());
  }
  factory MetaplexCandyMachineCoreProgram.deleteCandyMachine(
      {required SolAddress candyMachine,
      required SolAddress authority,
      SolAddress programId =
          MetaplexCandyMachineCoreProgramConst.candyMachineV3programId}) {
    return MetaplexCandyMachineCoreProgram(
        keys: [
          candyMachine.toWritable(),
          authority.toSignerAndWritable(),
        ],
        programId: programId,
        layout: const MetaplexCandyMachineDeleteCandyMachineLayout());
  }
  factory MetaplexCandyMachineCoreProgram.initializeCandyMachine({
    required SolAddress candyMachine,
    required SolAddress authorityPda,
    required SolAddress authority,
    required SolAddress payer,
    required SolAddress collectionMetadata,
    required SolAddress collectionMint,
    required SolAddress collectionMasterEdition,
    required SolAddress collectionUpdateAuthority,
    required SolAddress collectionAuthorityRecord,
    required SolAddress tokenMetadataProgram,
    required MetaplexCandyMachineInitializeCandyMachineLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyMachineV3programId,
  }) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyMachine.toWritable(),
      authorityPda.toWritable(),
      authority.toReadOnly(),
      payer.toSigner(),
      collectionMetadata.toReadOnly(),
      collectionMint.toReadOnly(),
      collectionMasterEdition.toReadOnly(),
      collectionUpdateAuthority.toSignerAndWritable(),
      collectionAuthorityRecord.toWritable(),
      tokenMetadataProgram.toReadOnly(),
      systemProgram.toReadOnly(),
    ], programId: programId, layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.initializeCandyMachineV2({
    required SolAddress candyMachine,
    required SolAddress authorityPda,
    required SolAddress authority,
    required SolAddress payer,
    required SolAddress collectionMetadata,
    required SolAddress collectionMint,
    required SolAddress collectionMasterEdition,
    required SolAddress collectionUpdateAuthority,
    required SolAddress collectionDelegateRecord,
    required SolAddress tokenMetadataProgram,
    required SolAddress sysvarInstructions,
    required MetaplexCandyMachineInitializeCandyMachineV2Layout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyMachineV3programId,
    SolAddress? ruleSet,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyMachine.toWritable(),
      authorityPda.toWritable(),
      authority.toReadOnly(),
      payer.toSignerAndWritable(),
      ruleSet?.toReadOnly() ?? programId.toReadOnly(),
      collectionMetadata.toWritable(),
      collectionMint.toReadOnly(),
      collectionMasterEdition.toReadOnly(),
      collectionUpdateAuthority.toSignerAndWritable(),
      collectionDelegateRecord.toWritable(),
      tokenMetadataProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      authorizationRulesProgram?.toReadOnly() ?? programId.toReadOnly(),
      authorizationRules?.toReadOnly() ?? programId.toReadOnly()
    ], programId: programId, layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.mintFromCandyMachine({
    required SolAddress candyMachine,
    required SolAddress authorityPda,
    required SolAddress mintAuthority,
    required SolAddress payer,
    required SolAddress nftMint,
    required SolAddress nftMintAuthority,
    required SolAddress nftMetadata,
    required SolAddress nftMasterEdition,
    required SolAddress collectionAuthorityRecord,
    required SolAddress collectionMint,
    required SolAddress collectionMetadata,
    required SolAddress collectionMasterEdition,
    required SolAddress collectionUpdateAuthority,
    required SolAddress tokenMetadataProgram,
    required SolAddress recentSlothashes,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyMachineV3programId,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
  }) {
    return MetaplexCandyMachineCoreProgram(
        keys: [
          candyMachine.toWritable(),
          authorityPda.toWritable(),
          mintAuthority.toSigner(),
          payer.toSignerAndWritable(),
          nftMint.toWritable(),
          nftMintAuthority.toSigner(),
          nftMetadata.toWritable(),
          nftMasterEdition.toWritable(),
          collectionAuthorityRecord.toReadOnly(),
          collectionMint.toReadOnly(),
          collectionMetadata.toWritable(),
          collectionMasterEdition.toReadOnly(),
          collectionUpdateAuthority.toReadOnly(),
          tokenMetadataProgram.toReadOnly(),
          tokenProgram.toReadOnly(),
          systemProgram.toReadOnly(),
          recentSlothashes.toReadOnly()
        ],
        programId: programId,
        layout: const MetaplexCandyMachineMintFromCandyMachineLayout());
  }
  factory MetaplexCandyMachineCoreProgram.mintFromCandyMachineV2({
    required SolAddress candyMachine,
    required SolAddress authorityPda,
    required SolAddress mintAuthority,
    required SolAddress payer,
    required SolAddress nftOwner,
    required SolAddress nftMint,
    required SolAddress nftMintAuthority,
    required SolAddress nftMetadata,
    required SolAddress nftMasterEdition,
    required SolAddress collectionDelegateRecord,
    required SolAddress collectionMint,
    required SolAddress collectionMetadata,
    required SolAddress collectionMasterEdition,
    required SolAddress collectionUpdateAuthority,
    required SolAddress tokenMetadataProgram,
    required SolAddress splTokenProgram,
    required SolAddress sysvarInstructions,
    required SolAddress recentSlothashes,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyMachineV3programId,
    SolAddress? token,
    SolAddress? tokenRecord,
    SolAddress? splAtaProgram,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexCandyMachineCoreProgram(
        keys: [
          candyMachine.toWritable(),
          authorityPda.toWritable(),
          mintAuthority.toSigner(),
          payer.toSignerAndWritable(),
          nftOwner.toReadOnly(),
          nftMint.toWritable(),
          nftMintAuthority.toSigner(),
          nftMetadata.toWritable(),
          nftMasterEdition.toWritable(),
          token?.toWritable() ?? programId.toReadOnly(),
          tokenRecord?.toWritable() ?? programId.toReadOnly(),
          collectionDelegateRecord.toReadOnly(),
          collectionMint.toReadOnly(),
          collectionMetadata.toWritable(),
          collectionMasterEdition.toReadOnly(),
          collectionUpdateAuthority.toReadOnly(),
          tokenMetadataProgram.toReadOnly(),
          splTokenProgram.toReadOnly(),
          splAtaProgram?.toReadOnly() ?? programId.toReadOnly(),
          systemProgram.toReadOnly(),
          sysvarInstructions.toReadOnly(),
          recentSlothashes.toReadOnly(),
          authorizationRulesProgram?.toReadOnly() ?? programId.toReadOnly(),
          authorizationRules?.toReadOnly() ?? programId.toReadOnly()
        ],
        programId: programId,
        layout: const MetaplexCandyMachineMintFromCandyMachineV2Layout());
  }
  factory MetaplexCandyMachineCoreProgram.mint({
    required SolAddress candyGuard,
    required SolAddress candyMachineProgram,
    required SolAddress candyMachine,
    required SolAddress candyMachineAuthorityPda,
    required SolAddress payer,
    required SolAddress nftMetadata,
    required SolAddress nftMint,
    required SolAddress nftMintAuthority,
    required SolAddress nftMasterEdition,
    required SolAddress collectionAuthorityRecord,
    required SolAddress collectionMint,
    required SolAddress collectionMetadata,
    required SolAddress collectionMasterEdition,
    required SolAddress collectionUpdateAuthority,
    required SolAddress tokenMetadataProgram,
    required SolAddress recentSlothashes,
    required SolAddress instructionSysvarAccount,
    required MetaplexCandyMachineMintLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyGuardProgramId,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
  }) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyGuard.toReadOnly(),
      candyMachineProgram.toReadOnly(),
      candyMachine.toWritable(),
      candyMachineAuthorityPda.toWritable(),
      payer.toSignerAndWritable(),
      nftMetadata.toWritable(),
      nftMint.toWritable(),
      nftMintAuthority.toSigner(),
      nftMasterEdition.toWritable(),
      collectionAuthorityRecord.toReadOnly(),
      collectionMint.toReadOnly(),
      collectionMetadata.toWritable(),
      collectionMasterEdition.toReadOnly(),
      collectionUpdateAuthority.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      recentSlothashes.toReadOnly(),
      instructionSysvarAccount.toReadOnly()
    ], programId: programId, layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.mintV2({
    required SolAddress candyGuard,
    required SolAddress candyMachineProgram,
    required SolAddress candyMachine,
    required SolAddress candyMachineAuthorityPda,
    required SolAddress payer,
    required SolAddress minter,
    required SolAddress nftMint,
    required SolAddress nftMintAuthority,
    required SolAddress nftMetadata,
    required SolAddress nftMasterEdition,
    required SolAddress collectionDelegateRecord,
    required SolAddress collectionMint,
    required SolAddress collectionMetadata,
    required SolAddress collectionMasterEdition,
    required SolAddress collectionUpdateAuthority,
    required SolAddress tokenMetadataProgram,
    required SolAddress splTokenProgram,
    required SolAddress sysvarInstructions,
    required SolAddress recentSlothashes,
    required MetaplexCandyMachineMintV2Layout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyGuardProgramId,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress? token,
    SolAddress? tokenRecord,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
    SolAddress? splAtaProgram,
  }) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyGuard.toReadOnly(),
      candyMachineProgram.toReadOnly(),
      candyMachine.toWritable(),
      candyMachineAuthorityPda.toWritable(),
      payer.toSignerAndWritable(),
      minter.toSignerAndWritable(),
      nftMint.toWritable(),
      nftMintAuthority.toSigner(),
      nftMetadata.toWritable(),
      nftMasterEdition.toWritable(),
      token?.toWritable() ?? programId.toReadOnly(),
      tokenRecord?.toWritable() ?? programId.toReadOnly(),
      collectionDelegateRecord.toReadOnly(),
      collectionMint.toReadOnly(),
      collectionMetadata.toWritable(),
      collectionMasterEdition.toReadOnly(),
      collectionUpdateAuthority.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      splTokenProgram.toReadOnly(),
      splAtaProgram?.toReadOnly() ?? programId.toReadOnly(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      recentSlothashes.toReadOnly(),
      authorizationRulesProgram?.toReadOnly() ?? programId.toReadOnly(),
      authorizationRules?.toReadOnly() ?? programId.toReadOnly()
    ], programId: programId, layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.route({
    required SolAddress candyGuard,
    required SolAddress candyMachine,
    required SolAddress payer,
    required MetaplexCandyMachineRouteLayout layout,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyGuardProgramId,
  }) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyGuard.toReadOnly(),
      candyMachine.toWritable(),
      payer.toSignerAndWritable()
    ], programId: programId, layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.setCandyGuardAuthority({
    required SolAddress candyGuard,
    required SolAddress authority,
    required MetaplexCandyMachineSetCandyGuardAuthorityLayout layout,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyGuardProgramId,
  }) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyGuard.toWritable(),
      authority.toSigner(),
    ], programId: programId, layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.setCandyMachineAuthority({
    required SolAddress candyMachine,
    required SolAddress authority,
    required MetaplexCandyMachineSetCandyMachineAuthorityLayout layout,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyMachineV3programId,
  }) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyMachine.toWritable(),
      authority.toSigner(),
    ], programId: programId, layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.setCollection({
    required SolAddress candyMachine,
    required SolAddress authority,
    required SolAddress authorityPda,
    required SolAddress payer,
    required SolAddress collectionMint,
    required SolAddress collectionMetadata,
    required SolAddress collectionAuthorityRecord,
    required SolAddress newCollectionUpdateAuthority,
    required SolAddress newCollectionMetadata,
    required SolAddress newCollectionMint,
    required SolAddress newCollectionMasterEdition,
    required SolAddress newCollectionAuthorityRecord,
    required SolAddress tokenMetadataProgram,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyMachineV3programId,
  }) {
    return MetaplexCandyMachineCoreProgram(
        keys: [
          candyMachine.toWritable(),
          authority.toSigner(),
          authorityPda.toWritable(),
          payer.toSigner(),
          collectionMint.toReadOnly(),
          collectionMetadata.toReadOnly(),
          collectionAuthorityRecord.toWritable(),
          newCollectionUpdateAuthority.toSignerAndWritable(),
          newCollectionMetadata.toReadOnly(),
          newCollectionMint.toReadOnly(),
          newCollectionMasterEdition.toReadOnly(),
          newCollectionAuthorityRecord.toWritable(),
          tokenMetadataProgram.toReadOnly(),
          systemProgram.toReadOnly(),
        ],
        programId: programId,
        layout: const MetaplexCandyMachineSetCollectionLayout());
  }
  factory MetaplexCandyMachineCoreProgram.setCollectionV2({
    required SolAddress candyMachine,
    required SolAddress authority,
    required SolAddress authorityPda,
    required SolAddress payer,
    required SolAddress collectionUpdateAuthority,
    required SolAddress collectionMint,
    required SolAddress collectionMetadata,
    required SolAddress collectionDelegateRecord,
    required SolAddress newCollectionUpdateAuthority,
    required SolAddress newCollectionMint,
    required SolAddress newCollectionMetadata,
    required SolAddress newCollectionMasterEdition,
    required SolAddress newCollectionDelegateRecord,
    required SolAddress tokenMetadataProgram,
    required SolAddress sysvarInstructions,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyMachineV3programId,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexCandyMachineCoreProgram(
        keys: [
          candyMachine.toWritable(),
          authority.toSigner(),
          authorityPda.toWritable(),
          payer.toSignerAndWritable(),
          collectionUpdateAuthority.toReadOnly(),
          collectionMint.toReadOnly(),
          collectionMetadata.toWritable(),
          collectionDelegateRecord.toWritable(),
          newCollectionUpdateAuthority.toSigner(),
          newCollectionMint.toReadOnly(),
          newCollectionMetadata.toWritable(),
          newCollectionMasterEdition.toReadOnly(),
          newCollectionDelegateRecord.toWritable(),
          tokenMetadataProgram.toReadOnly(),
          systemProgram.toReadOnly(),
          sysvarInstructions.toReadOnly(),
          authorizationRulesProgram?.toReadOnly() ?? programId.toReadOnly(),
          authorizationRules?.toReadOnly() ?? programId.toReadOnly()
        ],
        programId: programId,
        layout: const MetaplexCandyMachineSetCollectionV2Layout());
  }
  factory MetaplexCandyMachineCoreProgram.setMintAuthority({
    required SolAddress candyMachine,
    required SolAddress authority,
    required SolAddress mintAuthority,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyMachineV3programId,
  }) {
    return MetaplexCandyMachineCoreProgram(
        keys: [
          candyMachine.toWritable(),
          authority.toSigner(),
          mintAuthority.toSigner()
        ],
        programId: programId,
        layout: const MetaplexCandyMachineSetMintAuthorityLayout());
  }
  factory MetaplexCandyMachineCoreProgram.setTokenStandard({
    required SolAddress candyMachine,
    required SolAddress authority,
    required SolAddress authorityPda,
    required SolAddress payer,
    required SolAddress collectionDelegateRecord,
    required SolAddress collectionMint,
    required SolAddress collectionMetadata,
    required SolAddress collectionUpdateAuthority,
    required SolAddress tokenMetadataProgram,
    required SolAddress sysvarInstructions,
    required MetaplexCandyMachineSetTokenStandardLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyMachineV3programId,
    SolAddress? ruleSet,
    SolAddress? collectionAuthorityRecord,
    SolAddress? authorizationRulesProgram,
    SolAddress? authorizationRules,
  }) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyMachine.toWritable(),
      authority.toSigner(),
      authorityPda.toWritable(),
      payer.toSignerAndWritable(),
      ruleSet?.toReadOnly() ?? programId.toReadOnly(),
      collectionDelegateRecord.toWritable(),
      collectionMint.toReadOnly(),
      collectionMetadata.toWritable(),
      collectionAuthorityRecord?.toWritable() ?? programId.toReadOnly(),
      collectionUpdateAuthority.toSigner(),
      tokenMetadataProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      sysvarInstructions.toReadOnly(),
      authorizationRulesProgram?.toReadOnly() ?? programId.toReadOnly(),
      authorizationRules?.toReadOnly() ?? programId.toReadOnly()
    ], programId: programId, layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.unwrap({
    required SolAddress candyGuard,
    required SolAddress authority,
    required SolAddress candyMachine,
    required SolAddress candyMachineAuthority,
    required SolAddress candyMachineProgram,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyGuardProgramId,
  }) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyGuard.toReadOnly(),
      authority.toSigner(),
      candyMachine.toWritable(),
      candyMachineAuthority.toSigner(),
      candyMachineProgram.toReadOnly(),
    ], programId: programId, layout: const MetaplexCandyMachineUnwrapLayout());
  }
  factory MetaplexCandyMachineCoreProgram.updateCandyGuard({
    required SolAddress candyGuard,
    required SolAddress authority,
    required SolAddress payer,
    required MetaplexCandyMachineUpdateCandyGuardLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyGuardProgramId,
  }) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyGuard.toWritable(),
      authority.toSigner(),
      payer.toSigner(),
      systemProgram.toReadOnly()
    ], programId: programId, layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.updateCandyMachine({
    required SolAddress candyMachine,
    required SolAddress authority,
    required MetaplexCandyMachineUpdateCandyMachineLayout layout,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyMachineV3programId,
  }) {
    return MetaplexCandyMachineCoreProgram(
        keys: [candyMachine.toWritable(), authority.toSigner()],
        programId: programId,
        layout: layout);
  }
  factory MetaplexCandyMachineCoreProgram.wrap({
    required SolAddress candyGuard,
    required SolAddress authority,
    required SolAddress candyMachine,
    required SolAddress candyMachineProgram,
    required SolAddress candyMachineAuthority,
    SolAddress programId =
        MetaplexCandyMachineCoreProgramConst.candyGuardProgramId,
  }) {
    return MetaplexCandyMachineCoreProgram(keys: [
      candyGuard.toReadOnly(),
      authority.toSigner(),
      candyMachine.toWritable(),
      candyMachineProgram.toReadOnly(),
      candyMachineAuthority.toSigner(),
    ], programId: programId, layout: const MetaplexCandyMachineWrapLayout());
  }
}
