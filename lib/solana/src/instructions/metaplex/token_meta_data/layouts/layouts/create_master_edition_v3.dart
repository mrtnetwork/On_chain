import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataCreateMasterEditionV3Layout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt? maxSupply;
  const MetaplexTokenMetaDataCreateMasterEditionV3Layout({this.maxSupply});

  factory MetaplexTokenMetaDataCreateMasterEditionV3Layout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .createMasterEditionV3.insturction);
    return MetaplexTokenMetaDataCreateMasterEditionV3Layout(
        maxSupply: decode["maxSupply"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.optional(LayoutUtils.u64(), property: "maxSupply")
  ]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.createMasterEditionV3.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"maxSupply": maxSupply};
  }
}
