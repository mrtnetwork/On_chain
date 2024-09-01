import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineSetCollectionLayout
    extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineSetCollectionLayout();

  factory MetaplexCandyMachineSetCollectionLayout.fromBuffer(List<int> data) {
    MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexCandyMachineProgramInstruction.setCollection.insturction);
    return const MetaplexCandyMachineSetCollectionLayout();
  }
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexCandyMachineProgramInstruction get instruction =>
      MetaplexCandyMachineProgramInstruction.setCollection;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
