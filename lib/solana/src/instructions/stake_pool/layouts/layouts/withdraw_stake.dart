import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:blockchain_utils/layout/layout.dart';
import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

/// Withdraw the token from the pool at the current ratio layout.
class StakePoolWithdrawStakeLayout extends StakePoolProgramLayout {
  /// amount of pool tokens to withdraw
  final BigInt poolTokens;
  StakePoolWithdrawStakeLayout({required this.poolTokens});

  factory StakePoolWithdrawStakeLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction.withdrawStake.insturction);
    return StakePoolWithdrawStakeLayout(poolTokens: decode["poolTokens"]);
  }

  @override
  int get instruction => StakePoolProgramInstruction.withdrawStake.insturction;
  static final StructLayout _layout = LayoutConst.struct([
    LayoutConst.u8(property: "instruction"),
    LayoutConst.ns64(property: "poolTokens")
  ]);
  @override
  StructLayout get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {"poolTokens": poolTokens};
  }
}
