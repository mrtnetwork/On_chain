import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineUnwrapLayout
    extends MetaplexCandyMachineProgramLayout {
  const MetaplexCandyMachineUnwrapLayout();

  factory MetaplexCandyMachineUnwrapLayout.fromBuffer(List<int> data) {
    MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction.unwrap.insturction);
    return const MetaplexCandyMachineUnwrapLayout();
  }
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.unwrap.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
