import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Deposit liquidity into a reserve in exchange for collateral layout.
class TokenLendingDepositReserveLiquidityLayout
    extends TokenLendingProgramLayout {
  /// Amount of liquidity to deposit in exchange for collateral tokens
  final BigInt liquidityAmount;
  const TokenLendingDepositReserveLiquidityLayout(
      {required this.liquidityAmount});

  factory TokenLendingDepositReserveLiquidityLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            TokenLendingProgramInstruction.depositReserveLiquidity.insturction);
    return TokenLendingDepositReserveLiquidityLayout(
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
      TokenLendingProgramInstruction.depositReserveLiquidity.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"liquidityAmount": liquidityAmount};
  }
}
