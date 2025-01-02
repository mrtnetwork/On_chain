import 'package:on_chain/solana/solana.dart';
import 'package:test/test.dart';

void main() {
  group('Token Swap layoyt', () {
    _crate();
    _swap();
    _deposit();
    _withdraw();
    _depoitSingleToken();
    _withdrawSingle();
  });
}

void _crate() {
  test('create_1', () {
    final layout = SPLTokenSwapInitSwapLayout(
        fees: TokenSwapFees(
          tradeFeeNumerator: BigInt.from(10),
          hostFeeDenominator: BigInt.from(10),
          tradeFeeDenominator: BigInt.from(10),
          hostFeeNumerator: BigInt.from(10),
          ownerTradeFeeDenominator: BigInt.from(10),
          ownerTradeFeeNumerator: BigInt.from(10),
          ownerWithdrawFeeDenominator: BigInt.from(10),
          ownerWithdrawFeeNumerator: BigInt.from(10),
        ),
        curveType: SPLTokenSwapCurveType.constantProduct,
        curveParameters: List<int>.filled(10, 0));
    expect(layout.toHex(),
        '000a000000000000000a000000000000000a000000000000000a000000000000000a000000000000000a000000000000000a000000000000000a00000000000000000000000000000000000000000000000000000000000000000000000000000000');
    final decode = SPLTokenSwapInitSwapLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('create_3', () {
    final layout = SPLTokenSwapInitSwapLayout(
        fees: TokenSwapFees(
          tradeFeeNumerator: BigInt.from(65001),
          hostFeeDenominator: BigInt.from(65001),
          tradeFeeDenominator: BigInt.from(65001),
          hostFeeNumerator: BigInt.from(65001),
          ownerTradeFeeDenominator: BigInt.from(65001),
          ownerTradeFeeNumerator: BigInt.from(65001),
          ownerWithdrawFeeDenominator: BigInt.from(65001),
          ownerWithdrawFeeNumerator: BigInt.from(65001),
        ),
        curveType: SPLTokenSwapCurveType.constantPrice,
        curveParameters: List<int>.filled(10, 0));

    expect(layout.toHex(),
        '00e9fd000000000000e9fd000000000000e9fd000000000000e9fd000000000000e9fd000000000000e9fd000000000000e9fd000000000000e9fd000000000000010000000000000000000000000000000000000000000000000000000000000000');
    final decode = SPLTokenSwapInitSwapLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _swap() {
  test('swap', () {
    final layout = SPLTokenSwapSwapLayout(
        amountIn: BigInt.from(100), minimumAmountOut: BigInt.from(200));
    expect(layout.toHex(), '016400000000000000c800000000000000');
    final decode = SPLTokenSwapSwapLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('swap_1', () {
    final layout = SPLTokenSwapSwapLayout(
        amountIn: BigInt.from(68646456), minimumAmountOut: BigInt.from(0));
    expect(layout.toHex(), '0138761704000000000000000000000000');
    final decode = SPLTokenSwapSwapLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('swap_2', () {
    final layout = SPLTokenSwapSwapLayout(
        amountIn: BigInt.from(0), minimumAmountOut: BigInt.from(0));
    expect(layout.toHex(), '0100000000000000000000000000000000');
    final decode = SPLTokenSwapSwapLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _deposit() {
  test('deposit', () {
    final layout = SPLTokenSwapDepositLayout(
        poolTokenAmount: BigInt.from(100),
        maximumTokenA: BigInt.from(200),
        maximumTokenB: BigInt.from(300));

    expect(
        layout.toHex(), '026400000000000000c8000000000000002c01000000000000');
    final decode = SPLTokenSwapDepositLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('deposit_1', () {
    final layout = SPLTokenSwapDepositLayout(
        poolTokenAmount: BigInt.from(0),
        maximumTokenA: BigInt.from(0),
        maximumTokenB: BigInt.from(0));

    expect(
        layout.toHex(), '02000000000000000000000000000000000000000000000000');
    final decode = SPLTokenSwapDepositLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('deposit_3', () {
    final layout = SPLTokenSwapDepositLayout(
        poolTokenAmount: BigInt.from(1),
        maximumTokenA: BigInt.from(1),
        maximumTokenB: BigInt.from(1));

    expect(
        layout.toHex(), '02010000000000000001000000000000000100000000000000');
    final decode = SPLTokenSwapDepositLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _withdraw() {
  test('withdraw', () {
    final layout = SPLTokenSwapWithdrawLayout(
        poolTokenAmount: BigInt.from(1),
        minimumTokenA: BigInt.from(1),
        minimumTokenB: BigInt.from(1));
    expect(
        layout.toHex(), '03010000000000000001000000000000000100000000000000');
    final decode = SPLTokenSwapWithdrawLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('withdraw_1', () {
    final layout = SPLTokenSwapWithdrawLayout(
        poolTokenAmount: BigInt.from(0),
        minimumTokenA: BigInt.from(1000),
        minimumTokenB: BigInt.from(10000));
    expect(
        layout.toHex(), '030000000000000000e8030000000000001027000000000000');
    final decode = SPLTokenSwapWithdrawLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('withdraw_3', () {
    final layout = SPLTokenSwapWithdrawLayout(
        poolTokenAmount: BigInt.from(0),
        minimumTokenA: BigInt.from(0),
        minimumTokenB: BigInt.from(1000000));
    expect(
        layout.toHex(), '030000000000000000000000000000000040420f0000000000');
    final decode = SPLTokenSwapWithdrawLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _depoitSingleToken() {
  test('depoitSingleToken', () {
    final layout = SPLTokenSwapDepositSingleTokenLayout(
      sourceTokenAmount: BigInt.from(100),
      minimumPoolTokenAmount: BigInt.from(1000),
    );
    expect(layout.toHex(), '046400000000000000e803000000000000');
    final decode =
        SPLTokenSwapDepositSingleTokenLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('depoitSingleToken_1', () {
    final layout = SPLTokenSwapDepositSingleTokenLayout(
      sourceTokenAmount: BigInt.from(0),
      minimumPoolTokenAmount: BigInt.from(0),
    );
    expect(layout.toHex(), '0400000000000000000000000000000000');
    final decode =
        SPLTokenSwapDepositSingleTokenLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('depoitSingleToken_2', () {
    final layout = SPLTokenSwapDepositSingleTokenLayout(
      sourceTokenAmount: BigInt.from(100000000000000),
      minimumPoolTokenAmount: BigInt.from(0),
    );
    expect(layout.toHex(), '0400407a10f35a00000000000000000000');
    final decode =
        SPLTokenSwapDepositSingleTokenLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _withdrawSingle() {
  test('withdrawSingleToken', () {
    final layout = SPLTokenSwapWithdrawSingleTokenLayout(
      destinationTokenAmount: BigInt.from(1000),
      maximumPoolTokenAmount: BigInt.from(1000),
    );
    expect(layout.toHex(), '05e803000000000000e803000000000000');
    final decode =
        SPLTokenSwapWithdrawSingleTokenLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}
