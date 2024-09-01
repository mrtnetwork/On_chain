import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/ed25519/constant.dart';

class Ed25519ProgramInstruction implements ProgramLayoutInstruction {
  @override
  final dynamic insturction;
  @override
  final String name;
  const Ed25519ProgramInstruction(this.insturction, this.name);
  static const Ed25519ProgramInstruction ed25519 =
      Ed25519ProgramInstruction(null, "Ed25519");

  static const List<Ed25519ProgramInstruction> values = [ed25519];

  @override
  String get programName => "ED25519";
  @override
  SolAddress get programAddress => Ed25519ProgramConst.programId;
}
