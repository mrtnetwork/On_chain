import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexBubblegumCancelRedeemLayout
    extends MetaplexBubblegumProgramLayout {
  final List<int> root;
  MetaplexBubblegumCancelRedeemLayout({required List<int> root})
      : root = BytesUtils.toBytes(root, unmodifiable: true);

  factory MetaplexBubblegumCancelRedeemLayout.fromBuffer(List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexBubblegumProgramInstruction.cancelRedeem.insturction);
    return MetaplexBubblegumCancelRedeemLayout(root: decode["root"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.blob(32, property: "root"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexBubblegumProgramInstruction.cancelRedeem.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"root": root};
  }
}
