import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexBubblegumSetTreeDelegateLayout
    extends MetaplexBubblegumProgramLayout {
  const MetaplexBubblegumSetTreeDelegateLayout();

  factory MetaplexBubblegumSetTreeDelegateLayout.fromBuffer(List<int> data) {
    MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            MetaplexBubblegumProgramInstruction.setTreeDelegate.insturction);
    return const MetaplexBubblegumSetTreeDelegateLayout();
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexBubblegumProgramInstruction get instruction =>
      MetaplexBubblegumProgramInstruction.setTreeDelegate;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
