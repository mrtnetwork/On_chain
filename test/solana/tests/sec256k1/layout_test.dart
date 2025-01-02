import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/ethereum/ethereum.dart';
import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group('secp256k1', () {
    _test();
  });
}

void _test() {
  test('test1', () {
    final privateKey = ETHPrivateKey(
        'cd23c9f2e2c096ee3be3c4e0e58199800c0036ea27b7cd4e838bbde8b21788b3');

    final message =
        StringUtils.encode('https://github.com/mrtnetwork/On_chain');
    final layout = Secp256k1Layout.fromPrivateKey(
        privateKey: privateKey, message: message, instructionIndex: 2);
    expect(layout.toHex(),
        '012000020c00026100260002f22b6859efbda2fb9ef2f84cab396bfb5990f6d80a0cbd544882db6d0a06b0db1b1b73cc040bf420e6e07a25acb19e61a82c44a56c62e164ba0816b6bbb30d85f6ae63c9e022a84de620ed13b2239c105c98ed2a0168747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b2f4f6e5f636861696e');
    final decode = Secp256k1Layout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('test2', () {
    final privateKey = ETHPrivateKey(
        'cd23c9f2e2c096ee3be3c4e0e58199800c0036ea27b7cd4e838bbde8b21788b3');

    final message =
        StringUtils.encode('https://github.com/mrtnetwork/On_chain');
    final layout = Secp256k1Layout.fromPrivateKey(
        privateKey: privateKey, message: message, instructionIndex: 89);
    expect(layout.toHex(),
        '012000590c00596100260059f22b6859efbda2fb9ef2f84cab396bfb5990f6d80a0cbd544882db6d0a06b0db1b1b73cc040bf420e6e07a25acb19e61a82c44a56c62e164ba0816b6bbb30d85f6ae63c9e022a84de620ed13b2239c105c98ed2a0168747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b2f4f6e5f636861696e');
    final decode = Secp256k1Layout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('test3', () {
    final privateKey = ETHPrivateKey(
        '91e4ad47a567b23aec1157e280c00b3170125c4de7169ae63021aed37924931a');

    final message =
        StringUtils.encode('https://github.com/mrtnetwork/On_chain');
    final layout = Secp256k1Layout.fromPrivateKey(
        privateKey: privateKey, message: message, instructionIndex: 89);
    expect(layout.toHex(),
        '012000590c005961002600596ececa63588925176ce147dc72d8f433d829bfb745ac1a2fffd82ee1b3cb426626e5dfd720d359f5b41c32edf6b5b126459d1cab568a4fd4600d6968b2028f20bbe9cf2163aca862fd38ccb24681cf73ce51ab460168747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b2f4f6e5f636861696e');
    final decode = Secp256k1Layout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('test4', () {
    final privateKey = ETHPrivateKey(
        '91e4ad47a567b23aec1157e280c00b3170125c4de7169ae63021aed37924931a');

    final message = BytesUtils.fromHexString(
        'eb5a8775f2b3ba945ce508dff6db8ca47bd70ae8c93ed545208f346e70e3f76b');
    final layout = Secp256k1Layout.fromPrivateKey(
        privateKey: privateKey, message: message, instructionIndex: 89);
    expect(layout.toHex(),
        '012000590c005961002000596ececa63588925176ce147dc72d8f433d829bfb71ab5b84f4412f389cb4cfbdca864e3c8040c87c7069fc7aa5cd8362b54de9d58293b5e622ae05cb19e8be4b8b666df6f076b2e7df6cc1d89f02afa69b3be0be400eb5a8775f2b3ba945ce508dff6db8ca47bd70ae8c93ed545208f346e70e3f76b');
    final decode = Secp256k1Layout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}
