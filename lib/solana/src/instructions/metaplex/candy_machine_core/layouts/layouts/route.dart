import 'package:blockchain_utils/binary/binary.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/instructions/metaplex/candy_machine_core/types/candy_guard_types/types.dart';
import 'package:blockchain_utils/layout/layout.dart';

class MetaplexCandyMachineRouteLayout
    extends MetaplexCandyMachineProgramLayout {
  final GuardType guard;
  final List<int> data;
  final String? group;
  MetaplexCandyMachineRouteLayout(
      {required this.guard, required List<int> data, this.group})
      : data = BytesUtils.toBytes(data, unmodifiable: true);

  factory MetaplexCandyMachineRouteLayout.fromBuffer(List<int> data) {
    final decode = MetaplexCandyMachineProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: MetaplexCandyMachineProgramInstruction.route.insturction);
    return MetaplexCandyMachineRouteLayout(
        data: (decode["data"] as List).cast(),
        guard: GuardType.fromValue(decode["guard"]),
        group: decode["group"]);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.blob(8, property: "instruction"),
    LayoutConst.u8(property: "guard"),
    LayoutConst.vecU8(property: "data"),
    LayoutConst.optional(LayoutConst.string(), property: "group"),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  List<int> get instruction =>
      MetaplexCandyMachineProgramInstruction.route.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"guard": guard.value, "data": data, "group": group};
  }
}
