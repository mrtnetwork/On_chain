import 'package:on_chain/solana/src/instructions/associated_token_account/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
    return AssociatedTokenAccountProgramInitializeLayout();
  }
  static final Structure _layout = LayoutUtils.struct([]);
  @override
  Structure get layout => _layout;

  @override
  int? get instruction =>
      AssociatedTokenAccountProgramInstruction.initialize.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
