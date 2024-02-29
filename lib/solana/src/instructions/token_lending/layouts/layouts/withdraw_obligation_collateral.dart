import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Withdraw collateral from an obligation layout
class TokenLendingWithdrawObligationCollateralLayout
    extends TokenLendingProgramLayout {
  /// Amount of collateral tokens to withdraw - u64::MAX for up to 100% of
  /// deposited amount
  final BigInt collateralAmount;
  const TokenLendingWithdrawObligationCollateralLayout(
      {required this.collateralAmount});

  factory TokenLendingWithdrawObligationCollateralLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction
            .withdrawObligationCollateral.insturction);
    return TokenLendingWithdrawObligationCollateralLayout(
        collateralAmount: decode["collateralAmount"]);
  }
  static final Structure _layout = LayoutUtils.struct(
      [LayoutUtils.u8("instruction"), LayoutUtils.u64("collateralAmount")]);
  @override
  Structure get layout => _layout;

  @override
  int get instruction =>
      TokenLendingProgramInstruction.withdrawObligationCollateral.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"collateralAmount": collateralAmount};
  }
}
