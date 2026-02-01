import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group('AddressLookupTableProgram layout', () {
    _createLookupTable();
    _freezeLookupTable();
    _extendLookupTable();
    _deactivateLookupTable();
    _closeLookupTable();
  });
}

void _createLookupTable() {
  test('createLookupTable', () {
    final owner = SolAddress('HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf');
    final tableAddress =
        AddressLookupTableProgramUtils.findAddressLookupTableProgram(
            authority: owner, recentSlot: BigInt.from(277769241));
    final layout = AddressLookupCreateLookupTableLayout(
        bumpSeed: tableAddress.bump, recentSlot: BigInt.from(277769241));
    expect(layout.toHex(), '00000000196c8e1000000000fe');
    final decode =
        AddressLookupCreateLookupTableLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _freezeLookupTable() {
  test('freezeLookupTable', () {
    const layout = AddressLookupFreezeLookupTableLayout();
    expect(layout.toHex(), '01000000');
    final decode =
        AddressLookupFreezeLookupTableLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _extendLookupTable() {
  test('extendLookupTable', () {
    final account1 = SolAddress('HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf');
    final account2 = SolAddress('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');

    final layout =
        AddressExtendLookupTableLayout(addresses: [account1, account2]);
    expect(layout.toHex(),
        '020000000200000000000000f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd763d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d');
    final decode = AddressExtendLookupTableLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _deactivateLookupTable() {
  test('deactivateLookupTable', () {
    const layout = AddressLookupDeactiveLookupTableLayout();
    expect(layout.toHex(), '03000000');
    final decode =
        AddressLookupDeactiveLookupTableLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}

void _closeLookupTable() {
  test('closeLookupTable', () {
    const layout = AddressLookupCloseLookupTableLayout();
    expect(layout.toHex(), '04000000');
    final decode =
        AddressLookupCloseLookupTableLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}
