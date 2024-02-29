import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Updates total pool balance based on balances layout.
class StakePoolUpdateStakePoolBalanceLayout extends StakePoolProgramLayout {
  const StakePoolUpdateStakePoolBalanceLayout();

  factory StakePoolUpdateStakePoolBalanceLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            StakePoolProgramInstruction.updateStakePoolBalance.insturction);
    return StakePoolUpdateStakePoolBalanceLayout();
  }
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);

  @override
  Structure get layout => _layout;
  @override
  int get instruction =>
      StakePoolProgramInstruction.updateStakePoolBalance.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
