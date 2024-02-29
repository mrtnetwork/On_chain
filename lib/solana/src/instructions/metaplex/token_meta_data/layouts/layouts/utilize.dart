import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataUtilizeLayout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt numberOfUses;
  const MetaplexTokenMetaDataUtilizeLayout({required this.numberOfUses});

  factory MetaplexTokenMetaDataUtilizeLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexTokenMetaDataProgramInstruction.utilize.insturction);
    return MetaplexTokenMetaDataUtilizeLayout(
        numberOfUses: decode["numberOfUses"]);
  }

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u64("numberOfUses")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.utilize.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"numberOfUses": numberOfUses};
  }
}
