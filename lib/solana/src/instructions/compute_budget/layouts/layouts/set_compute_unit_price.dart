import 'package:on_chain/solana/src/instructions/compute_budget/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// StructLayout for the ComputeBudgetSetComputeUnitPrice instruction.
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
        microLamports: decode['microLamports']);
  }
  // StructLayout layout definition.
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u8(property: 'instruction'),
        LayoutConst.u64(property: 'microLamports'),
      ]);

  @override
  StructLayout get layout => _layout;

  @override
  ComputeBudgetProgramInstruction get instruction =>
      ComputeBudgetProgramInstruction.setComputeUnitPrice;

  @override
  Map<String, dynamic> serialize() {
    return {'microLamports': microLamports};
  }

  @override
  Map<String, dynamic> toJson() {
    return {'microLamports': microLamports.toString()};
  }
}
