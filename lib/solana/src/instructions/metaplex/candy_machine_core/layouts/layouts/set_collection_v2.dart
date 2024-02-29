import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexCandyMachineSetCollectionV2Layout
    extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineSetCollectionV2Layout();

  factory MetaplexCandyMachineSetCollectionV2Layout.fromBuffer(List<int> data) {
    MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexCandyMachineProgramInstruction.setCollectionV2.insturction);
    return MetaplexCandyMachineSetCollectionV2Layout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.setCollectionV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
