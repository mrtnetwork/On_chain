import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataCollectLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataCollectLayout();

  factory MetaplexTokenMetaDataCollectLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.collect.insturction);
    return MetaplexTokenMetaDataCollectLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.collect.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
