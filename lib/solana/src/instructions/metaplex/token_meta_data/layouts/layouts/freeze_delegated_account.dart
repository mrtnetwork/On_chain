import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataFreezeDelegatedAccountLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataFreezeDelegatedAccountLayout();

  factory MetaplexTokenMetaDataFreezeDelegatedAccountLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .freezeDelegatedAccount.insturction);
    return MetaplexTokenMetaDataFreezeDelegatedAccountLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .freezeDelegatedAccount.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
