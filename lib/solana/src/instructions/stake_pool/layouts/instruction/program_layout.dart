import 'package:on_chain/solana/src/instructions/stake_pool/layouts/layouts.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

abstract class StakePoolProgramLayout extends ProgramLayout {
  const StakePoolProgramLayout();
  static final StructLayout _layout =
      LayoutConst.struct([LayoutConst.u8(property: "instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    try {
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      final instruction =
          StakePoolProgramInstruction.getInstruction(decode["instruction"]);
      switch (instruction) {
        case StakePoolProgramInstruction.cleanupRemovedValidatorEntries:
          return StakePoolCleanupRemovedValidatorEntriesLayout.fromBuffer(data);
        case StakePoolProgramInstruction.decreaseAdditionalValidatorStake:
          return StakePoolDecreaseAdditionalValidatorStakeLayout.fromBuffer(
              data);
        case StakePoolProgramInstruction.decreaseValidatorStake:
          return StakePoolDecreaseValidatorStakeLayout.fromBuffer(data);
        case StakePoolProgramInstruction.increaseValidatorStake:
          return StakePoolIncreaseValidatorStakeLayout.fromBuffer(data);
        case StakePoolProgramInstruction.updateValidatorListBalance:
          return StakePoolUpdateValidatorListBalanceLayout.fromBuffer(data);
        case StakePoolProgramInstruction.updateStakePoolBalance:
          return StakePoolUpdateStakePoolBalanceLayout.fromBuffer(data);
        case StakePoolProgramInstruction.depositStake:
          return StakePoolDepositStakeLayout.fromBuffer(data);
        case StakePoolProgramInstruction.withdrawStake:
          return StakePoolDepositStakeLayout.fromBuffer(data);
        case StakePoolProgramInstruction.depositSol:
          return StakePoolDepositSolLayout.fromBuffer(data);
        case StakePoolProgramInstruction.withdrawSol:
          return StakePoolWithdrawSolLayout.fromBuffer(data);
        case StakePoolProgramInstruction.increaseAdditionalValidatorStake:
          return StakePoolIncreaseAdditionalValidatorStakeLayout.fromBuffer(
              data);
        case StakePoolProgramInstruction.decreaseValidatorStakeWithReserve:
          return StakePoolDecreaseValidatorStakeWithReserveLayout.fromBuffer(
              data);
        case StakePoolProgramInstruction.redelegate:
          return StakePoolReDelegateLayout.fromBuffer(data);
        case StakePoolProgramInstruction.createTokenMetaData:
          return StakePoolReDelegateLayout.fromBuffer(data);
        case StakePoolProgramInstruction.updateTokenMetaData:
          return StakePoolUpdateTokenMetaDataLayout.fromBuffer(data);
        default:
          return UnknownProgramLayout(data);
      }
    } catch (e) {
      return UnknownProgramLayout(data);
    }
  }
}
