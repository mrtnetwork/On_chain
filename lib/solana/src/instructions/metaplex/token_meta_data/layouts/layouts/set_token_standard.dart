import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataSetTokenStandardLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataSetTokenStandardLayout();

  factory MetaplexTokenMetaDataSetTokenStandardLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .setTokenStandard.insturction);
    return const MetaplexTokenMetaDataSetTokenStandardLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.setTokenStandard.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
