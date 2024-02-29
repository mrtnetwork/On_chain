import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class StakeDeactivateLayout extends StakeProgramLayout {
  const StakeDeactivateLayout();

  factory StakeDeactivateLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: StakeProgramInstruction.deactivate.insturction);
    return StakeDeactivateLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u32("instruction")]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction => StakeProgramInstruction.deactivate.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
