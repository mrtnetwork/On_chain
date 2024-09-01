import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/memo/constant.dart';

class MemoProgramInstruction implements ProgramLayoutInstruction {
  @override
  final dynamic insturction;
  @override
  final String name;
  const MemoProgramInstruction(this.insturction, this.name);
  static const MemoProgramInstruction memo =
      MemoProgramInstruction(null, "Memo");

  static const List<MemoProgramInstruction> values = [memo];

  @override
  String get programName => "Memo";

  @override
  SolAddress get programAddress => MemoProgramConst.programId;
}
