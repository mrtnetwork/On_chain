import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group('SPL TOKEN metadata layout', () {
    _createMetaData();
    _updateMetaData();
    _remove();
    _updateAuthority();
    _emit();
  });
}

void _createMetaData() {
  test('createMetaData', () {
    final layout = SPLTokenMetaDataInitializeLayout(
        name: 'MRT', symbol: 'MRT1', uri: 'MRT.com');
    expect(layout.toHex(),
        'd2e11ea258b84d8d030000004d5254040000004d525431070000004d52542e636f6d');
    final decode =
        SPLTokenMetaDataInitializeLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _updateMetaData() {
  test('createMetaData', () {
    final layout = SPLTokenMetaDataUpdateLayout(
        field: SPLTokenMetaDataField.name(name: 'MRT'));
    expect(layout.toHex(), 'dde9312db5cadcc800030000004d5254');
    final decode = SPLTokenMetaDataUpdateLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('createMetaData_1', () {
    final layout = SPLTokenMetaDataUpdateLayout(
        field: SPLTokenMetaDataField.symbol(symbol: 'MRTNETWORK'));
    expect(layout.toHex(), 'dde9312db5cadcc8010a0000004d52544e4554574f524b');
    final decode = SPLTokenMetaDataUpdateLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('createMetaData_2', () {
    final layout = SPLTokenMetaDataUpdateLayout(
        field: SPLTokenMetaDataField.uri(uri: 'https://github.com/mrtnetwork'));
    expect(layout.toHex(),
        'dde9312db5cadcc8021d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b');
    final decode = SPLTokenMetaDataUpdateLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('createMetaData_3', () {
    final layout = SPLTokenMetaDataUpdateLayout(
      field: SPLTokenMetaDataField.customField(
          keyName: 'website', value: 'https://github.com/mrtnetwork'),
    );
    expect(layout.toHex(),
        'dde9312db5cadcc80307000000776562736974651d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b');
    final decode = SPLTokenMetaDataUpdateLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _remove() {
  test('remove', () {
    const layout = SPLTokenMetaDataRemoveFieldLayout(
        key: 'https://github.com/mrtnetwork', idempotent: false);
    expect(layout.toHex(),
        'ea122038598d25b5001d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b');
    final decode =
        SPLTokenMetaDataRemoveFieldLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('remove_1', () {
    const layout = SPLTokenMetaDataRemoveFieldLayout(
        key: 'https://github.com/mrtnetwork', idempotent: true);
    expect(layout.toHex(),
        'ea122038598d25b5011d00000068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b');
    final decode =
        SPLTokenMetaDataRemoveFieldLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('remove_3', () {
    const layout =
        SPLTokenMetaDataRemoveFieldLayout(key: 'Name', idempotent: true);
    expect(layout.toHex(), 'ea122038598d25b501040000004e616d65');
    final decode =
        SPLTokenMetaDataRemoveFieldLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _updateAuthority() {
  test('updateAuthority', () {
    const layout = SPLTokenMetaDataUpdateAuthorityLayout();
    expect(layout.toHex(),
        'd7e4a6e45464567b0000000000000000000000000000000000000000000000000000000000000000');
    final decode =
        SPLTokenMetaDataUpdateAuthorityLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('updateAuthority_1', () {
    final newAuthority =
        SolAddress('HcEjuQ7Eate3eyNBaZV2cwATcdAH8F7VGygVqkkoqUjf');
    final layout =
        SPLTokenMetaDataUpdateAuthorityLayout(newAuthority: newAuthority);
    expect(layout.toHex(),
        'd7e4a6e45464567bf6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd76');
    final decode =
        SPLTokenMetaDataUpdateAuthorityLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

/// SPLTokenMetaDataEmitLayout(start: BigInt.one, end: BigInt.two)
void _emit() {
  test('emit', () {
    final layout =
        SPLTokenMetaDataEmitLayout(start: BigInt.one, end: BigInt.two);
    expect(
        layout.toHex(), 'faa6b4fa0d0cb846010100000000000000010200000000000000');
    final decode = SPLTokenMetaDataEmitLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('emit_1', () {
    final layout = SPLTokenMetaDataEmitLayout(start: BigInt.one);
    expect(layout.toHex(), 'faa6b4fa0d0cb84601010000000000000000');
    final decode = SPLTokenMetaDataEmitLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('emit_2', () {
    const layout = SPLTokenMetaDataEmitLayout();
    expect(layout.toHex(), 'faa6b4fa0d0cb8460000');
    final decode = SPLTokenMetaDataEmitLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('emit_3', () {
    final layout =
        SPLTokenMetaDataEmitLayout(end: BigInt.from(456456465456465));
    expect(layout.toHex(), 'faa6b4fa0d0cb8460001519d7a0d259f0100');
    final decode = SPLTokenMetaDataEmitLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
  test('emit_4', () {
    final layout =
        SPLTokenMetaDataEmitLayout(end: BigInt.from(0), start: BigInt.from(0));
    expect(
        layout.toHex(), 'faa6b4fa0d0cb846010000000000000000010000000000000000');
    final decode = SPLTokenMetaDataEmitLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}
