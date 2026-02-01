import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Assign system layout
class SystemAssignLayout extends SystemProgramLayout {
  /// address of the program to assign as the owner
  final SolAddress programId;
  const SystemAssignLayout({required this.programId});
  static StructLayout get _layout => LayoutConst.struct([
        LayoutConst.u32(property: 'instruction'),
        SolanaLayoutUtils.publicKey('programId')
      ]);

  factory SystemAssignLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.assign.insturction);
    return SystemAssignLayout(programId: decode['programId']);
  }

  @override
  StructLayout get layout => _layout;
  @override
  SystemProgramInstruction get instruction => SystemProgramInstruction.assign;
  @override
  Map<String, dynamic> serialize() {
    return {'programId': programId};
  }
}
