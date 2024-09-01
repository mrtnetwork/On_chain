import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/models.dart';

class MetaplexGumdropProgram extends TransactionInstruction {
  MetaplexGumdropProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, data: layout.toBytes(), programId: programId);

  factory MetaplexGumdropProgram.claim(
      {required SolAddress distributor,
      required SolAddress claimStatus,
      required SolAddress from,
      required SolAddress to,
      required SolAddress temporal,
      required SolAddress payer,
      required MetaplexGumdropClaimLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId}) {
    return MetaplexGumdropProgram(keys: [
      distributor.toWritable(),
      claimStatus.toWritable(),
      from.toWritable(),
      to.toWritable(),
      temporal.toSigner(),
      payer.toSignerAndWritable(),
      systemProgram.toReadOnly(),
      tokenProgram.toReadOnly()
    ], programId: MetaplexGumdropProgramConst.programId, layout: layout);
  }
  factory MetaplexGumdropProgram.claimCandy(
      {required SolAddress distributor,
      required SolAddress distributorWallet,
      required SolAddress claimCount,
      required SolAddress temporal,
      required SolAddress payer,
      required SolAddress candyMachineConfig,
      required SolAddress candyMachine,
      required SolAddress candyMachineWallet,
      required SolAddress candyMachineMint,
      required SolAddress candyMachineMetadata,
      required SolAddress candyMachineMasterEdition,
      required SolAddress tokenMetadataProgram,
      required SolAddress candyMachineProgram,
      required SolAddress clock,
      required MetaplexGumdropClaimCandyLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexGumdropProgram(keys: [
      distributor.toWritable(),
      distributorWallet.toWritable(),
      claimCount.toWritable(),
      temporal.toSigner(),
      payer.toSigner(),
      candyMachineConfig.toReadOnly(),
      candyMachine.toWritable(),
      candyMachineWallet.toWritable(),
      candyMachineMint.toWritable(),
      candyMachineMetadata.toWritable(),
      candyMachineMasterEdition.toWritable(),
      systemProgram.toReadOnly(),
      tokenProgram.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      candyMachineProgram.toReadOnly(),
      rent.toReadOnly(),
      clock.toReadOnly()
    ], programId: MetaplexGumdropProgramConst.programId, layout: layout);
  }

  factory MetaplexGumdropProgram.claimCandyProven(
      {required SolAddress distributor,
      required SolAddress distributorWallet,
      required SolAddress claimProof,
      required SolAddress payer,
      required SolAddress candyMachineConfig,
      required SolAddress candyMachine,
      required SolAddress candyMachineWallet,
      required SolAddress candyMachineMint,
      required SolAddress candyMachineMetadata,
      required SolAddress candyMachineMasterEdition,
      required SolAddress tokenMetadataProgram,
      required SolAddress candyMachineProgram,
      required SolAddress clock,
      required MetaplexGumdropClaimCandyProvenLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexGumdropProgram(keys: [
      distributor.toWritable(),
      distributorWallet.toWritable(),
      claimProof.toWritable(),
      payer.toSigner(),
      candyMachineConfig.toReadOnly(),
      candyMachine.toWritable(),
      candyMachineWallet.toWritable(),
      candyMachineMint.toWritable(),
      candyMachineMetadata.toWritable(),
      candyMachineMasterEdition.toWritable(),
      systemProgram.toReadOnly(),
      tokenProgram.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      candyMachineProgram.toReadOnly(),
      rent.toReadOnly(),
      clock.toReadOnly()
    ], programId: MetaplexGumdropProgramConst.programId, layout: layout);
  }
  factory MetaplexGumdropProgram.claimEdition(
      {required SolAddress distributor,
      required SolAddress claimCount,
      required SolAddress temporal,
      required SolAddress payer,
      required SolAddress metadataNewMetadata,
      required SolAddress metadataNewEdition,
      required SolAddress metadataMasterEdition,
      required SolAddress metadataNewMint,
      required SolAddress metadataEditionMarkPda,
      required SolAddress metadataNewMintAuthority,
      required SolAddress metadataMasterTokenAccount,
      required SolAddress metadataNewUpdateAuthority,
      required SolAddress metadataMasterMetadata,
      required SolAddress metadataMasterMint,
      required SolAddress tokenMetadataProgram,
      required MetaplexGumdropClaimEditionLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexGumdropProgram(keys: [
      distributor.toWritable(),
      claimCount.toWritable(),
      temporal.toSigner(),
      payer.toSigner(),
      metadataNewMetadata.toWritable(),
      metadataNewEdition.toWritable(),
      metadataMasterEdition.toWritable(),
      metadataNewMint.toWritable(),
      metadataEditionMarkPda.toWritable(),
      metadataNewMintAuthority.toSigner(),
      metadataMasterTokenAccount.toReadOnly(),
      metadataNewUpdateAuthority.toReadOnly(),
      metadataMasterMetadata.toReadOnly(),
      metadataMasterMint.toReadOnly(),
      systemProgram.toReadOnly(),
      tokenProgram.toReadOnly(),
      tokenMetadataProgram.toReadOnly(),
      rent.toReadOnly()
    ], programId: MetaplexGumdropProgramConst.programId, layout: layout);
  }
  factory MetaplexGumdropProgram.closeDistributor({
    required SolAddress base,
    required SolAddress distributor,
    required SolAddress distributorWallet,
    required SolAddress receiver,
    required MetaplexGumdropCloseDistributorLayout layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexGumdropProgram(keys: [
      base.toSigner(),
      distributor.toWritable(),
      distributorWallet.toWritable(),
      receiver.toReadOnly(),
      systemProgram.toReadOnly(),
      tokenProgram.toReadOnly()
    ], programId: MetaplexGumdropProgramConst.programId, layout: layout);
  }
  factory MetaplexGumdropProgram.closeDistributorTokenAccount({
    required SolAddress base,
    required SolAddress distributor,
    required SolAddress from,
    required SolAddress to,
    required SolAddress receiver,
    required MetaplexGumdropCloseDistributorTokenAccountLayout layout,
    SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexGumdropProgram(keys: [
      base.toSigner(),
      distributor.toReadOnly(),
      from.toWritable(),
      to.toWritable(),
      receiver.toWritable(),
      systemProgram.toReadOnly(),
      tokenProgram.toReadOnly()
    ], programId: MetaplexGumdropProgramConst.programId, layout: layout);
  }
  factory MetaplexGumdropProgram.newDistributor({
    required SolAddress base,
    required SolAddress distributor,
    required SolAddress payer,
    required MetaplexGumdropNewDistributorLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexGumdropProgram(keys: [
      base.toSigner(),
      distributor.toWritable(),
      payer.toSignerAndWritable(),
      systemProgram.toReadOnly()
    ], programId: MetaplexGumdropProgramConst.programId, layout: layout);
  }
  factory MetaplexGumdropProgram.proveClaim({
    required SolAddress distributor,
    required SolAddress claimProof,
    required SolAddress temporal,
    required SolAddress payer,
    required MetaplexGumdropProveClaimLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexGumdropProgram(keys: [
      distributor.toWritable(),
      claimProof.toWritable(),
      temporal.toSigner(),
      payer.toSignerAndWritable(),
      systemProgram.toReadOnly()
    ], programId: MetaplexGumdropProgramConst.programId, layout: layout);
  }
  factory MetaplexGumdropProgram.recoverUpdateAuthority({
    required SolAddress base,
    required SolAddress distributor,
    required SolAddress distributorWallet,
    required SolAddress newUpdateAuthority,
    required SolAddress metadata,
    required SolAddress tokenMetadataProgram,
    required MetaplexGumdropRecoverUpdateAuthorityLayout layout,
    SolAddress systemProgram = SystemProgramConst.programId,
  }) {
    return MetaplexGumdropProgram(keys: [
      base.toSigner(),
      distributor.toReadOnly(),
      distributorWallet.toReadOnly(),
      newUpdateAuthority.toReadOnly(),
      metadata.toWritable(),
      systemProgram.toReadOnly(),
      tokenMetadataProgram.toReadOnly()
    ], programId: MetaplexGumdropProgramConst.programId, layout: layout);
  }
}
