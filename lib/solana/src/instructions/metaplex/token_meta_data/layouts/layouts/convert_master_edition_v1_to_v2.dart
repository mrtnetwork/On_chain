import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataConvertMasterEditionV1ToV2Layout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataConvertMasterEditionV1ToV2Layout();

  factory MetaplexTokenMetaDataConvertMasterEditionV1ToV2Layout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .convertMasterEditionV1ToV2.insturction);
    return MetaplexTokenMetaDataConvertMasterEditionV1ToV2Layout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .convertMasterEditionV1ToV2.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
