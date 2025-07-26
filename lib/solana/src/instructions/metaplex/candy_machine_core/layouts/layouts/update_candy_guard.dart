import 'package:blockchain_utils/helper/extensions/extensions.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineUpdateCandyGuardLayout
    extends MetaplexCandyMachineProgramLayout {
  final List<int> data;
  MetaplexCandyMachineUpdateCandyGuardLayout({required List<int> data})
      : data = data.asImmutableBytes;

  factory MetaplexCandyMachineUpdateCandyGuardLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .updateCandyGuard.insturction);
    return MetaplexCandyMachineUpdateCandyGuardLayout(
        data: (decode['data'] as List).cast());
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: 'instruction'),
    LayoutConst.vecU8(property: 'data')
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  MetaplexCandyMachineProgramInstruction get instruction =>
      MetaplexCandyMachineProgramInstruction.updateCandyGuard;

  @override
  Map<String, dynamic> serialize() {
    return {'data': data};
  }
}
