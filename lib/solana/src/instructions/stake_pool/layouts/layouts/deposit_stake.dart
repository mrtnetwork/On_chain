import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Deposit some stake into the pool layout
class StakePoolDepositStakeLayout extends StakePoolProgramLayout {
  const StakePoolDepositStakeLayout();

  factory StakePoolDepositStakeLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction.depositStake.insturction);
    return StakePoolDepositStakeLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;
  @override
  int get instruction => StakePoolProgramInstruction.depositStake.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
