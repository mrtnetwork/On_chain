import 'package:on_chain/solana/src/borsh_serialization/core/program_layout.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/metaplex/hydra/layouts/layouts.dart';
import 'package:on_chain/solana/src/instructions/spl_token/constant.dart';
import 'package:on_chain/solana/src/instructions/system/constant.dart';
import 'package:on_chain/solana/src/models/models.dart';

import 'constant.dart';

class MetaplexHydraProgram extends TransactionInstruction {
  MetaplexHydraProgram({
    required super.keys,
    required super.programId,
    required ProgramLayout layout,
  }) : super(data: layout.toBytes());

  factory MetaplexHydraProgram.addMemberNft(
      {required SolAddress authority,
      required SolAddress fanout,
      required SolAddress membershipAccount,
      required SolAddress mint,
      required SolAddress metadata,
      required MetaplexHydraAddMemberNftLayout layout,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexHydraProgram(keys: [
      authority.toSignerAndWritable(),
      fanout.toWritable(),
      membershipAccount.toWritable(),
      mint.toReadOnly(),
      metadata.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
      tokenProgram.toReadOnly(),
    ], programId: MetaplexHydraProgramConst.programId, layout: layout);
  }
  factory MetaplexHydraProgram.addMemberWallet(
      {required SolAddress authority,
      required SolAddress member,
      required SolAddress fanout,
      required SolAddress membershipAccount,
      required MetaplexHydraAddMemberWalletLayout layout,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexHydraProgram(keys: [
      authority.toSignerAndWritable(),
      member.toReadOnly(),
      fanout.toWritable(),
      membershipAccount.toWritable(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
      tokenProgram.toReadOnly(),
    ], programId: MetaplexHydraProgramConst.programId, layout: layout);
  }
  factory MetaplexHydraProgram.distributeNft(
      {required SolAddress payer,
      required SolAddress member,
      required SolAddress membershipMintTokenAccount,
      required SolAddress membershipKey,
      required SolAddress membershipVoucher,
      required SolAddress fanout,
      required SolAddress holdingAccount,
      required SolAddress fanoutForMint,
      required SolAddress fanoutForMintMembershipVoucher,
      required SolAddress fanoutMint,
      required SolAddress fanoutMintMemberTokenAccount,
      required MetaplexHydraDistributeNftLayout layout,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexHydraProgram(keys: [
      payer.toSigner(),
      member.toWritable(),
      membershipMintTokenAccount.toWritable(),
      membershipKey.toReadOnly(),
      membershipVoucher.toWritable(),
      fanout.toWritable(),
      holdingAccount.toWritable(),
      fanoutForMint.toWritable(),
      fanoutForMintMembershipVoucher.toWritable(),
      fanoutMint.toReadOnly(),
      fanoutMintMemberTokenAccount.toWritable(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
      tokenProgram.toReadOnly(),
    ], programId: MetaplexHydraProgramConst.programId, layout: layout);
  }
  factory MetaplexHydraProgram.distributeToken(
      {required SolAddress payer,
      required SolAddress member,
      required SolAddress membershipMintTokenAccount,
      required SolAddress membershipVoucher,
      required SolAddress fanout,
      required SolAddress holdingAccount,
      required SolAddress fanoutForMint,
      required SolAddress fanoutForMintMembershipVoucher,
      required SolAddress fanoutMint,
      required SolAddress fanoutMintMemberTokenAccount,
      required SolAddress membershipMint,
      required SolAddress memberStakeAccount,
      required MetaplexHydraDistributeTokenLayout layout,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexHydraProgram(keys: [
      payer.toSigner(),
      member.toWritable(),
      membershipMintTokenAccount.toWritable(),
      membershipVoucher.toWritable(),
      fanout.toWritable(),
      holdingAccount.toWritable(),
      fanoutForMint.toWritable(),
      fanoutForMintMembershipVoucher.toWritable(),
      fanoutMint.toReadOnly(),
      fanoutMintMemberTokenAccount.toWritable(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
      tokenProgram.toReadOnly(),
      membershipMint.toWritable(),
      memberStakeAccount.toWritable(),
    ], programId: MetaplexHydraProgramConst.programId, layout: layout);
  }
  factory MetaplexHydraProgram.distributeWallet(
      {required SolAddress payer,
      required SolAddress member,
      required SolAddress membershipVoucher,
      required SolAddress fanout,
      required SolAddress holdingAccount,
      required SolAddress fanoutForMint,
      required SolAddress fanoutForMintMembershipVoucher,
      required SolAddress fanoutMint,
      required SolAddress fanoutMintMemberTokenAccount,
      required MetaplexHydraDistributeWalletLayout layout,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexHydraProgram(keys: [
      payer.toSigner(),
      member.toWritable(),
      membershipVoucher.toWritable(),
      fanout.toWritable(),
      holdingAccount.toWritable(),
      fanoutForMint.toWritable(),
      fanoutForMintMembershipVoucher.toWritable(),
      fanoutMint.toReadOnly(),
      fanoutMintMemberTokenAccount.toWritable(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
      tokenProgram.toReadOnly(),
    ], programId: MetaplexHydraProgramConst.programId, layout: layout);
  }
  factory MetaplexHydraProgram.init(
      {required SolAddress authority,
      required SolAddress fanout,
      required SolAddress holdingAccount,
      required SolAddress membershipMint,
      required MetaplexHydraInitLayout layout,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexHydraProgram(keys: [
      authority.toSignerAndWritable(),
      fanout.toWritable(),
      holdingAccount.toWritable(),
      systemProgram.toReadOnly(),
      membershipMint.toWritable(),
      rent.toReadOnly(),
      tokenProgram.toReadOnly(),
    ], programId: MetaplexHydraProgramConst.programId, layout: layout);
  }
  factory MetaplexHydraProgram.initForMint(
      {required SolAddress authority,
      required SolAddress fanout,
      required SolAddress fanoutForMint,
      required SolAddress mintHoldingAccount,
      required SolAddress mint,
      required MetaplexHydraInitForMintLayout layout,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexHydraProgram(keys: [
      authority.toSignerAndWritable(),
      fanout.toWritable(),
      fanoutForMint.toWritable(),
      mintHoldingAccount.toWritable(),
      mint.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly(),
    ], programId: MetaplexHydraProgramConst.programId, layout: layout);
  }
  factory MetaplexHydraProgram.removeMember(
      {required SolAddress authority,
      required SolAddress member,
      required SolAddress fanout,
      required SolAddress membershipAccount,
      required SolAddress destination}) {
    return MetaplexHydraProgram(
        keys: [
          authority.toSignerAndWritable(),
          member.toReadOnly(),
          fanout.toWritable(),
          membershipAccount.toWritable(),
          destination.toWritable(),
        ],
        programId: MetaplexHydraProgramConst.programId,
        layout: const MetaplexHydraRemoveMemberLayout());
  }
  factory MetaplexHydraProgram.setForTokenMemberStake(
      {required SolAddress authority,
      required SolAddress member,
      required SolAddress fanout,
      required SolAddress membershipVoucher,
      required SolAddress membershipMint,
      required SolAddress membershipMintTokenAccount,
      required SolAddress memberStakeAccount,
      required MetaplexHydraSetForTokenMemberStakeLayout layout,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexHydraProgram(keys: [
      authority.toSignerAndWritable(),
      member.toReadOnly(),
      fanout.toWritable(),
      membershipVoucher.toWritable(),
      membershipMint.toWritable(),
      membershipMintTokenAccount.toWritable(),
      memberStakeAccount.toWritable(),
      systemProgram.toReadOnly(),
      tokenProgram.toReadOnly(),
    ], programId: MetaplexHydraProgramConst.programId, layout: layout);
  }
  factory MetaplexHydraProgram.setTokenMemberStake(
      {required SolAddress member,
      required SolAddress fanout,
      required SolAddress membershipVoucher,
      required SolAddress membershipMint,
      required SolAddress membershipMintTokenAccount,
      required SolAddress memberStakeAccount,
      required MetaplexHydraSetTokenMemberStakeLayout layout,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexHydraProgram(keys: [
      member.toSignerAndWritable(),
      fanout.toWritable(),
      membershipVoucher.toWritable(),
      membershipMint.toWritable(),
      membershipMintTokenAccount.toWritable(),
      memberStakeAccount.toWritable(),
      systemProgram.toReadOnly(),
      tokenProgram.toReadOnly()
    ], programId: MetaplexHydraProgramConst.programId, layout: layout);
  }
  factory MetaplexHydraProgram.signMetadata({
    required SolAddress authority,
    required SolAddress fanout,
    required SolAddress holdingAccount,
    required SolAddress metadata,
    SolAddress tokenMetadataProgram = SPLTokenProgramConst.metaDataProgramId,
  }) {
    return MetaplexHydraProgram(
        keys: [
          authority.toSignerAndWritable(),
          fanout.toReadOnly(),
          holdingAccount.toReadOnly(),
          metadata.toWritable(),
          tokenMetadataProgram.toReadOnly()
        ],
        programId: MetaplexHydraProgramConst.programId,
        layout: const MetaplexHydraSignMetadataLayout());
  }
  factory MetaplexHydraProgram.transferShares({
    required SolAddress authority,
    required SolAddress fromMember,
    required SolAddress toMember,
    required SolAddress fanout,
    required SolAddress fromMembershipAccount,
    required SolAddress toMembershipAccount,
    required MetaplexHydraTransferSharesLayout layout,
  }) {
    return MetaplexHydraProgram(keys: [
      authority.toSigner(),
      fromMember.toReadOnly(),
      toMember.toReadOnly(),
      fanout.toWritable(),
      fromMembershipAccount.toWritable(),
      toMembershipAccount.toWritable(),
    ], programId: MetaplexHydraProgramConst.programId, layout: layout);
  }
  factory MetaplexHydraProgram.unstake(
      {required SolAddress member,
      required SolAddress fanout,
      required SolAddress membershipVoucher,
      required SolAddress membershipMint,
      required SolAddress membershipMintTokenAccount,
      required SolAddress memberStakeAccount,
      required SolAddress instructions,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId}) {
    return MetaplexHydraProgram(
        keys: [
          member.toSignerAndWritable(),
          fanout.toWritable(),
          membershipVoucher.toWritable(),
          membershipMint.toWritable(),
          membershipMintTokenAccount.toWritable(),
          memberStakeAccount.toWritable(),
          systemProgram.toReadOnly(),
          tokenProgram.toReadOnly(),
          instructions.toReadOnly(),
        ],
        programId: MetaplexHydraProgramConst.programId,
        layout: const MetaplexHydraUnstakeLayout());
  }
}
