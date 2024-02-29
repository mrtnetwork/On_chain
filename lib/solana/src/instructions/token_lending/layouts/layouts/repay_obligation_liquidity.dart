import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Repay borrowed liquidity to a reserve account.
class TokenLendingRepayObligationLiquidityLayout
    extends TokenLendingProgramLayout {
  /// Amount of liquidity to repay
  final BigInt liquidityAmount;
  const TokenLendingRepayObligationLiquidityLayout(
      {required this.liquidityAmount});

  factory TokenLendingRepayObligationLiquidityLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction
            .repayObligationLiquidity.insturction);
    return TokenLendingRepayObligationLiquidityLayout(
        liquidityAmount: decode["liquidityAmount"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u64("liquidityAmount"),
  ]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      TokenLendingProgramInstruction.repayObligationLiquidity.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"liquidityAmount": liquidityAmount};
  }
}
