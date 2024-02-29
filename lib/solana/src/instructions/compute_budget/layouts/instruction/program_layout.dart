import 'package:on_chain/solana/src/instructions/compute_budget/layouts/layouts.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

abstract class ComputeBudgetProgramLayout extends ProgramLayout {
  const ComputeBudgetProgramLayout();
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);
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
