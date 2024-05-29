import 'package:on_chain/solana/src/instructions/metaplex/token_entangler/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexTokenEntanglerSwapLayout
    extends MetaplexTokenEntanglerProgramLayout {
  const MetaplexTokenEntanglerSwapLayout();

  factory MetaplexTokenEntanglerSwapLayout.fromBuffer(List<int> data) {
    MetaplexTokenEntanglerProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexTokenEntanglerProgramInstruction.swap.insturction);
    return const MetaplexTokenEntanglerSwapLayout();
  }

  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.blob(8, property: "instruction")]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexTokenEntanglerProgramInstruction.swap.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
