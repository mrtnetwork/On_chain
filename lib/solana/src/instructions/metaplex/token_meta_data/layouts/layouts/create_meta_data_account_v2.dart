import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';

import 'package:on_chain/solana/src/layout/layout.dart';

///
class MetaplexTokenMetaDataCreateMetadataAccountV2Layout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataCreateMetadataAccountV2Layout();

  factory MetaplexTokenMetaDataCreateMetadataAccountV2Layout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .createMetadataAccountV2.insturction);
    return MetaplexTokenMetaDataCreateMetadataAccountV2Layout();
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .createMetadataAccountV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
