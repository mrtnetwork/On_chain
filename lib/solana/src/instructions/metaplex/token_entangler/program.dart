import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/associated_token_account/constant.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/models.dart';

class MetaplexTokenEntanglerProgram extends TransactionInstruction {
  MetaplexTokenEntanglerProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);

  factory MetaplexTokenEntanglerProgram.createEntangledPair(
      {required SolAddress treasuryMint,
      required SolAddress payer,
      required SolAddress transferAuthority,
      required SolAddress authority,
      required SolAddress mintA,
      required SolAddress metadataA,
      required SolAddress editionA,
      required SolAddress mintB,
      required SolAddress metadataB,
      required SolAddress editionB,
      required SolAddress tokenB,
      required SolAddress tokenAEscrow,
      required SolAddress tokenBEscrow,
      required SolAddress entangledPair,
      required SolAddress reverseEntangledPair,
      required MetaplexTokenEntanglerCreateEntangledPairLayout layout,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexTokenEntanglerProgram(keys: [
      treasuryMint.toReadOnly(),
      payer.toSignerAndWritable(),
      transferAuthority.toSigner(),
      authority.toReadOnly(),
      mintA.toReadOnly(),
      metadataA.toReadOnly(),
      editionA.toReadOnly(),
      mintB.toReadOnly(),
      metadataB.toReadOnly(),
      editionB.toReadOnly(),
      tokenB.toWritable(),
      tokenAEscrow.toWritable(),
      tokenBEscrow.toWritable(),
      entangledPair.toWritable(),
      reverseEntangledPair.toWritable(),
      tokenProgram.toReadOnly(),
      systemProgram.toReadOnly(),
      rent.toReadOnly()
    ], programId: MetaplexTokenEntanglerProgramConst.programId, layout: layout);
  }
  factory MetaplexTokenEntanglerProgram.swap(
      {required SolAddress treasuryMint,
      required SolAddress payer,
      required SolAddress paymentAccount,
      required SolAddress paymentTransferAuthority,
      required SolAddress token,
      required SolAddress tokenMint,
      required SolAddress replacementTokenMetadata,
      required SolAddress replacementTokenMint,
      required SolAddress replacementToken,
      required SolAddress transferAuthority,
      required SolAddress tokenAEscrow,
      required SolAddress tokenBEscrow,
      required SolAddress entangledPair,
      SolAddress tokenProgram = SPLTokenProgramConst.tokenProgramId,
      SolAddress systemProgram = SystemProgramConst.programId,
      SolAddress associatedTokenProgramId =
          AssociatedTokenAccountProgramConst.associatedTokenProgramId,
      SolAddress rent = SystemProgramConst.sysvarRentPubkey}) {
    return MetaplexTokenEntanglerProgram(
        keys: [
          treasuryMint.toReadOnly(),
          payer.toSigner(),
          paymentAccount.toWritable(),
          paymentTransferAuthority.toReadOnly(),
          token.toWritable(),
          tokenMint.toReadOnly(),
          replacementTokenMetadata.toReadOnly(),
          replacementTokenMint.toReadOnly(),
          replacementToken.toWritable(),
          transferAuthority.toSigner(),
          tokenAEscrow.toWritable(),
          tokenBEscrow.toWritable(),
          entangledPair.toWritable(),
          tokenProgram.toReadOnly(),
          systemProgram.toReadOnly(),
          associatedTokenProgramId.toReadOnly(),
          rent.toReadOnly()
        ],
        programId: MetaplexTokenEntanglerProgramConst.programId,
        layout: const MetaplexTokenEntanglerSwapLayout());
  }
  factory MetaplexTokenEntanglerProgram.updateEntangledPair(
      {required SolAddress authority,
      required SolAddress newAuthority,
      required SolAddress entangledPair,
      required MetaplexTokenEntanglerUpdateEntangledPairLayout layout}) {
    return MetaplexTokenEntanglerProgram(keys: [
      authority.toSigner(),
      newAuthority.toReadOnly(),
      entangledPair.toWritable(),
    ], programId: MetaplexTokenEntanglerProgramConst.programId, layout: layout);
  }
}
