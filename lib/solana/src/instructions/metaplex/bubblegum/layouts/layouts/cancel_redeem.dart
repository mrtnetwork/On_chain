import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexBubblegumCancelRedeemLayout
    extends MetaplexBubblegumProgramLayout {
  final List<int> root;
  MetaplexBubblegumCancelRedeemLayout({required List<int> root})
      : root = root.asImmutableBytes;

  factory MetaplexBubblegumCancelRedeemLayout.fromBuffer(List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexBubblegumProgramInstruction.cancelRedeem.insturction);
    return MetaplexBubblegumCancelRedeemLayout(root: decode['root']);
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.blob(32, property: 'root'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexBubblegumProgramInstruction get instruction =>
      MetaplexBubblegumProgramInstruction.cancelRedeem;

  @override
  Map<String, dynamic> serialize() {
    return {'root': root};
  }
}
