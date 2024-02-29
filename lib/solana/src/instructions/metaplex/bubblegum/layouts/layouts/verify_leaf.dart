import 'package:blockchain_utils/binary/utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/meta_data.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.blob(32, property: "root"),
    LayoutUtils.blob(32, property: "leaf"),
    LayoutUtils.u32("index"),
    MetaData.staticLayout
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexBubblegumProgramInstruction.verifyLeaf.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"root": root, "leaf": leaf, "index": index};
  }
}
