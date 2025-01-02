import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group('stake program layout', () {
    _initialize();
    _delegate();
    _authorize();
    _authorizeWithSeed();
    _split();
    _merge();
    _withdraw();
    _deactivate();
    _stakeAccount();
  });
}

void _initialize() {
  test('initialize', () {
    final account1 = SolAddress('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');
    final account3 = SolAddress('6jwLNd4w4RfZsj5WCszKB4wKHmU2gX24JLq2DH42No5s');
    final layout = StakeInitializeLayout(
        authorized: StakeAuthorized(staker: account1, withdrawer: account3));
    expect(layout.toHex(),
        '000000003d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000');

    final decode = StakeInitializeLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _delegate() {
  test('delegate', () {
    const layout = StakeDelegateLayout();
    expect(layout.toHex(), '02000000');
    final decode = StakeDelegateLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _authorize() {
  test('authorize', () {
    final account = SolAddress('6jwLNd4w4RfZsj5WCszKB4wKHmU2gX24JLq2DH42No5s');
    final layout =
        StakeAuthorizeLayout(newAuthorized: account, stakeAuthorizationType: 1);
    expect(layout.toHex(),
        '01000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca01000000');
    final decode = StakeAuthorizeLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _authorizeWithSeed() {
  test('authoritySeed', () {
    final account = SolAddress('HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf');
    final account3 = SolAddress('6jwLNd4w4RfZsj5WCszKB4wKHmU2gX24JLq2DH42No5s');
    final layout = StakeAuthorizeWithSeedLayout(
        newAuthorized: account3,
        stakeAuthorizationType: 1,
        authoritySeed: 'account1',
        authorityOwner: account);
    expect(layout.toHex(),
        '08000000554a43a7b8e1a60dac1b800be310f94e55f8fb7415780b78177c3ede1aa0b7ca0100000008000000000000006163636f756e7431f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76');
    final decode = StakeAuthorizeWithSeedLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _split() {
  test('split', () {
    final layout = StakeSplitLayout(lamports: BigInt.from(100000000));
    expect(layout.toHex(), '0300000000e1f50500000000');
    final decode = StakeSplitLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _merge() {
  test('merge', () {
    const layout = StakeMergeLayout();
    expect(layout.toHex(), '07000000');
    final decode = StakeMergeLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _withdraw() {
  test('withdraw', () {
    final layout = StakeWithdrawLayout(lamports: BigInt.from(1000000));
    expect(layout.toHex(), '0400000040420f0000000000');
    final decode = StakeWithdrawLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _deactivate() {
  test('deactivate', () {
    const layout = StakeDeactivateLayout();
    expect(layout.toHex(), '05000000');
    final decode = StakeDeactivateLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _stakeAccount() {
  test('stake account', () {
    const String data =
        '0200000080d5220000000000e03d7ac0e2379e10e044d66eaf54a03ec7c8a3b3aa3647b7789bf1cdeec29a5ce03d7ac0e2379e10e044d66eaf54a03ec7c8a3b3aa3647b7789bf1cdeec29a5c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000efd5afd1efdeb7c6f13444faaf30e996ec9f602db349494dd5565f62614dc388e88fee86210000008802000000000000ffffffffffffffff000000000000d03fe17b0a000000000000000000';
    final dataBytes = BytesUtils.fromHexString(data);

    final decode = StakeAccount.fromBuffer(dataBytes);
    expect(decode.toBytes(), dataBytes.sublist(0, 197));
  });
}
