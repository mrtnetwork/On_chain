import 'package:blockchain_utils/binary/binary.dart';
import 'package:on_chain/solana/src/instructions/metaplex/bubblegum/layouts/instructions/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineCreateCandyGuardLayout
    extends MetaplexCandyMachineProgramLayout {
  final List<int> data;
  MetaplexCandyMachineCreateCandyGuardLayout({required List<int> data})
      : data = BytesUtils.toBytes(data, unmodifiable: true);

  factory MetaplexCandyMachineCreateCandyGuardLayout.fromBuffer(
      List<int> data) {
    final decode = MetaplexBubblegumProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction
            .createCandyGuard.insturction);
    return MetaplexCandyMachineCreateCandyGuardLayout(
        data: (decode["data"] as List).cast());
  }

  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.vecU8(property: "data"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.createCandyGuard.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"data": data};
  }
}
