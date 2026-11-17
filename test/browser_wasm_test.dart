@TestOn('browser')
@Tags(['wasm'])
library;

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import 'utils.dart';

void main() {
  setUpAll(() async {
    // Shared harness: injects the glue script (served by the dart-test
    // static handler from test/wasm_assets/ — copy the built assets from
    // blockchain_utils/test/wasm_assets/), waits for bootstrap, then
    // selects the Rust backend. No .so involved.
    // Optional overrides: BU_WASM_GLUE_URL / BU_WASM_MODULE_URL are VM-only;
    // on web pass an explicit config:
    //   await OnChainUtilsTestApi.initWasmBrowser(const BuTestConfig(
    //     backend: BuTestBackend.wasm,
    //     wasmGlueUrl: 'https://host/bu.js',
    //     wasmModuleUrl: 'https://host/bu_bg.wasm',
    //   ));
    await OnChainUtilsTestApi.initWasmBrowser();
  });

  group('wasm backend smoke (on_chain)', () {
    test('sha256 empty (shared backend)', () {
      expect(
        BytesUtils.toHexString(QuickCrypto.sha256Hash([])),
        'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855',
      );
    });
    test('tron address from pubkey', () {
      final pubkey = BytesUtils.fromHexString(
        '0279be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798',
      );
      final addr = TronAddress.fromPublicKey(pubkey);
      expect(addr.address.startsWith('T'), isTrue);
    });
  });
}
