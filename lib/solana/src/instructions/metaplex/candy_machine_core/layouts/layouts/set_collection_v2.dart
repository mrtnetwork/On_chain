import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineSetCollectionV2Layout
    extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineSetCollectionV2Layout();

  factory MetaplexCandyMachineSetCollectionV2Layout.fromBuffer(List<int> data) {
    MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexCandyMachineProgramInstruction.setCollectionV2.insturction);
    return const MetaplexCandyMachineSetCollectionV2Layout();
  }
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexCandyMachineProgramInstruction get instruction =>
      MetaplexCandyMachineProgramInstruction.setCollectionV2;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
