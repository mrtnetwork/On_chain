import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexBubblegumCompressLayout extends MetaplexBubblegumProgramLayout {
  const MetaplexBubblegumCompressLayout();

  factory MetaplexBubblegumCompressLayout.fromBuffer(List<int> data) {
    MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexBubblegumProgramInstruction.compress.insturction);
    return MetaplexBubblegumCompressLayout();
  }

  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.blob(8, property: "instruction")]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexBubblegumProgramInstruction.compress.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
