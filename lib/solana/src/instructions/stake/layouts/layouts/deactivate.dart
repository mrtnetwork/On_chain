import 'package:on_chain/solana/src/instructions/stake/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class StakeDeactivateLayout extends StakeProgramLayout {
  const StakeDeactivateLayout();

  factory StakeDeactivateLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: StakeProgramInstruction.deactivate.insturction);
    return const StakeDeactivateLayout();
  }
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u32(property: "instruction")]);
  @override
  StructLayout get layout => _layout;

  @override
  int get instruction => StakeProgramInstruction.deactivate.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
