import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataMigrateLayout
    extends MetaplexTokenMetaDataProgramLayout {
  const MetaplexTokenMetaDataMigrateLayout();

  factory MetaplexTokenMetaDataMigrateLayout.fromBuffer(List<int> data) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.migrate.insturction);
    return MetaplexTokenMetaDataMigrateLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.migrate.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
