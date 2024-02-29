import 'package:on_chain/solana/src/instructions/compute_budget/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Structure for the ComputeBudgetRequestHeapFrame instruction.
class ComputeBudgetRequestHeapFrameLayout extends ComputeBudgetProgramLayout {
  /// Requested transaction-wide program heap size in bytes. Must be multiple of 1024. Applies to each program, including CPIs.
  final int bytes;

  /// Constructs the layout with required parameters.
  const ComputeBudgetRequestHeapFrameLayout({required this.bytes});

  /// Constructs the layout from raw bytes.
  factory ComputeBudgetRequestHeapFrameLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            ComputeBudgetProgramInstruction.requestHeapFrame.insturction);
    return ComputeBudgetRequestHeapFrameLayout(bytes: decode["bytes"]);
  }
  // Structure layout definition.
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u32("bytes"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      ComputeBudgetProgramInstruction.requestHeapFrame.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"bytes": bytes};
  }
}
