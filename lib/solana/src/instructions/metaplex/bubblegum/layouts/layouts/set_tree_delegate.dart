import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexBubblegumSetTreeDelegateLayout
    extends MetaplexBubblegumProgramLayout {
  const MetaplexBubblegumSetTreeDelegateLayout();

  factory MetaplexBubblegumSetTreeDelegateLayout.fromBuffer(List<int> data) {
    MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexBubblegumProgramInstruction.setTreeDelegate.insturction);
    return MetaplexBubblegumSetTreeDelegateLayout();
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexBubblegumProgramInstruction.setTreeDelegate.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
