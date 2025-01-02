import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group('name service layout', () {
    _create();
    _update();
    _transfer();
    _delete();
    _realloc();
  });
}

void _create() {
  test('create', () {
    final layout = NameServiceCreateLayout(
        hashedName: List<int>.filled(32, 0),
        lamports: BigInt.from(100000000),
        space: 350);
    expect(layout.toHex(),
        '0020000000000000000000000000000000000000000000000000000000000000000000000000e1f505000000005e010000');

    final decode = NameServiceCreateLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _update() {
  test('update', () {
    final layout = NameServiceUpdateLayout(
        inputData: List<int>.filled(32, 0), offset: 2000);
    expect(layout.toHex(),
        '01d0070000200000000000000000000000000000000000000000000000000000000000000000000000');
    final decode = NameServiceUpdateLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _transfer() {
  test('transfer', () {
    final account = SolAddress('57BYVwU1nZvkDkQZvqnNL71SE4jvegfGoEr6Eo6QgNyJ');
    final layout = NameServiceTransferLayout(newOwnerKey: account);
    expect(layout.toHex(),
        '023d0427568db5811754651851ae1b5823d52b700fc835078241871ab2b0ca505d');
    final decode = NameServiceTransferLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _delete() {
  test('delete', () {
    const layout = NameServiceDeleteLayout();
    expect(layout.toHex(), '03');
    final decode = NameServiceDeleteLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}

void _realloc() {
  test('realloc', () {
    const layout = NameServiceReallocLayout(space: 500);
    expect(layout.toHex(), '04f4010000');
    final decode = NameServiceReallocLayout.fromBuffer(layout.toBytes());
    expect(layout.toBytes(), decode.toBytes());
  });
}
