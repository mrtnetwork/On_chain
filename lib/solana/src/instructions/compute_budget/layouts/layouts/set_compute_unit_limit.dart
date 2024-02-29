import 'package:on_chain/solana/src/instructions/compute_budget/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/core/core.dart';
import 'package:on_chain/solana/src/layout/program_layouts/core/program_layout.dart';
import 'package:on_chain/solana/src/layout/utils/layout_utils.dart';

/// Structure for the ComputeBudgetSetComputeUnitLimit instruction.
class ComputeBudgetSetComputeUnitLimitLayout
    extends ComputeBudgetProgramLayout {
  /// Transaction-wide compute unit limit.
  final int units;

  /// Constructs the layout with required parameters.
  const ComputeBudgetSetComputeUnitLimitLayout({required this.units});

  /// Constructs the layout from raw bytes.
  factory ComputeBudgetSetComputeUnitLimitLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            ComputeBudgetProgramInstruction.setComputeUnitLimit.insturction);
    return ComputeBudgetSetComputeUnitLimitLayout(units: decode["units"]);
  }
  // Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u32("units"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      ComputeBudgetProgramInstruction.setComputeUnitLimit.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"units": units};
  }
}
