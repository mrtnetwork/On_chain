import 'package:on_chain/solana/src/instructions/stake_pool/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Withdraw the token from the pool layout.
class StakePoolWithdrawSolLayout extends StakePoolProgramLayout {
  final BigInt poolTokens;
  const StakePoolWithdrawSolLayout({required this.poolTokens});

  factory StakePoolWithdrawSolLayout.fromBuffer(List<int> bytes) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: bytes,
        instruction: StakePoolProgramInstruction.withdrawSol.insturction);
    return StakePoolWithdrawSolLayout(poolTokens: decode["poolTokens"]);
  }

  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.ns64("poolTokens")]);
  @override
  Structure get layout => _layout;
  @override
  int get instruction => StakePoolProgramInstruction.withdrawSol.insturction;
  @override
  Map<String, dynamic> serialize() {
    return {"poolTokens": poolTokens};
  }
}
