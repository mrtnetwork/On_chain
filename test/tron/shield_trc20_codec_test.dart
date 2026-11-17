// ShieldTRC20Codec fragment regression test.
//
// The canonical ABI fragments (parsed via `AbiFunctionFragment.fromJson`
// from `ShieldTRC20Codec.shieldedTRC20Abi`) must reproduce the
// Nile-verified selectors and shapes. Byte-equality against the previous
// hand-rolled encoders was proven before the refactor; these assertions
// pin the fragment behavior going forward.

import 'dart:math';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/tron/src/shield/src/shield_trc20.dart';
import 'package:test/test.dart';

import '../utils.dart';

List<int> _word(Random rng) => List<int>.generate(32, (_) => rng.nextInt(256));
List<List<int>> _words(Random rng, int n) =>
    List<List<int>>.generate(n, (_) => _word(rng));

void shieldTrc20CodecTest() {
  group('Tron/ShieldTRC20Codec', () {
    test('fragment selectors match the Nile-verified constants', () {
      expect(
        BytesUtils.toHexString(ShieldTRC20Codec.mintFn.selector),
        ShieldTRC20Codec.mintSelector,
      );
      expect(
        BytesUtils.toHexString(ShieldTRC20Codec.transferFn.selector),
        ShieldTRC20Codec.transferSelector,
      );
      expect(
        BytesUtils.toHexString(ShieldTRC20Codec.burnFn.selector),
        ShieldTRC20Codec.burnSelector,
      );
      expect(
        BytesUtils.toHexString(ShieldTRC20Codec.getPathFn.selector),
        ShieldTRC20Codec.getPathSelector,
      );
    });

    test('transfer encoding shape (heads + sections)', () {
      final rng = Random(0x5eed);
      final body = ShieldTRC20Codec.encodeTransfer(
        inputs: List.generate(2, (_) => _words(rng, 10)),
        sigs: List.generate(2, (_) => _words(rng, 2)),
        outputs: List.generate(2, (_) => _words(rng, 9)),
        bindingSig: _words(rng, 2),
        cs: List.generate(2, (_) => _words(rng, 21)),
      );
      // 6 heads + (1+2*10) + (1+2*2) + (1+2*9) + (1+2*21) words.
      expect(body.length, (6 + 21 + 5 + 19 + 43) * 32);
    });

    test('burn encoding shape (static head + dynamic tails)', () {
      final rng = Random(0x5eed);
      final body = ShieldTRC20Codec.encodeBurn(
        input: _words(rng, 10),
        sig: _words(rng, 2),
        rawValue: BigInt.from(1000000),
        bindingSig: _words(rng, 2),
        payTo20: List<int>.generate(20, (_) => rng.nextInt(256)),
        burnCipher: _words(rng, 3),
        outputs: List.generate(1, (_) => _words(rng, 9)),
        cs: List.generate(1, (_) => _words(rng, 21)),
      );
      // 21 static words + (1+9) + (1+21) tail words.
      expect(body.length, (21 + 10 + 22) * 32);
    });

    test('mint encoding shape', () {
      final rng = Random(0x5eed);
      final body = ShieldTRC20Codec.encodeMint(
        rawValue: BigInt.from(1000000),
        output: _words(rng, 9),
        bindingSig: _words(rng, 2),
        c: _words(rng, 21),
      );
      expect(body.length, (1 + 9 + 2 + 21) * 32);
    });

    test('getPath/leafCount encode/decode round-trip', () {
      final call = ShieldTRC20Codec.encodeGetPath(BigInt.from(7));
      expect(call.length, 4 + 32);
      expect(
        BytesUtils.toHexString(call.sublist(0, 4)),
        ShieldTRC20Codec.getPathSelector,
      );
      expect(call.sublist(4).last, 7);
      final rng = Random(0x5eed);
      final rootWord = _word(rng);
      final pathWords = List.generate(32, (_) => _word(rng));
      final decoded = ShieldTRC20Codec.decodeGetPath([
        ...rootWord,
        ...pathWords.expand((w) => w),
      ]);
      expect(decoded.root, orderedEquals(rootWord));
      expect(decoded.path, hasLength(32));
      for (int i = 0; i < 32; i++) {
        expect(decoded.path[i], orderedEquals(pathWords[i]));
      }
      // Short output must throw, not misparse.
      expect(
        () => ShieldTRC20Codec.decodeGetPath(List<int>.filled(32 * 32, 0)),
        throwsA(isA<Exception>()),
      );
      expect(ShieldTRC20Codec.encodeLeafCount().length, 4);
      expect(
        ShieldTRC20Codec.decodeLeafCount([...List<int>.filled(31, 0), 42]),
        BigInt.from(42),
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(shieldTrc20CodecTest, 'ShieldTRC20Codec');
}
