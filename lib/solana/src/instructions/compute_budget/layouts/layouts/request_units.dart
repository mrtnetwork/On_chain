import 'package:on_chain/solana/src/instructions/compute_budget/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// StructLayout for the ComputeBudgetRequestUnits instruction.
class ComputeBudgetRequestUnitsLayout extends ComputeBudgetProgramLayout {
  /// Units to request for transaction-wide compute.
  final int units;

  /// Prioritization fee lamports.
  final int additionalFee;

  /// Constructs the layout with required parameters.
  ComputeBudgetRequestUnitsLayout({
    required this.units,
    required this.additionalFee,
  });

  /// Constructs the layout from raw bytes.
  factory ComputeBudgetRequestUnitsLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: ComputeBudgetProgramInstruction.requestUnits.insturction);
    return ComputeBudgetRequestUnitsLayout(
      units: decode["units"],
      additionalFee: decode["additionalFee"],
    );
  }
  // StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u32(property: "units"),
    LayoutConst.u32(property: "additionalFee"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      ComputeBudgetProgramInstruction.requestUnits.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"units": units, "additionalFee": additionalFee};
  }
}
