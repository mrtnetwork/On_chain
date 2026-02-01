import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Advance nonce account system layout
class SystemAdvanceNonceLayout extends SystemProgramLayout {
  const SystemAdvanceNonceLayout();

  factory SystemAdvanceNonceLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.advanceNonceAccount.insturction);
    return const SystemAdvanceNonceLayout();
  }

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u32(property: 'instruction')]);
  @override
  StructLayout get layout => _layout;

  @override
  SystemProgramInstruction get instruction =>
      SystemProgramInstruction.advanceNonceAccount;
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
