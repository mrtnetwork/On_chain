import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/vote/constant.dart';

class VoteProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const VoteProgramInstruction(this.insturction, this.name);
  static const VoteProgramInstruction initializeAccount =
      VoteProgramInstruction(0, 'InitializeAccount');
  static const VoteProgramInstruction authorize =
      VoteProgramInstruction(1, 'Authorize');
  static const VoteProgramInstruction withdraw =
      VoteProgramInstruction(3, 'Withdraw');
  static const VoteProgramInstruction authorizeWithSeed =
      VoteProgramInstruction(10, 'AuthorizeWithSeed');
  static const List<VoteProgramInstruction> values = [
    initializeAccount,
    authorize,
    withdraw,
    authorizeWithSeed
  ];
  static VoteProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } catch (_) {
      return null;
    }
  }

  @override
  String get programName => 'Vote';
  @override
  SolAddress get programAddress => VoteProgramConst.programId;
}
