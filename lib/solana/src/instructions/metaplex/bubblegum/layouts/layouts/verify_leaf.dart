import 'package:blockchain_utils/utils/utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/meta_data.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexBubblegumVerifyLeafLayout extends MetaplexBubblegumProgramLayout {
  final List<int> root;
  final List<int> leaf;
  final int index;
  MetaplexBubblegumVerifyLeafLayout({
    required List<int> root,
    required List<int> leaf,
    required this.index,
  })  : root = BytesUtils.toBytes(root, unmodifiable: true),
        leaf = BytesUtils.toBytes(leaf, unmodifiable: true);

  factory MetaplexBubblegumVerifyLeafLayout.fromBuffer(List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexBubblegumProgramInstruction.verifyLeaf.insturction);
    return MetaplexBubblegumVerifyLeafLayout(
        root: decode["root"], leaf: decode["leaf"], index: decode["index"]);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.blob(32, property: "root"),
    LayoutConst.blob(32, property: "leaf"),
    LayoutConst.u32(property: "index"),
    MetaData.staticLayout
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexBubblegumProgramInstruction get instruction =>
      MetaplexBubblegumProgramInstruction.verifyLeaf;

  @override
  Map<String, dynamic> serialize() {
    return {"root": root, "leaf": leaf, "index": index};
  }
}
