import 'package:on_chain/solana/src/instructions/associated_token_account/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// RecoverNestedLayout layout
class AssociatedTokenAccountProgramRecoverNestedLayout
    extends AssociatedTokenAccountProgramLayout {
  const AssociatedTokenAccountProgramRecoverNestedLayout();

  factory AssociatedTokenAccountProgramRecoverNestedLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            AssociatedTokenAccountProgramInstruction.recoverNested.insturction);
    return AssociatedTokenAccountProgramRecoverNestedLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);
  @override
  Structure get layout => _layout;

  @override
  int? get instruction =>
      AssociatedTokenAccountProgramInstruction.recoverNested.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
