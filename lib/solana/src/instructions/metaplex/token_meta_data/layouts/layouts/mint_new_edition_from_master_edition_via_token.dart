import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaTokenLayout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt edition;
  const MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaTokenLayout(
      {required this.edition});

  factory MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaTokenLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .mintNewEditionFromMasterEditionViaToken.insturction);
    return MetaplexTokenMetaDataMintNewEditionFromMasterEditionViaTokenLayout(
        edition: decode["edition"]);
  }

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u64("edition")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .mintNewEditionFromMasterEditionViaToken.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"edition": edition};
  }
}
