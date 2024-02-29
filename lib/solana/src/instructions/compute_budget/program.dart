import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/layout/program_layouts/core/program_layout.dart';
import 'package:on_chain/solana/src/models/account/account_meta.dart';
import 'package:on_chain/solana/src/instructions/compute_budget/constant.dart';
import 'package:on_chain/solana/src/instructions/compute_budget/layouts/layouts.dart';
import 'package:on_chain/solana/src/models/transaction/instruction.dart';

/// Represents instructions for the ComputeBudget program.
class ComputeBudgetProgram extends TransactionInstruction {
  ComputeBudgetProgram({
    required List<AccountMeta> keys,
    required SolAddress programId,
    required ProgramLayout layout,
  }) : super(keys: keys, layout: layout, programId: programId);

  factory ComputeBudgetProgram.fromBytes({
    required List<AccountMeta> keys,
    required List<int> instructionBytes,
    SolAddress programId = ComputeBudgetConst.programId,
  }) {
    return ComputeBudgetProgram(
        layout: ComputeBudgetProgramLayout.fromBytes(instructionBytes),
        keys: keys,
        programId: programId);
  }

  /// Creates an instruction to request units.
  factory ComputeBudgetProgram.requestUnits({
    required ComputeBudgetRequestUnitsLayout layout,
  }) {
    return ComputeBudgetProgram(
      layout: layout,
      keys: [],
      programId: ComputeBudgetConst.programId,
    );
  }

  /// Creates an instruction to request heap frame.
  factory ComputeBudgetProgram.requestHeapFrame({
    required ComputeBudgetRequestHeapFrameLayout layout,
  }) {
    return ComputeBudgetProgram(
      layout: layout,
      keys: [],
      programId: ComputeBudgetConst.programId,
    );
  }

  /// Creates an instruction to set compute unit limit.
  factory ComputeBudgetProgram.setComputeUnitLimit({
    required ComputeBudgetSetComputeUnitLimitLayout layout,
  }) {
    return ComputeBudgetProgram(
      layout: layout,
      keys: [],
      programId: ComputeBudgetConst.programId,
    );
  }

  /// Creates an instruction to set compute unit price.
  factory ComputeBudgetProgram.setComputeUnitPrice({
    required ComputeBudgetSetComputeUnitPriceLayout layout,
  }) {
    return ComputeBudgetProgram(
      layout: layout,
      keys: [],
      programId: ComputeBudgetConst.programId,
    );
  }
}
