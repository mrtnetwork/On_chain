import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineDeleteCandyMachineLayout
    extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineDeleteCandyMachineLayout();

  factory MetaplexCandyMachineDeleteCandyMachineLayout.fromBuffer(
      List<int> data) {
    MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .deleteCandyMachine.insturction);
    return const MetaplexCandyMachineDeleteCandyMachineLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexCandyMachineProgramInstruction get instruction =>
      MetaplexCandyMachineProgramInstruction.deleteCandyMachine;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
