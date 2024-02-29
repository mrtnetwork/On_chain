import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class StakeMergeLayout extends StakeProgramLayout {
  const StakeMergeLayout();

  factory StakeMergeLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: StakeProgramInstruction.merge.insturction);
    return StakeMergeLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u32("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => StakeProgramInstruction.merge.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
