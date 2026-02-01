import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexBubblegumCompressLayout extends MetaplexBubblegumProgramLayout {
  const MetaplexBubblegumCompressLayout();

  factory MetaplexBubblegumCompressLayout.fromBuffer(List<int> data) {
    MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexBubblegumProgramInstruction.compress.insturction);
    return const MetaplexBubblegumCompressLayout();
  }

  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.blob(8, property: 'instruction')]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexBubblegumProgramInstruction get instruction =>
      MetaplexBubblegumProgramInstruction.compress;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
