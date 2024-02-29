import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Advance nonce account system layout
class SystemAdvanceNonceLayout extends SystemProgramLayout {
  const SystemAdvanceNonceLayout();

  factory SystemAdvanceNonceLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.advanceNonceAccount.insturction);
    return SystemAdvanceNonceLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u32("instruction")]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      SystemProgramInstruction.advanceNonceAccount.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
