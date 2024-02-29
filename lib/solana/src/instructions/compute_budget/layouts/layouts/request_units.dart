import 'package:on_chain/solana/src/instructions/compute_budget/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Structure for the ComputeBudgetRequestUnits instruction.
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
  // Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u32("units"),
    LayoutUtils.u32("additionalFee"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      ComputeBudgetProgramInstruction.requestUnits.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"units": units, "additionalFee": additionalFee};
  }
}
