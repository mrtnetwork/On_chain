import 'package:on_chain/solana/src/instructions/associated_token_account/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Idempotent layout
class AssociatedTokenAccountProgramIdempotentLayout
    extends AssociatedTokenAccountProgramLayout {
  const AssociatedTokenAccountProgramIdempotentLayout();

  factory AssociatedTokenAccountProgramIdempotentLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            AssociatedTokenAccountProgramInstruction.idempotent.insturction);
    return const AssociatedTokenAccountProgramIdempotentLayout();
  }
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);
  @override
  StructLayout get layout => _layout;

  @override
  AssociatedTokenAccountProgramInstruction get instruction =>
      AssociatedTokenAccountProgramInstruction.idempotent;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
