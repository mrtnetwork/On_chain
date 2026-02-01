import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Updates total pool balance based on balances layout.
class StakePoolUpdateStakePoolBalanceLayout extends StakePoolProgramLayout {
  const StakePoolUpdateStakePoolBalanceLayout();

  factory StakePoolUpdateStakePoolBalanceLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction:
            StakePoolProgramInstruction.updateStakePoolBalance.insturction);
    return const StakePoolUpdateStakePoolBalanceLayout();
  }
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;
  @override
  StakePoolProgramInstruction get instruction =>
      StakePoolProgramInstruction.updateStakePoolBalance;
  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
