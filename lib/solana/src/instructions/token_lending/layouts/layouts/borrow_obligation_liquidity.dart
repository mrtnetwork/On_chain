import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Borrow liquidity from a reserve by depositing collateral tokens layout.
class TokenLendingBorrowObligationLiquidityLayout
    extends TokenLendingProgramLayout {
  /// Amount of liquidity to borrow.
  final BigInt liquidityAmount;
  const TokenLendingBorrowObligationLiquidityLayout(
      {required this.liquidityAmount});

  factory TokenLendingBorrowObligationLiquidityLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction
            .borrowObligationLiquidity.insturction);
    return TokenLendingBorrowObligationLiquidityLayout(
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
      TokenLendingProgramInstruction.borrowObligationLiquidity.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"liquidityAmount": liquidityAmount};
  }
}
