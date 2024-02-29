import 'package:on_chain/solana/src/instructions/associated_token_account/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
    return AssociatedTokenAccountProgramIdempotentLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);
  @override
  Structure get layout => _layout;

  @override
  int? get instruction =>
      AssociatedTokenAccountProgramInstruction.idempotent.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
