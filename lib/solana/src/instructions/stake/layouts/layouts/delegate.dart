import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class StakeDelegateLayout extends StakeProgramLayout {
  const StakeDelegateLayout();

  factory StakeDelegateLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: StakeProgramInstruction.delegate.insturction);
    return const StakeDelegateLayout();
  }
  @override
  StakeProgramInstruction get instruction => StakeProgramInstruction.delegate;
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u32(property: 'instruction')]);
  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
