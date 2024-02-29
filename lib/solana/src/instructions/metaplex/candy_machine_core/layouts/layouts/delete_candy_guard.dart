import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexCandyMachineDeleteCandyGuardLayout
    extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineDeleteCandyGuardLayout();

  factory MetaplexCandyMachineDeleteCandyGuardLayout.fromBuffer(
      List<int> data) {
    MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .deleteCandyGuard.insturction);
    return MetaplexCandyMachineDeleteCandyGuardLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.deleteCandyGuard.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
