import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

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
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.ns64("poolTokens")]);
  @override
  Structure get layout => _layout;

  @override
  Map<String, dynamic> serialize() {
    return {"poolTokens": poolTokens};
  }
}
