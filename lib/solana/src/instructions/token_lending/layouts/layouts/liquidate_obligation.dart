import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Repay borrowed liquidity to a reserve to receive collateral at a
/// discount from an unhealthy obligation layout.
class TokenLendingLiquidateObligationLayout extends TokenLendingProgramLayout {
  /// Amount of liquidity to repay - u64::MAX for up to 100% of borrowed
  /// amount
  final BigInt liquidityAmount;
  const TokenLendingLiquidateObligationLayout({required this.liquidityAmount});

  factory TokenLendingLiquidateObligationLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            TokenLendingProgramInstruction.liquidateObligation.insturction);
    return TokenLendingLiquidateObligationLayout(
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
      TokenLendingProgramInstruction.liquidateObligation.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"liquidityAmount": liquidityAmount};
  }
}
