// Sui zkLogin hash oracles from fastcrypto unit tests (independent of the
// FFI backend; pure-Dart checks).
//
// - `hash_ascii_str_to_field` vectors (`zk_login_tests.rs`)
// - `poseidon_zk_login` 11-input vector (`test_all_inputs_hash`)
// - `split_to_two_frs` boundaries
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

void zkloginHashOraclesTest() {
  final Object? poseidonSkip =
      blockchainUtils.backend == null
          ? 'Poseidon needs the Rust backend (ffi/wasm).'
          : null;
  group('Sui/ZkLogin hash oracles (fastcrypto vectors)', () {
    test('hash_ascii_str_to_field', skip: poseidonSkip, () {
      expect(
        SuiZkLoginUtils.hashAsciiStrToField('test@gmail.com', 30).toString(),
        '13606676331558803166736332982602687405662978305929711411606106012181987145625',
      );
      expect(
        SuiZkLoginUtils.hashAsciiStrToField('test@gmail.com', 32).toString(),
        '10404231015713323946367565043703223078961469658905861259850380980432751872181',
      );
      expect(
        SuiZkLoginUtils.hashAsciiStrToField(
          'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjEifQ',
          248,
        ).toString(),
        '10859137172532636243875876865378218840892896099608302223608404291948352005840',
      );
    });

    test('poseidon 11-input (all_inputs_hash oracle)', skip: poseidonSkip, () {
      final out = SuiZkLoginUtils.poseidonHashFields([
        BigInt.parse('248987002057371616691124650904415756047'),
        BigInt.parse('113498781424543581252500776698433499823'),
        BigInt.parse(
          '14900420995580824499222150327925943524564997104405553289134597516335134742309',
        ),
        BigInt.parse('103'),
        BigInt.parse('564'),
        BigInt.parse('17932473587154777519561053972421347139'),
        BigInt.parse('134696963602902907403122104327765350261'),
        BigInt.parse('10000'),
        BigInt.parse('11'),
        BigInt.parse(
          '18523124550523841778801820019979000409432455608728354507022210389496924497355',
        ),
        BigInt.parse(
          '15604334753912523265015800787270404628529489918817818174033741053550755333691',
        ),
      ]);
      expect(
        out.toString(),
        '2487117669597822357956926047501254969190518860900347921480370492048882803688',
      );
    });

    test('split ephemeral key boundaries', () {
      // 33 bytes: 17 + 16.
      final key = List<int>.generate(33, (i) => i + 1);
      final (first, second) = SuiZkLoginUtils.splitEphemeralKey(key);
      expect(
        second,
        BigInt.parse('12131415161718191a1b1c1d1e1f2021', radix: 16),
      );
      expect(first.bitLength, lessThanOrEqualTo(17 * 8));
      expect(
        () => SuiZkLoginUtils.splitEphemeralKey(List<int>.filled(32, 1)),
        throwsA(isA<BuError>()),
      );
      expect(
        () => SuiZkLoginUtils.splitEphemeralKey(List<int>.filled(48, 1)),
        throwsA(isA<BuError>()),
      );
    });
  });
}

void main() {
  OnChainUtilsTestApi.runTest(zkloginHashOraclesTest, "Zklogin Hash Oracles");
}
