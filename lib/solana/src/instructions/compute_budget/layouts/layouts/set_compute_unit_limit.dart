import 'package:on_chain/solana/src/instructions/compute_budget/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// StructLayout for the ComputeBudgetSetComputeUnitLimit instruction.
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
  // StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u32(property: "units"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      ComputeBudgetProgramInstruction.setComputeUnitLimit.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"units": units};
  }
}
