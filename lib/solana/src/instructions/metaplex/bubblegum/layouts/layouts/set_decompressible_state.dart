import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/types/types/decompressible_state.dart';
import 'package:blockchain_utils/layout/layout.dart';

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

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "decompressableState"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexBubblegumProgramInstruction.setDecompressibleState.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"decompressableState": decompressibleState.value};
  }
}
