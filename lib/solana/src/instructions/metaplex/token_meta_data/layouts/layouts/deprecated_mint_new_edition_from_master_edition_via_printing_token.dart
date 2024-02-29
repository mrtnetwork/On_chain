import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataDeprecatedMintNewEditionFromMasterEditionViaPrintingTokenLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataDeprecatedMintNewEditionFromMasterEditionViaPrintingTokenLayout();

  factory MetaplexTokenMetaDataDeprecatedMintNewEditionFromMasterEditionViaPrintingTokenLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .deprecatedMintNewEditionFromMasterEditionViaPrintingToken
            .insturction);
    return MetaplexTokenMetaDataDeprecatedMintNewEditionFromMasterEditionViaPrintingTokenLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .deprecatedMintNewEditionFromMasterEditionViaPrintingToken.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
