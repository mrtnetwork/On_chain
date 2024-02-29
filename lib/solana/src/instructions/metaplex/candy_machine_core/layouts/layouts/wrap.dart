import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexCandyMachineWrapLayout extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineWrapLayout();

  factory MetaplexCandyMachineWrapLayout.fromBuffer(List<int> data) {
    MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction.wrap.insturction);
    return MetaplexCandyMachineWrapLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.wrap.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
