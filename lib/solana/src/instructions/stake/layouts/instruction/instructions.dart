import 'package:on_chain/solana/src/address/sol_address.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';
import 'package:on_chain/solana/src/instructions/stake/constant.dart';

class StakeProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const StakeProgramInstruction(this.insturction, this.name);
  static const StakeProgramInstruction initialize =
      StakeProgramInstruction(0, 'Initialize');
  static const StakeProgramInstruction authorize =
      StakeProgramInstruction(1, 'Authorize');
  static const StakeProgramInstruction delegate =
      StakeProgramInstruction(2, 'Delegate');
  static const StakeProgramInstruction split =
      StakeProgramInstruction(3, 'Split');
  static const StakeProgramInstruction withdraw =
      StakeProgramInstruction(4, 'Withdraw');
  static const StakeProgramInstruction deactivate =
      StakeProgramInstruction(5, 'Deactivate');
  static const StakeProgramInstruction merge =
      StakeProgramInstruction(7, 'Merge');
  static const StakeProgramInstruction authorizeWithSeed =
      StakeProgramInstruction(8, 'AuthorizeWithSeed');
  static const List<StakeProgramInstruction> values = [
    initialize,
    authorize,
    delegate,
    split,
    withdraw,
    deactivate,
    merge,
    authorizeWithSeed
  ];
  static StakeProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } catch (_) {
      return null;
    }
  }

  @override
  String get programName => 'Stake';
  @override
  SolAddress get programAddress => StakeProgramConst.programId;
}
