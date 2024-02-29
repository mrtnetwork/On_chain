import 'package:on_chain/solana/src/instructions/token_lending/layouts/layouts.dart';
import 'package:on_chain/solana/src/layout/layout.dart';

abstract class TokenLendingProgramLayout extends ProgramLayout {
  const TokenLendingProgramLayout();
  static final Structure _layout =
      LayoutUtils.struct([LayoutUtils.u8("instruction")]);
  static ProgramLayout fromBytes(List<int> data) {
    try {
      final decode =
          ProgramLayout.decodeAndValidateStruct(layout: _layout, bytes: data);
      final instruction =
          TokenLendingProgramInstruction.getInstruction(decode["instruction"]);
      switch (instruction) {
        case TokenLendingProgramInstruction.borrowObligationLiquidity:
          return TokenLendingBorrowObligationLiquidityLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.depositObligationCollateral:
          return TokenLendingDepositObligationCollateralLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.depositReserveLiquidity:
          return TokenLendingDepositReserveLiquidityLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.flashLoan:
          return TokenLendingFlashLoanLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.initObligation:
          return TokenLendingInitObligationLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.initLendingMarket:
          return TokenLendingInitLendingMarketLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.initReserve:
          return TokenLendingInitReserveLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.liquidateObligation:
          return TokenLendingLiquidateObligationLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.redeemReserveCollateral:
          return TokenLendingRedeemReserveCollateralLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.refreshObligation:
          return TokenLendingRefreshObligationLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.refreshReserve:
          return TokenLendingRefreshReserveLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.repayObligationLiquidity:
          return TokenLendingRepayObligationLiquidityLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.setLendingMarketOwner:
          return TokenLendingSetLendingMarketOwnerLayout.fromBuffer(data);
        case TokenLendingProgramInstruction.withdrawObligationCollateral:
          return TokenLendingWithdrawObligationCollateralLayout.fromBuffer(
              data);
        default:
          return UnknownProgramLayout(data);
      }
    } catch (e) {
      return UnknownProgramLayout(data);
    }
  }
}
