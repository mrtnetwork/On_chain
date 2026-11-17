import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/secp256r1/constant.dart';

/// Instruction marker for the Secp256r1 precompile.
class Secp256r1ProgramInstruction implements ProgramLayoutInstruction {
  @override
  final dynamic instruction;
  @override
  final String name;
  const Secp256r1ProgramInstruction(this.instruction, this.name);
  static const Secp256r1ProgramInstruction secp256r1 =
      Secp256r1ProgramInstruction(null, 'Secp256r1');

  static const List<Secp256r1ProgramInstruction> values = [secp256r1];

  @override
  String get programName => 'Secp256r1';
  @override
  SolAddress get programAddress => Secp256r1ProgramConst.programId;
}
