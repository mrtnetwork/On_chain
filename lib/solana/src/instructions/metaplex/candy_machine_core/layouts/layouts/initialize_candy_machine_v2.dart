import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/types/candy_machine_types/types/candy_machine_data.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/token_standard.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineInitializeCandyMachineV2Layout
    extends MetaplexCandyMachineProgramLayout {
  final CandyMachineData data;
  final MetaDataTokenStandard tokenStandard;
  const MetaplexCandyMachineInitializeCandyMachineV2Layout(
      {required this.data, required this.tokenStandard});

  factory MetaplexCandyMachineInitializeCandyMachineV2Layout.fromBuffer(
      List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .initializeCandyMachineV2.insturction);
    return MetaplexCandyMachineInitializeCandyMachineV2Layout(
        data: CandyMachineData.fromJson(decode["candyMachineData"]),
        tokenStandard: MetaDataTokenStandard.fromJson(decode["tokenStandard"]));
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    CandyMachineData.staticLayout,
    LayoutConst.wrap(MetaDataTokenStandard.staticLayout,
        property: "tokenStandard")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction => MetaplexCandyMachineProgramInstruction
      .initializeCandyMachineV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {
      "candyMachineData": data.serialize(),
      "tokenStandard": tokenStandard.serialize()
    };
  }
}
