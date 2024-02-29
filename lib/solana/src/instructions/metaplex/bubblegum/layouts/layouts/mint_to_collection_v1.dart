import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/meta_data.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexBubblegumMintToCollectionV1Layout
    extends MetaplexBubblegumProgramLayout {
  final MetaData metaData;
  const MetaplexBubblegumMintToCollectionV1Layout({required this.metaData});

  factory MetaplexBubblegumMintToCollectionV1Layout.fromBuffer(List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexBubblegumProgramInstruction.mintToCollectionV1.insturction);
    return MetaplexBubblegumMintToCollectionV1Layout(
        metaData: MetaData.fromJson(decode["metaData"]));
  }

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.blob(8, property: "instruction"), MetaData.staticLayout]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexBubblegumProgramInstruction.mintToCollectionV1.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"metaData": metaData.serialize()};
  }
}
