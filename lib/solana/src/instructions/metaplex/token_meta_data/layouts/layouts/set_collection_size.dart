import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataSetCollectionSizeLayout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt size;
  const MetaplexTokenMetaDataSetCollectionSizeLayout({required this.size});

  factory MetaplexTokenMetaDataSetCollectionSizeLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .setCollectionSize.insturction);
    return MetaplexTokenMetaDataSetCollectionSizeLayout(size: decode["size"]);
  }

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u64("size")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      MetaplexTokenMetaDataProgramInstruction.setCollectionSize.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"size": size};
  }
}
