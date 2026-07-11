import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/compute_budget/constant.dart';

/// An enumeration of valid ComputeBudgetInstructionType's
class ComputeBudgetProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const ComputeBudgetProgramInstruction(this.insturction, this.name);
  static const ComputeBudgetProgramInstruction requestUnits =
      ComputeBudgetProgramInstruction(0, 'RequestUnits');
  static const ComputeBudgetProgramInstruction requestHeapFrame =
      ComputeBudgetProgramInstruction(1, 'RequestHeapFrame');
  static const ComputeBudgetProgramInstruction setComputeUnitLimit =
      ComputeBudgetProgramInstruction(2, 'SetComputeUnitLimit');
  static const ComputeBudgetProgramInstruction setComputeUnitPrice =
      ComputeBudgetProgramInstruction(3, 'SetComputeUnitPrice');

  static const List<ComputeBudgetProgramInstruction> values = [
    requestUnits,
    requestHeapFrame,
    setComputeUnitLimit,
    setComputeUnitPrice,
  ];
  static ComputeBudgetProgramInstruction? getInstruction(dynamic value) {
    return values.firstWhereNullable((element) => element.insturction == value);
  }

  @override
  String get programName => 'ComputeBudget';

  @override
  SolAddress get programAddress => ComputeBudgetConst.programId;
}
