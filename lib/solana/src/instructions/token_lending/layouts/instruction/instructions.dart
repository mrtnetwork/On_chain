import 'package:on_chain/solana/src/borsh_serialization/program_layout.dart';

class TokenLendingProgramInstruction implements ProgramLayoutInstruction {
  @override
  final int insturction;
  @override
  final String name;
  const TokenLendingProgramInstruction(this.insturction, this.name);
  static const TokenLendingProgramInstruction initLendingMarket =
      TokenLendingProgramInstruction(0, "InitLendingMarket");

  static const TokenLendingProgramInstruction setLendingMarketOwner =
      TokenLendingProgramInstruction(1, "SetLendingMarketOwner");
  static const TokenLendingProgramInstruction initReserve =
      TokenLendingProgramInstruction(2, "InitReserve");
  static const TokenLendingProgramInstruction refreshReserve =
      TokenLendingProgramInstruction(3, "RefreshReserve");
  static const TokenLendingProgramInstruction depositReserveLiquidity =
      TokenLendingProgramInstruction(4, "DepositReserveLiquidity");
  static const TokenLendingProgramInstruction redeemReserveCollateral =
      TokenLendingProgramInstruction(5, "RedeemReserveCollateral");
  static const TokenLendingProgramInstruction initObligation =
      TokenLendingProgramInstruction(6, "InitObligation");
  static const TokenLendingProgramInstruction refreshObligation =
      TokenLendingProgramInstruction(7, "RefreshObligation");
  static const TokenLendingProgramInstruction depositObligationCollateral =
      TokenLendingProgramInstruction(8, "DepositObligationCollateral");
  static const TokenLendingProgramInstruction withdrawObligationCollateral =
      TokenLendingProgramInstruction(9, "WithdrawObligationCollateral");

  static const TokenLendingProgramInstruction borrowObligationLiquidity =
      TokenLendingProgramInstruction(10, "BorrowObligationLiquidity");
  static const TokenLendingProgramInstruction repayObligationLiquidity =
      TokenLendingProgramInstruction(11, "RepayObligationLiquidity");
  static const TokenLendingProgramInstruction liquidateObligation =
      TokenLendingProgramInstruction(12, "LiquidateObligation");
  static const TokenLendingProgramInstruction flashLoan =
      TokenLendingProgramInstruction(13, "FlashLoan");
  static const List<TokenLendingProgramInstruction> values = [
    initLendingMarket,
    setLendingMarketOwner,
    initReserve,
    refreshReserve,
    depositReserveLiquidity,
    redeemReserveCollateral,
    initObligation,
    refreshObligation,
    depositObligationCollateral,
    withdrawObligationCollateral,
    borrowObligationLiquidity,
    repayObligationLiquidity,
    liquidateObligation,
    flashLoan
  ];
  static TokenLendingProgramInstruction? getInstruction(dynamic value) {
    try {
      return values.firstWhere((element) => element.insturction == value);
    } catch (e) {
      return null;
    }
  }
}
