import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineMintLayout extends MetaplexCandyMachineProgramLayout {
  final List<int> mintArgs;
  final String? group;
  MetaplexCandyMachineMintLayout(
      {required List<int> mintArgs, required this.group})
      : mintArgs = mintArgs.asImmutableBytes;

  factory MetaplexCandyMachineMintLayout.fromBuffer(List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction.mint.insturction);
    return MetaplexCandyMachineMintLayout(
        mintArgs: (decode['mintArgs'] as List).cast(), group: decode['group']);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.vecU8(property: 'mintArgs'),
    LayoutConst.optional(LayoutConst.string(), property: 'group')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexCandyMachineProgramInstruction get instruction =>
      MetaplexCandyMachineProgramInstruction.mint;

  @override
  Map<String, dynamic> serialize() {
    return {'group': group, 'mintArgs': mintArgs};
  }
}
