import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/decompressible_state.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

class MetaplexBubblegumSetDecompressibleStateLayout
    extends MetaplexBubblegumProgramLayout {
  final DecompressibleState decompressibleState;
  const MetaplexBubblegumSetDecompressibleStateLayout(
      {required this.decompressibleState});

  factory MetaplexBubblegumSetDecompressibleStateLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexBubblegumProgramInstruction
            .setDecompressibleState.insturction);
    return MetaplexBubblegumSetDecompressibleStateLayout(
        decompressibleState:
            DecompressibleState.fromValue(decode["decompressableState"]));
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.u8("decompressableState"),
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexBubblegumProgramInstruction.setDecompressibleState.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"decompressableState": decompressibleState.value};
  }
}
