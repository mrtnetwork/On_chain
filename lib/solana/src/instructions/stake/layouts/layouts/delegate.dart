import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class StakeDelegateLayout extends StakeProgramLayout {
  const StakeDelegateLayout();

  factory StakeDelegateLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: StakeProgramInstruction.delegate.insturction);
    return StakeDelegateLayout();
  }
  @override
  int get instruction => StakeProgramInstruction.delegate.insturction;
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u32("instruction")]);
  @override
  Structure get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
