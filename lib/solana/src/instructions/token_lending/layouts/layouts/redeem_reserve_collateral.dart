import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Redeem collateral from a reserve in exchange for liquidity layout.
class TokenLendingRedeemReserveCollateralLayout
    extends TokenLendingProgramLayout {
  /// Amount of collateral tokens to redeem in exchange for liquidity
  final BigInt collateralAmount;
  const TokenLendingRedeemReserveCollateralLayout(
      {required this.collateralAmount});

  factory TokenLendingRedeemReserveCollateralLayout.fromBuffer(List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction:
            TokenLendingProgramInstruction.redeemReserveCollateral.insturction);
    return TokenLendingRedeemReserveCollateralLayout(
        collateralAmount: decode["collateralAmount"]);
  }

  static final Structure _layout = LayoutUtils.struct([
    LayoutUtils.u8("instruction"),
    LayoutUtils.u64("collateralAmount"),
  ]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      TokenLendingProgramInstruction.redeemReserveCollateral.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"collateralAmount": collateralAmount};
  }
}
