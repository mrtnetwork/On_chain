import 'package:on_chain/solana/src/instructions/compute_budget/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// StructLayout for the ComputeBudgetRequestHeapFrame instruction.
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
  // StructLayout layout definition.
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.u32(property: "bytes"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      ComputeBudgetProgramInstruction.requestHeapFrame.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"bytes": bytes};
  }
}
