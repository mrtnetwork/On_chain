import 'package:on_chain/solana/src/instructions/associated_token_account/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// AssociatedTokenAccount layout
class AssociatedTokenAccountProgramInitializeLayout
    extends AssociatedTokenAccountProgramLayout {
  const AssociatedTokenAccountProgramInitializeLayout();

  factory AssociatedTokenAccountProgramInitializeLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            AssociatedTokenAccountProgramInstruction.initialize.insturction);
    return const AssociatedTokenAccountProgramInitializeLayout();
  }
  static final StructLayout _layout = LayoutConst.struct([]);
  @override
  StructLayout get layout => _layout;

  @override
  AssociatedTokenAccountProgramInstruction get instruction =>
      AssociatedTokenAccountProgramInstruction.initialize;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }

  @override
  Map<String, dynamic> toJson() {
    return {};
  }
}
