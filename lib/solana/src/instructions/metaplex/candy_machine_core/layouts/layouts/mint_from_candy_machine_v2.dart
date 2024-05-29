import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineMintFromCandyMachineV2Layout
    extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineMintFromCandyMachineV2Layout();

  factory MetaplexCandyMachineMintFromCandyMachineV2Layout.fromBuffer(
      List<int> data) {
    MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .mintFromCandyMachineV2.insturction);
    return const MetaplexCandyMachineMintFromCandyMachineV2Layout();
  }
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.mintFromCandyMachineV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
