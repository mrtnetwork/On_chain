import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/secp256k1/constant.dart';

class Secp256k1ProgramInstruction implements ProgramLayoutInstruction {
  @override
  final dynamic insturction;
  @override
  final String name;
  const Secp256k1ProgramInstruction(this.insturction, this.name);
  static const Secp256k1ProgramInstruction secp256k1 =
      Secp256k1ProgramInstruction(null, 'Secp256k1');

  static const List<Secp256k1ProgramInstruction> values = [
    secp256k1,
  ];

  @override
  String get programName => 'Secp256k1';
  @override
  SolAddress get programAddress => Secp256k1ProgramConst.programId;
}
