import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group('stake pool layout', () {
    _updateValidatorListBalance();
    _updateStakePoolBalance();
    _cleanupRemovedValidatorEntries();
    _increaseValidatorStake();
    _increaseAdditionalValidatorStake();
    _decreaseValidatorStake();
    _decreaseValidatorStakeWithReserve();
    _decreaseAdditionalValidatorStake();
    _depositStake();
    _depositSol();
    _withdrawStake();
    _withdrawSol();
    _redelegate();
    _createTokenMetadata();
    _updateTokenMetadata();
  });
}

void _updateValidatorListBalance() {
  test('updateValidatorListBalance', () {
    const layout = StakePoolUpdateValidatorListBalanceLayout(
        noMerge: false, startIndex: 12);
    expect(layout.toHex(), '060c00000000');
    final decode =
        StakePoolUpdateValidatorListBalanceLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('updateValidatorListBalance_1', () {
    const layout = StakePoolUpdateValidatorListBalanceLayout(
        noMerge: true, startIndex: 1000);
    expect(layout.toHex(), '06e803000001');
    final decode =
        StakePoolUpdateValidatorListBalanceLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _updateStakePoolBalance() {
  test('updateStakePoolBalance', () {
    const layout = StakePoolUpdateStakePoolBalanceLayout();
    expect(layout.toHex(), '07');
    final decode =
        StakePoolUpdateStakePoolBalanceLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

// StakePoolCleanupRemovedValidatorEntriesLayout()
void _cleanupRemovedValidatorEntries() {
  test('cleanupRemovedValidatorEntries', () {
    const layout = StakePoolCleanupRemovedValidatorEntriesLayout();
    expect(layout.toHex(), '08');
    final decode = StakePoolCleanupRemovedValidatorEntriesLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _increaseValidatorStake() {
  test('increaseValidatorStake', () {
    final layout = StakePoolIncreaseValidatorStakeLayout(
        lamports: BigInt.from(15000), transientStakeSeed: BigInt.from(100));
    expect(layout.toHex(), '04983a0000000000006400000000000000');
    final decode =
        StakePoolIncreaseValidatorStakeLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('increaseValidatorStake_1', () {
    final layout = StakePoolIncreaseValidatorStakeLayout(
        lamports: BigInt.from(1), transientStakeSeed: BigInt.from(1));
    expect(layout.toHex(), '0401000000000000000100000000000000');
    final decode =
        StakePoolIncreaseValidatorStakeLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _increaseAdditionalValidatorStake() {
  test('_increaseAdditionalValidatorStake', () {
    final layout = StakePoolIncreaseAdditionalValidatorStakeLayout(
        lamports: BigInt.from(1),
        transientStakeSeed: BigInt.from(1),
        ephemeralStakeSeed: BigInt.from(150));
    expect(
        layout.toHex(), '13010000000000000001000000000000009600000000000000');
    final decode = StakePoolIncreaseAdditionalValidatorStakeLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('increaseValidatorStake_1', () {
    final layout = StakePoolIncreaseAdditionalValidatorStakeLayout(
        lamports: BigInt.from(1500),
        transientStakeSeed: BigInt.from(15000),
        ephemeralStakeSeed: BigInt.from(150));
    expect(
        layout.toHex(), '13dc05000000000000983a0000000000009600000000000000');
    final decode = StakePoolIncreaseAdditionalValidatorStakeLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _decreaseValidatorStake() {
  test('decreaseValidatorStake', () {
    final layout = StakePoolDecreaseValidatorStakeLayout(
        lamports: BigInt.from(1500), transientStakeSeed: BigInt.from(15000));
    expect(layout.toHex(), '03dc05000000000000983a000000000000');
    final decode =
        StakePoolDecreaseValidatorStakeLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _decreaseValidatorStakeWithReserve() {
  test('decreaseValidatorStakeWithReserve', () {
    final layout = StakePoolDecreaseValidatorStakeWithReserveLayout(
      lamports: BigInt.from(1500),
      transientStakeSeed: BigInt.from(15000),
    );
    expect(layout.toHex(), '15dc05000000000000983a000000000000');
    final decode = StakePoolDecreaseValidatorStakeWithReserveLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _decreaseAdditionalValidatorStake() {
  test('decreaseAdditionalValidatorStake', () {
    final layout = StakePoolDecreaseAdditionalValidatorStakeLayout(
        lamports: BigInt.from(1500),
        transientStakeSeed: BigInt.from(15000),
        ephemeralStakeSeed: BigInt.from(123));
    expect(
        layout.toHex(), '14dc05000000000000983a0000000000007b00000000000000');
    final decode = StakePoolDecreaseAdditionalValidatorStakeLayout.fromBuffer(
        layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _depositStake() {
  test('depositStake', () {
    const layout = StakePoolDepositStakeLayout();
    expect(layout.toHex(), '09');
    final decode = StakePoolDepositStakeLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _depositSol() {
  test('depositSol', () {
    final layout = StakePoolDepositSolLayout(lamports: BigInt.from(15000));
    expect(layout.toHex(), '0e983a000000000000');
    final decode = StakePoolDepositSolLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _withdrawStake() {
  test('withdrawStake', () {
    final layout = StakePoolWithdrawStakeLayout(poolTokens: BigInt.from(1500));
    expect(layout.toHex(), '0adc05000000000000');
    final decode = StakePoolWithdrawStakeLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _withdrawSol() {
  test('withdrawSol', () {
    final layout = StakePoolWithdrawSolLayout(poolTokens: BigInt.from(1500));
    expect(layout.toHex(), '10dc05000000000000');
    final decode = StakePoolWithdrawSolLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _redelegate() {
  test('redelegate', () {
    final layout = StakePoolReDelegateLayout(
      destinationTransientStakeSeed: BigInt.from(1500),
      ephemeralStakeSeed: BigInt.from(1500),
      lamports: BigInt.from(1500),
      sourceTransientStakeSeed: BigInt.from(1500),
    );
    expect(layout.toHex(),
        '16dc05000000000000dc05000000000000dc05000000000000dc05000000000000');
    final decode = StakePoolReDelegateLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _createTokenMetadata() {
  test('createTokenMetadata', () {
    final layout = StakePoolCreateTokenMetaDataLayout(
        name: 'MRTNETWORK',
        symbol: 'MRT',
        uri: 'https://github.com/mrtnetwork');
    expect(layout.toHex(),
        '110a0000004d52544e4554574f524b030000004d52541d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b');
    final decode =
        StakePoolCreateTokenMetaDataLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _updateTokenMetadata() {
  test('updateTokenMetadata', () {
    final layout = StakePoolUpdateTokenMetaDataLayout(
        name: 'MRTNETWORK',
        symbol: 'MRT',
        uri: 'https://github.com/mrtnetwork');
    expect(layout.toHex(),
        '120a0000004d52544e4554574f524b030000004d52541d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b');
    final decode =
        StakePoolUpdateTokenMetaDataLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}
