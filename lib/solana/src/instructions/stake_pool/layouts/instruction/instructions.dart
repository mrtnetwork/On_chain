import 'package:on_chain/solana/src/layout/layout.dart';

class StakePoolProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const StakePoolProgramInstruction(this.insturction, this.name);
  static const StakePoolProgramInstruction decreaseValidatorStake =
      StakePoolProgramInstruction(3, "DecreaseValidatorStake");

  static const StakePoolProgramInstruction increaseValidatorStake =
      StakePoolProgramInstruction(4, "IncreaseValidatorStake");
  static const StakePoolProgramInstruction updateValidatorListBalance =
      StakePoolProgramInstruction(6, "UpdateValidatorListBalance");
  static const StakePoolProgramInstruction updateStakePoolBalance =
      StakePoolProgramInstruction(7, "UpdateStakePoolBalance");
  static const StakePoolProgramInstruction cleanupRemovedValidatorEntries =
      StakePoolProgramInstruction(8, "CleanupRemovedValidatorEntries");
  static const StakePoolProgramInstruction depositStake =
      StakePoolProgramInstruction(9, "DepositStake");
  static const StakePoolProgramInstruction withdrawStake =
      StakePoolProgramInstruction(10, "WithdrawStake");
  static const StakePoolProgramInstruction depositSol =
      StakePoolProgramInstruction(14, "DepositSol");
  static const StakePoolProgramInstruction withdrawSol =
      StakePoolProgramInstruction(16, "WithdrawSol");

  static const StakePoolProgramInstruction createTokenMetaData =
      StakePoolProgramInstruction(17, "CreateTokenMetaData");
  static const StakePoolProgramInstruction updateTokenMetaData =
      StakePoolProgramInstruction(18, "UpdateTokenMetaData");
  static const StakePoolProgramInstruction increaseAdditionalValidatorStake =
      StakePoolProgramInstruction(19, "IncreaseAdditionalValidatorStake");
  static const StakePoolProgramInstruction decreaseAdditionalValidatorStake =
      StakePoolProgramInstruction(20, "DecreaseAdditionalValidatorStake");
  static const StakePoolProgramInstruction decreaseValidatorStakeWithReserve =
      StakePoolProgramInstruction(21, "DecreaseValidatorStakeWithReserve");
  static const StakePoolProgramInstruction redelegate =
      StakePoolProgramInstruction(22, "Redelegate");
  static const List<StakePoolProgramInstruction> values = [
    decreaseValidatorStake,
    increaseValidatorStake,
    updateValidatorListBalance,
    updateStakePoolBalance,
    cleanupRemovedValidatorEntries,
    depositStake,
    withdrawStake,
    depositSol,
    withdrawSol,
    createTokenMetaData,
    updateTokenMetaData,
    increaseAdditionalValidatorStake,
    decreaseAdditionalValidatorStake,
    decreaseValidatorStakeWithReserve,
    redelegate,
  ];
  static StakePoolProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } on StateError {
      return null;
    }
  }
}
