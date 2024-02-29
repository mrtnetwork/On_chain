import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataRevokeCollectionAuthorityLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataRevokeCollectionAuthorityLayout();

  factory MetaplexTokenMetaDataRevokeCollectionAuthorityLayout.fromBuffer(
      List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .revokeCollectionAuthority.insturction);
    return MetaplexTokenMetaDataRevokeCollectionAuthorityLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .revokeCollectionAuthority.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
