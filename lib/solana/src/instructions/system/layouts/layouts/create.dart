import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/instructions/system/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/utils/layouts.dart';

/// Create account system layout
class SystemCreateLayout extends SystemProgramLayout {
  /// Amount of lamports to transfer to the created account
  final BigInt lamports;

  /// Amount of space in bytes to allocate to the created account
  final BigInt space;

  /// Address of the program to assign as the owner of the created account
  final SolAddress programId;
  const SystemCreateLayout(
      {required this.lamports, required this.space, required this.programId});

  factory SystemCreateLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: SystemProgramInstruction.create.insturction);
    return SystemCreateLayout(
        lamports: decode["lamports"],
        space: decode["space"],
        programId: decode["programId"]);
  }
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u32(property: "instruction"),
    LayoutConst.ns64(property: 'lamports'),
    LayoutConst.ns64(property: 'space'),
    SolanaLayoutUtils.publicKey('programId'),
  ]);

  @override
  StructLayout get layout => _layout;

  @override
  SystemProgramInstruction get instruction => SystemProgramInstruction.create;
  @override
  Map<String, dynamic> serialize() {
    return {"lamports": lamports, "space": space, "programId": programId};
  }
}
