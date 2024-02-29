import 'package:on_chain/solana/src/instructions/compute_budget/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/core/core.dart';
import 'package:on_chain/solana/src/layout/program_layouts/core/program_layout.dart';
import 'package:on_chain/solana/src/layout/utils/layout_utils.dart';

/// Structure for the ComputeBudgetSetComputeUnitPrice instruction.
class ComputeBudgetSetComputeUnitPriceLayout
    extends ComputeBudgetProgramLayout {
  /// Transaction compute unit price used for prioritization fees.
  final BigInt microLamports;

  /// Constructs the layout with required parameters.
  const ComputeBudgetSetComputeUnitPriceLayout({required this.microLamports});

  /// Constructs the layout from raw bytes.
  factory ComputeBudgetSetComputeUnitPriceLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            ComputeBudgetProgramInstruction.setComputeUnitPrice.insturction);
    return ComputeBudgetSetComputeUnitPriceLayout(
        microLamports: decode["microLamports"]);
  }
  // Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u64("microLamports"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      ComputeBudgetProgramInstruction.setComputeUnitPrice.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"microLamports": microLamports};
  }
}
