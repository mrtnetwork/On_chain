import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';

class MetaplexCandyMachineMintV2Layout
    extends MetaplexCandyMachineProgramLayout {
  final List<int> mintArgs;
  final String? group;
  MetaplexCandyMachineMintV2Layout(
      {required List<int> mintArgs, required this.group})
      : mintArgs = mintArgs.asImmutableBytes;

  factory MetaplexCandyMachineMintV2Layout.fromBuffer(List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction.mintV2.insturction);
    return MetaplexCandyMachineMintV2Layout(
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
      MetaplexCandyMachineProgramInstruction.mintV2;

  @override
  Map<String, dynamic> serialize() {
    return {'group': group, 'mintArgs': mintArgs};
  }
}
