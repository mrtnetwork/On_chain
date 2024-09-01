import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class SystemUpgradeNonceAccountLayout extends SystemProgramLayout {
  const SystemUpgradeNonceAccountLayout();
  factory SystemUpgradeNonceAccountLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        bytes: data,
        instruction: SystemProgramInstruction.upgradeNonceAccount.insturction,
        layout: _layout);
    return const SystemUpgradeNonceAccountLayout();
  }
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u32(property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  final SystemProgramInstruction instruction =
      SystemProgramInstruction.upgradeNonceAccount;
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
