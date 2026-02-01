import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

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
    return const MetaplexCandyMachineMintFromCandyMachineLayout();
  }
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexCandyMachineProgramInstruction get instruction =>
      MetaplexCandyMachineProgramInstruction.mintFromCandyMachine;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
