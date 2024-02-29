import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataSetAndVerifyCollectionLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataSetAndVerifyCollectionLayout();

  factory MetaplexTokenMetaDataSetAndVerifyCollectionLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .setAndVerifyCollection.insturction);
    return MetaplexTokenMetaDataSetAndVerifyCollectionLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .setAndVerifyCollection.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
