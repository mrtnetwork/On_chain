import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

void main() {
  group("TokenLendingProgram layout", () {
    _obligationLiquidity();
    _depositObligationCollateral();
    _depositReserveLiquidity();
    _depositReserveLiquidity();
    _initLendingMarket();
    _initObligation();
    initReserve();
    _liquidateObligation();
    _redeemReserveCollateral();
    _refreshObligation();
    _refreshReserve();
    _repayObligationLiquidity();
    _withdrawObligationCollateral();
  });
}

void _obligationLiquidity() {
  test("obligationLiquidity", () {
    final layout = TokenLendingBorrowObligationLiquidityLayout(
        liquidityAmount: BigInt.from(12));
    expect(layout.toHex(), "0a0c00000000000000");
    final decode = TokenLendingBorrowObligationLiquidityLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("obligationLiquidity_1", () {
    final layout = TokenLendingBorrowObligationLiquidityLayout(
        liquidityAmount: BigInt.from(0));
    expect(layout.toHex(), "0a0000000000000000");
    final decode = TokenLendingBorrowObligationLiquidityLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _depositObligationCollateral() {
  test("depositObligationCollateral", () {
    final layout = TokenLendingDepositObligationCollateralLayout(
        collateralAmount: BigInt.from(80000000));
    expect(layout.toHex(), "0800b4c40400000000");
    final decode = TokenLendingDepositObligationCollateralLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("depositObligationCollateral_1", () {
    final layout = TokenLendingDepositObligationCollateralLayout(
        collateralAmount: BigInt.from(1984655));
    expect(layout.toHex(), "088f481e0000000000");
    final decode = TokenLendingDepositObligationCollateralLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _depositReserveLiquidity() {
  test("depositReserveLiquidity", () {
    final layout = TokenLendingDepositReserveLiquidityLayout(
        liquidityAmount: BigInt.from(25000));
    expect(layout.toHex(), "04a861000000000000");
    final decode =
        TokenLendingDepositReserveLiquidityLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _initLendingMarket() {
  test("initLendingMarket", () {
    final layout = TokenLendingInitLendingMarketLayout(
        owner: SolAddress.unchecked(
            "HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf"),
        quoteCurrency: List<int>.filled(32, 0));
    expect(layout.toHex(),
        "00f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd760000000000000000000000000000000000000000000000000000000000000000");
    final decode =
        TokenLendingInitLendingMarketLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _initObligation() {
  test("initObligation", () {
    final layout = TokenLendingInitObligationLayout();
    expect(layout.toHex(), "06");
    final decode =
        TokenLendingInitObligationLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void initReserve() {
  test("initReserve", () {
    final layout = TokenLendingInitReserveLayout(
        liquidityAmount: BigInt.from(12),
        config: ReserveConfig(
            optimalUtilizationRate: 1,
            loanToValueRatio: 1,
            liquidationBonus: 1,
            liquidationThreshold: 1,
            minBorrowRate: 1,
            optimalBorrowRate: 1,
            maxBorrowRate: 1,
            feesConfig: ReserveFeesConfig(
                borrowFeeWad: BigInt.one,
                flashLoanFeeWad: BigInt.one,
                hostFeePercentage: 2)));
    expect(layout.toHex(),
        "020c00000000000000010101010101010100000000000000010000000000000002");
    final decode = TokenLendingInitReserveLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test("initReserve_1", () {
    final layout = TokenLendingInitReserveLayout(
        liquidityAmount: BigInt.from(6580),
        config: ReserveConfig(
            optimalUtilizationRate: 100,
            loanToValueRatio: 200,
            liquidationBonus: 250,
            liquidationThreshold: 12,
            minBorrowRate: 13,
            optimalBorrowRate: 41,
            maxBorrowRate: 12,
            feesConfig: ReserveFeesConfig(
                borrowFeeWad: BigInt.from(10000),
                flashLoanFeeWad: BigInt.from(10000),
                hostFeePercentage: 2)));
    expect(layout.toHex(),
        "02b41900000000000064c8fa0c0d290c1027000000000000102700000000000002");
    final decode = TokenLendingInitReserveLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _liquidateObligation() {
  test("liquidateObligation", () {
    final layout = TokenLendingLiquidateObligationLayout(
        liquidityAmount: BigInt.from(55522));
    expect(layout.toHex(), "0ce2d8000000000000");
    final decode =
        TokenLendingLiquidateObligationLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _redeemReserveCollateral() {
  test("redeemReserveCollateral", () {
    final layout = TokenLendingRedeemReserveCollateralLayout(
        collateralAmount: BigInt.from(80000));
    expect(layout.toHex(), "058038010000000000");
    final decode =
        TokenLendingRedeemReserveCollateralLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _refreshObligation() {
  test("refreshObligation", () {
    final layout = TokenLendingRefreshObligationLayout();
    expect(layout.toHex(), "07");
    final decode =
        TokenLendingRefreshObligationLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _refreshReserve() {
  test("refreshReserve", () {
    final layout = TokenLendingRefreshReserveLayout();
    expect(layout.toHex(), "03");
    final decode =
        TokenLendingRefreshReserveLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _repayObligationLiquidity() {
  test("repayObligationLiquidity", () {
    final layout = TokenLendingRepayObligationLiquidityLayout(
        liquidityAmount: BigInt.from(80000000));
    expect(layout.toHex(), "0b00b4c40400000000");
    final decode =
        TokenLendingRepayObligationLiquidityLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _withdrawObligationCollateral() {
  test("withdrawObligationCollateral", () {
    final layout = TokenLendingWithdrawObligationCollateralLayout(
        collateralAmount: BigInt.from(80000000));
    expect(layout.toHex(), "0900b4c40400000000");
    final decode = TokenLendingWithdrawObligationCollateralLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}
