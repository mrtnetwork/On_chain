import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexCandyMachineMintFromCandyMachineLayout
    extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineMintFromCandyMachineLayout();

  factory MetaplexCandyMachineMintFromCandyMachineLayout.fromBuffer(
      List<int> data) {
    MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .mintFromCandyMachine.insturction);
    return MetaplexCandyMachineMintFromCandyMachineLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.mintFromCandyMachine.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
