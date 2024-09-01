import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/meta_data.dart';
import 'package:blockchain_utils/layout/layout.dart';

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

  static final StructLayout _layout = LayoutConst.struct(
      [LayoutConst.blob(8, property: "instruction"), MetaData.staticLayout]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexBubblegumProgramInstruction get instruction =>
      MetaplexBubblegumProgramInstruction.mintToCollectionV1;

  @override
  Map<String, dynamic> serialize() {
    return {"metaData": metaData.serialize()};
  }
}
