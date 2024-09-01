import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Allocate account system layout
class SystemAllocateLayout extends SystemProgramLayout {
  /// Amount of space in bytes to allocate
  final BigInt space;
  const SystemAllocateLayout({required this.space});

  factory SystemAllocateLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.allocate.insturction);
    return SystemAllocateLayout(space: decode["space"]);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    LayoutConst.ns64(property: "space")
  ]);
  @override
  StructLayout get layout => _layout;

  @override
  SystemProgramInstruction get instruction => SystemProgramInstruction.allocate;
  @override
  Map<String, dynamic> serialize() {
    return {"space": space};
  }
}
