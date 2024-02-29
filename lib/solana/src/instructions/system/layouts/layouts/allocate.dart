import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u32("instruction"), LayoutUtils.ns64("space")]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction => SystemProgramInstruction.allocate.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"space": space};
  }
}
