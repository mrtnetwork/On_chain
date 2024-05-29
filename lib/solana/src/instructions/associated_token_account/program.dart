import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/instructions.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/models/models.dart';

import 'constant.dart';

class AssociatedTokenAccountProgram extends TransactionInstruction {
  AssociatedTokenAccountProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);
  factory AssociatedTokenAccountProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId =
        AssociatedTokenAccountProgramConst.associatedTokenProgramId,
  }) {
    return AssociatedTokenAccountProgram(
        layout: AssociatedTokenAccountProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Factory method for creating an associated token account
  static AssociatedTokenAccountProgram _associatedTokenAccount({
    required SolAddress payer,
    required SolAddress associatedToken,
    required SolAddress owner,
    required SolAddress mint,
    required ProgramLayout layout,
    SolAddress programId =
        AssociatedTokenAccountProgramConst.associatedTokenProgramId,
    SolAddress tokenProgramId = SPLTokenProgramConst.tokenProgramId,
  }) {
    return AssociatedTokenAccountProgram(
        layout: layout,
        keys: [
          payer.toSignerAndWritable(),
          associatedToken.toWritable(),
          owner.toReadOnly(),
          mint.toReadOnly(),
          SystemProgramConst.programId.toReadOnly(),
          tokenProgramId.toReadOnly(),
        ],
        programId: programId);
  }

  /// Factory method for creating an associated token account
  factory AssociatedTokenAccountProgram.associatedTokenAccount({
    /// Payer of the initialization fees
    required SolAddress payer,

    /// New associated token account
    required SolAddress associatedToken,

    /// Owner of the new account
    required SolAddress owner,

    /// Token mint account
    required SolAddress mint,

    /// SPL Token program account
    SolAddress tokenProgramId = SPLTokenProgramConst.tokenProgramId,

    /// SPL Associated Token program account
    SolAddress associatedTokenProgramId =
        AssociatedTokenAccountProgramConst.associatedTokenProgramId,
  }) {
    return _associatedTokenAccount(
        payer: payer,
        associatedToken: associatedToken,
        owner: owner,
        mint: mint,
        tokenProgramId: tokenProgramId,
        programId: associatedTokenProgramId,
        layout: const AssociatedTokenAccountProgramInitializeLayout());
  }

  /// Factory method for creating an associated token account idempotent
  factory AssociatedTokenAccountProgram.associatedTokenAccountIdempotent({
    /// Payer of the initialization fees
    required SolAddress payer,

    /// New associated token account
    required SolAddress associatedToken,

    /// Owner of the new account
    required SolAddress owner,

    /// Token mint account
    required SolAddress mint,

    /// SPL Token program account
    SolAddress tokenProgramId = SPLTokenProgramConst.tokenProgramId,

    /// SPL Associated Token program account
    SolAddress associatedTokenProgramId =
        AssociatedTokenAccountProgramConst.associatedTokenProgramId,
  }) {
    return _associatedTokenAccount(
        payer: payer,
        associatedToken: associatedToken,
        owner: owner,
        mint: mint,
        tokenProgramId: tokenProgramId,
        programId: associatedTokenProgramId,
        layout: const AssociatedTokenAccountProgramIdempotentLayout());
  }

  /// Factory method for recovering a nested associated token account
  factory AssociatedTokenAccountProgram.recoverNested({
    /// Nested associated token account
    required SolAddress nestedAssociatedToken,

    /// Token mint for the nested associated token account
    required SolAddress nestedMint,

    /// Wallet's associated token account
    required SolAddress destinationAssociatedToken,

    /// Owner associated token account address
    required SolAddress ownerAssociatedToken,

    /// Token mint for the owner associated token account
    required SolAddress ownerMint,

    /// Wallet address for the owner associated token account
    required SolAddress owner,

    /// SPL Token program account
    SolAddress tokenProgramId = SPLTokenProgramConst.tokenProgramId,

    /// SPL Associated Token program account
    SolAddress associatedTokenProgramId =
        AssociatedTokenAccountProgramConst.associatedTokenProgramId,
  }) {
    return AssociatedTokenAccountProgram(
        keys: [
          nestedAssociatedToken.toWritable(),
          nestedMint.toReadOnly(),
          destinationAssociatedToken.toWritable(),
          ownerAssociatedToken.toWritable(),
          ownerMint.toReadOnly(),
          owner.toSignerAndWritable(),
          tokenProgramId.toReadOnly(),
        ],
        programId: associatedTokenProgramId,
        layout: const AssociatedTokenAccountProgramRecoverNestedLayout());
  }
}
