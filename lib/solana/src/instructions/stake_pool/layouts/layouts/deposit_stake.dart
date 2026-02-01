import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Deposit some stake into the pool layout
class StakePoolDepositStakeLayout extends StakePoolProgramLayout {
  const StakePoolDepositStakeLayout();

  factory StakePoolDepositStakeLayout.fromBuffer(List<int> bytes) {
    ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction.depositStake.insturction);
    return const StakePoolDepositStakeLayout();
  }
  static StructLayout get _layout =>
      LayoutConst.struct([LayoutConst.u8(property: 'instruction')]);

  @override
  StructLayout get layout => _layout;
  @override
  StakePoolProgramInstruction get instruction =>
      StakePoolProgramInstruction.depositStake;

  @override
  Map<String, dynamic> serialize() {
    return {};
  }
}
