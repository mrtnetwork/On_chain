import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/types/types/token_standard.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineSetTokenStandardLayout
    extends MetaplexCandyMachineProgramLayout {
  final MetaDataTokenStandard tokenStandard;
  const MetaplexCandyMachineSetTokenStandardLayout(
      {required this.tokenStandard});

  factory MetaplexCandyMachineSetTokenStandardLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .setTokenStandard.insturction);
    return MetaplexCandyMachineSetTokenStandardLayout(
        tokenStandard: MetaDataTokenStandard.fromJson(decode["tokenStandard"]));
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.wrap(MetaDataTokenStandard.staticLayout,
        property: "tokenStandard")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.setTokenStandard.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"tokenStandard": tokenStandard.serialize()};
  }
}
