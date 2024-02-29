import 'package:on_chain/solana/src/instructions/token_lending/layouts/instruction/instruction.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

/// Deposit collateral to an obligation layout.
class TokenLendingDepositObligationCollateralLayout
    extends TokenLendingProgramLayout {
  /// Amount of collateral tokens to deposit
  final BigInt collateralAmount;
  const TokenLendingDepositObligationCollateralLayout(
      {required this.collateralAmount});

  factory TokenLendingDepositObligationCollateralLayout.fromBuffer(
      List<int> data) {
    final decode = ProgramLayout.decodeAndValidateStruct(
        layout: _layout,
        bytes: data,
        instruction: TokenLendingProgramInstruction
            .depositObligationCollateral.insturction);
    return TokenLendingDepositObligationCollateralLayout(
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
      TokenLendingProgramInstruction.depositObligationCollateral.insturction;

  @override
  Map<String, dynamic> serialize() {
    return {"collateralAmount": collateralAmount};
  }
}
