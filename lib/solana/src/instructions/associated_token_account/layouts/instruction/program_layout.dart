import 'package:on_chain/solana/src/instructions/associated_token_account/layouts/layouts.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

abstract class AssociatedTokenAccountProgramLayout extends ProgramLayout {
  const AssociatedTokenAccountProgramLayout();
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    try {
      if (data.isEmpty) {
        return AssociatedTokenAccountProgramInitializeLayout.fromBuffer(data);
      }
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      final instruction =
          AssociatedTokenAccountProgramInstruction.getInstruction(
              decode["instruction"]);
      switch (instruction) {
        case AssociatedTokenAccountProgramInstruction.idempotent:
          return AssociatedTokenAccountProgramIdempotentLayout.fromBuffer(data);
        case AssociatedTokenAccountProgramInstruction.recoverNested:
          return AssociatedTokenAccountProgramRecoverNestedLayout.fromBuffer(
              data);
        default:
          return UnknownProgramLayout(data);
      }
    } catch (e) {
      return UnknownProgramLayout(data);
    }
  }
}
