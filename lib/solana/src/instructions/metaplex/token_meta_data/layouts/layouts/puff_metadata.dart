import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class MetaplexTokenMetaDataPuffMetadataLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataPuffMetadataLayout();

  factory MetaplexTokenMetaDataPuffMetadataLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.puffMetadata.insturction);
    return const MetaplexTokenMetaDataPuffMetadataLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.puffMetadata.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
