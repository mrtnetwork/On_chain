import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/types/candy_machine_types/types/candy_machine_data.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexCandyMachineInitializeCandyMachineLayout
    extends MetaplexCandyMachineProgramLayout {
  final CandyMachineData data;
  const MetaplexCandyMachineInitializeCandyMachineLayout({required this.data});

  factory MetaplexCandyMachineInitializeCandyMachineLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .initializeCandyMachine.insturction);
    return MetaplexCandyMachineInitializeCandyMachineLayout(
        data: CandyMachineData.fromJson(decode["candyMachineData"]));
  }
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    CandyMachineData.staticLayout
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.initializeCandyMachine.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"candyMachineData": data.serialize()};
  }
}
