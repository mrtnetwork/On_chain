import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineWrapLayout extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineWrapLayout();

  factory MetaplexCandyMachineWrapLayout.fromBuffer(List<int> data) {
    MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction.wrap.insturction);
    return const MetaplexCandyMachineWrapLayout();
  }
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexCandyMachineProgramInstruction get instruction =>
      MetaplexCandyMachineProgramInstruction.wrap;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
