import 'package:on_chain/solana/src/instructions/compute_budget/layouts/layouts.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

abstract class ComputeBudgetProgramLayout extends ProgramLayout {
  const ComputeBudgetProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    try {
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      final instruction =
          ComputeBudgetProgramInstruction.getInstruction(decode["instruction"]);
      switch (instruction) {
        case ComputeBudgetProgramInstruction.requestHeapFrame:
          return ComputeBudgetRequestHeapFrameLayout.fromBuffer(data);
        case ComputeBudgetProgramInstruction.requestUnits:
          return ComputeBudgetRequestUnitsLayout.fromBuffer(data);
        case ComputeBudgetProgramInstruction.setComputeUnitLimit:
          return ComputeBudgetSetComputeUnitLimitLayout.fromBuffer(data);
        case ComputeBudgetProgramInstruction.setComputeUnitPrice:
          return ComputeBudgetSetComputeUnitPriceLayout.fromBuffer(data);
        default:
          return UnknownProgramLayout(data);
      }
    } catch (e) {
      return UnknownProgramLayout(data);
    }
  }
}
