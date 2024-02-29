import 'package:on_chain/solana/src/instructions/metaplex/token_meta_data/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout
    extends MetaplexTokenMetaDataProgramLayout {
  final BigInt size;
  const MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout(
      {required this.size});

  factory MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenMetaDataProgramInstruction
            .bubblegumSetCollectionSize.insturction);
    return MetaplexTokenMetaDataBubblegumSetCollectionSizeLayout(
        size: decode["size"]);
  }

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u64("size")]);

  @override
  Structure get layout => _layout;

  @override
  int get instruction => MetaplexTokenMetaDataProgramInstruction
      .bubblegumSetCollectionSize.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"size": size};
  }
}
