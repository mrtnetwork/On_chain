import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataburnNftLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataburnNftLayout();

  factory MetaplexTokenMetaDataburnNftLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.burnNft.insturction);
    return const MetaplexTokenMetaDataburnNftLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexTokenMetaDataProgramInstruction get instruction =>
      MetaplexTokenMetaDataProgramInstruction.burnNft;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
