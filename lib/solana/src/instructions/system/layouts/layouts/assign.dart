import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Assign system layout
class SystemAssignLayout extends SystemProgramLayout {
  /// address of the program to assign as the owner
  final SolAddress programId;
  const SystemAssignLayout({required this.programId});
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u32("instruction"), LayoutUtils.publicKey('programId')]);

  factory SystemAssignLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.assign.insturction);
    return SystemAssignLayout(programId: decode["programId"]);
  }

  @override
  Structure get layout => _layout;
  @override
  int get instruction => SystemProgramInstruction.assign.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"programId": programId};
  }
}
