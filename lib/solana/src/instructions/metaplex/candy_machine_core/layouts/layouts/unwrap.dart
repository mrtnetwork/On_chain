import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexCandyMachineUnwrapLayout
    extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineUnwrapLayout();

  factory MetaplexCandyMachineUnwrapLayout.fromBuffer(List<int> data) {
    MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction.unwrap.insturction);
    return MetaplexCandyMachineUnwrapLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.unwrap.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
