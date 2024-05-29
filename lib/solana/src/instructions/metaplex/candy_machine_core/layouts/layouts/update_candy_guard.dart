import 'package:blockchain_utils/binary/binary.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineUpdateCandyGuardLayout
    extends MetaplexCandyMachineProgramLayout {
  final List<int> data;
  MetaplexCandyMachineUpdateCandyGuardLayout({required List<int> data})
      : data = BytesUtils.toBytes(data, unmodifiable: true);

  factory MetaplexCandyMachineUpdateCandyGuardLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .updateCandyGuard.insturction);
    return MetaplexCandyMachineUpdateCandyGuardLayout(
        data: (decode["data"] as List).cast());
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.vecU8(property: "data")
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.updateCandyGuard.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"data": data};
  }
}
