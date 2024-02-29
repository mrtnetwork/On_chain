import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class SystemUpgradeNonceAccountLayout extends SystemProgramLayout {
  const SystemUpgradeNonceAccountLayout();
  factory SystemUpgradeNonceAccountLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        bytes: data,
        instruction: SystemProgramInstruction.upgradeNonceAccount.insturction,
        layout: _layout);
    return SystemUpgradeNonceAccountLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u32("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  final int instruction = 12;
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
