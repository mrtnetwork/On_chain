import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.blob(8, property: "instruction"),
    LayoutUtils.vecU8("data")
  ]);

  @override
  Structure get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.updateCandyGuard.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"data": data};
  }
}
