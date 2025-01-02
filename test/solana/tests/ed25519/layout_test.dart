import 'package:blockchain_utils/utils/utils.dart';
import 'package:test/test.dart';
import 'package:on_chain/solana/solana.dart';

void main() {
  group('ed25519', () {
    _ed25519();
  });
}

void _ed25519() {
  test('test1', () {
    final prv = SolanaPrivateKey.fromSeedHex(
        '02c9b192ea5dbba7707e922d106c87c928a8c18495a02d4f49f4406231df907b');
    final layout = Ed25519ProgramLayout.fromPrivateKey(
        privateKey: prv,
        message: BytesUtils.fromHexString(
            '05db418c120d1958518ac1735a40ce193b686862bb94a43ea3561d3b885b3439'));
    expect(layout.toHex(),
        '01003000ffff1000ffff70002000fffff6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd766bc9677abbc1853e50e0f78990c310afc9917e3151a450190f1bf92e1f71304f839c457706fde49db1a3d706b94896ae64b6d26b9ac79b8854e6a1d52eed740705db418c120d1958518ac1735a40ce193b686862bb94a43ea3561d3b885b3439');
    final decode = Ed25519ProgramLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('test2', () {
    final prv = SolanaPrivateKey.fromSeedHex(
        '02c9b192ea5dbba7707e922d106c87c928a8c18495a02d4f49f4406231df907b');
    final layout = Ed25519ProgramLayout.fromPrivateKey(
        privateKey: prv,
        message: BytesUtils.fromHexString(
            '05db418c120d1958518ac1735a40ce193b686862bb94a43ea3561d3b885b3439'),
        instructionIndex: 256);
    expect(layout.toHex(),
        '01003000000110000001700020000001f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd766bc9677abbc1853e50e0f78990c310afc9917e3151a450190f1bf92e1f71304f839c457706fde49db1a3d706b94896ae64b6d26b9ac79b8854e6a1d52eed740705db418c120d1958518ac1735a40ce193b686862bb94a43ea3561d3b885b3439');
    final decode = Ed25519ProgramLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('test3', () {
    final prv = SolanaPrivateKey.fromSeedHex(
        '02c9b192ea5dbba7707e922d106c87c928a8c18495a02d4f49f4406231df907b');
    final layout = Ed25519ProgramLayout.fromPrivateKey(
        privateKey: prv,
        message: StringUtils.encode('https://github.com/mrtnetwork/On_chain'),
        instructionIndex: 256);
    expect(layout.toHex(),
        '01003000000110000001700026000001f6c1dacc8b174b10dac187bb1ee7fed819b77e84591dc1827dc38943a5dbbd768dcbf59312a3612094d9684cce2c067cd8b3bd2915ad43c1adaa9c627b3d7c8eadd3ba5c106fffe1e50be8c4be4f2868ae46c48120c79e1ad0b2132ca326d70468747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b2f4f6e5f636861696e');
    final decode = Ed25519ProgramLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
  test('test4', () {
    final prv = SolanaPrivateKey.fromSeedHex(
        'eb5a8775f2b3ba945ce508dff6db8ca47bd70ae8c93ed545208f346e70e3f76b');
    final layout = Ed25519ProgramLayout.fromPrivateKey(
        privateKey: prv,
        message: StringUtils.encode('https://github.com/mrtnetwork/On_chain'),
        instructionIndex: 256);
    expect(layout.toHex(),
        '010030000001100000017000260000015dc3fa1774fdb547e24705fe9e4b4c1c0c69faee6d39cf2bb4b1e4b291d682ade7ec0efd5a4bd73b2358cee72982a40ce670f8a1f4d2e7d412de814fc3dbae3e90ee78782615f0575ec8f952441eb31eb51d4382a88bd57110740c0fb60af30168747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b2f4f6e5f636861696e');
    final decode = Ed25519ProgramLayout.fromBuffer(layout.toBytes());
    expect(decode.toBytes(), layout.toBytes());
  });
}
