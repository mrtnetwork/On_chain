import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/meta_data.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexBubblegumDecompressV1Layout
    extends MetaplexBubblegumProgramLayout {
  final MetaData metaData;
  const MetaplexBubblegumDecompressV1Layout({required this.metaData});

  factory MetaplexBubblegumDecompressV1Layout.fromBuffer(List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexBubblegumProgramInstruction.decompressV1.insturction);
    return MetaplexBubblegumDecompressV1Layout(
        metaData: MetaData.fromJson(decode["metaData"]));
  }

  static final StructLayout _layout = LayoutConst.struct(
      [LayoutConst.blob(8, property: "instruction"), MetaData.staticLayout]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexBubblegumProgramInstruction get instruction =>
      MetaplexBubblegumProgramInstruction.decompressV1;

  @override
  Map<String, dynamic> serialize() {
    return {"metaData": metaData.serialize()};
  }
}
