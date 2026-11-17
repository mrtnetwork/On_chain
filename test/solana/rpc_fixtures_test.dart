// Offline replay of captured mainnet responses
// (`test/solana/test_vectors/live/`). No network: runs in seconds.
//
// This is the "parsing never breaks" guard: every fixture is decoded with
// the same model the provider request's onResponse uses, re-encoded where
// the model has toJson, and key-diffed so silently-dropped fields fail.
//
// Recapture: `python3 /workspaces/cosmos_sdk/work/.tmp/capture_solana_fixtures.py`
@TestOn('vm')
library;

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

Map<String, dynamic> _fixtureMap(String name) {
  final file = File('test/solana/test_vectors/live/$name.json');
  return StringUtils.toJson<Map<String, dynamic>>(file.readAsStringSync());
}

List _fixtureList(String name) {
  final file = File('test/solana/test_vectors/live/$name.json');
  return StringUtils.toJson<List<dynamic>>(file.readAsStringSync());
}

/// Unwraps a saved raw result ({context, value} like the provider does).
List _unwrapList(String name) {
  final file = File('test/solana/test_vectors/live/$name.json');
  final decoded = StringUtils.toJson(file.readAsStringSync());
  if (decoded is Map &&
      decoded.containsKey('context') &&
      decoded.containsKey('value')) {
    return decoded['value'] as List;
  }
  return decoded as List;
}

dynamic _fixtureValue(String name) {
  final file = File('test/solana/test_vectors/live/$name.json');
  return StringUtils.toJson(file.readAsStringSync());
}

void _diffKeys(Object? raw, Object? out, String path, List<String> missing) {
  if (raw is Map && out is Map) {
    for (final k in raw.keys) {
      final p = path.isEmpty ? '$k' : '$path.$k';
      if (!out.containsKey(k)) {
        missing.add(p);
      } else {
        _diffKeys(raw[k], out[k], p, missing);
      }
    }
  } else if (raw is List && out is List) {
    for (int i = 0; i < raw.length && i < out.length; i++) {
      _diffKeys(raw[i], out[i], '$path[$i]', missing);
    }
    if (raw.length != out.length) {
      missing.add('$path (length raw=${raw.length} out=${out.length})');
    }
  }
}

void rpcFixturesTest() {
  group('Solana/RPC Fixtures', () {
    group('Solana/RPC Fixtures (Offline)', () {
      test('node: version / identity / snapshot slot round-trip', () {
        void check<T>(
          String name,
          T Function(Map<String, dynamic>) parse,
          Map<String, dynamic> Function(T) serialize,
        ) {
          final raw = _fixtureMap(name);
          final parsed = parse(raw);
          final out = serialize(parsed);
          final missing = <String>[];
          _diffKeys(raw, out, '', missing);
          expect(missing, isEmpty, reason: '$name: $missing');
          parse(out);
        }

        check('version', SolanaVersionResponse.fromJson, (e) => e.toJson());
        check('identity', SolanaIdentityResponse.fromJson, (e) => e.toJson());
        check(
          'highest_snapshot_slot',
          HighestSnapshotSlotResponse.fromJson,
          (e) => e.toJson(),
        );
      });

      test('node: primitives decode', () {
        expect(_fixtureValue('slot'), isA<int>());
        expect(_fixtureValue('block_height'), isA<int>());
        expect(_fixtureValue('transaction_count'), isA<int>());
        expect(_fixtureValue('genesis_hash'), isA<String>());
        expect(_fixtureValue('first_available_block'), isA<int>());
        expect(_fixtureValue('max_retransmit_slot'), isA<int>());
        expect(_fixtureValue('max_shred_insert_slot'), isA<int>());
        expect(_fixtureValue('minimum_ledger_slot'), isA<int>());
        expect(_fixtureValue('slot_leader'), isA<String>());
        expect(_fixtureValue('health'), 'ok');
        expect(_fixtureValue('rent_exemption_50'), isA<int>());
        expect(_fixtureValue('stake_minimum_delegation'), isA<int>());
        expect(_fixtureValue('balance_system'), isA<int>());
        expect(_fixtureValue('is_blockhash_valid'), isA<bool>());
      });

      test('blockhash / supply / inflation / epoch parse', () {
        BlockhashWithExpiryBlockHeight.fromJson(
          _fixtureMap('latest_blockhash'),
        );
        SupplyResponse.fromJson(_fixtureMap('supply'));
        InflationGovernor.fromJson(_fixtureMap('inflation_governor'));
        InflationRate.fromJson(_fixtureMap('inflation_rate'));
        EpochInfo.fromJson(_fixtureMap('epoch_info'));
        EpochSchedule.fromJson(_fixtureMap('epoch_schedule'));
      });

      test('accounts round-trip', () {
        for (final name in ['account_info_system', 'account_info_usdc_mint']) {
          final raw = _fixtureMap(name);
          final parsed = SolanaAccountInfo.fromJson(raw);
          final out = parsed.toJson();
          final missing = <String>[];
          _diffKeys(raw, out, '', missing);
          expect(missing, isEmpty, reason: '$name: $missing');
          SolanaAccountInfo.fromJson(out);
        }
        final multi = _fixtureList('multiple_accounts');
        expect(multi.length, 2);
        for (final e in multi) {
          SolanaAccountInfo.fromJson((e as Map).cast<String, dynamic>());
        }
      });

      test('tokens parse', () {
        TokenAmoutResponse.fromJson(_fixtureMap('token_supply'));
      });

      test('signatures round-trip', () {
        final sigs = _fixtureList('signatures');
        expect(sigs, isNotEmpty);
        for (final e in sigs) {
          final raw = (e as Map).cast<String, dynamic>();
          final parsed = ConfirmedSignatureInfo.fromJson(raw);
          final out = parsed.toJson();
          final missing = <String>[];
          _diffKeys(raw, out, '', missing);
          expect(missing, isEmpty, reason: 'signatures: $missing');
          ConfirmedSignatureInfo.fromJson(out);
        }
        for (final e in _unwrapList('signature_statuses')) {
          if (e == null) continue;
          SignatureStatus.fromJson((e as Map).cast<String, dynamic>());
        }
      });

      test('transactions parse (jsonParsed + json)', () {
        for (final name in ['tx_jsonparsed', 'tx_json']) {
          final raw = _fixtureMap(name);
          final parsed = VersionedTransactionResponse.fromJson(raw);
          expect(parsed.transaction, isNotNull);
          expect(parsed.meta, isNotNull);
        }
        // Parsed-shape content must survive, not just not-crash.
        final parsedTx = VersionedTransactionResponse.fromJson(
          _fixtureMap('tx_jsonparsed'),
        );
        final withParsed =
            parsedTx.transaction?.message.compiledInstructions
                .where((e) => e.parsed != null)
                .toList() ??
            [];
        expect(withParsed, isNotEmpty);
        final innerParsed =
            parsedTx.meta?.innerInstructions
                ?.expand((e) => e.parsedInstructions)
                .toList() ??
            [];
        expect(innerParsed, isNotEmpty);
        for (final p in innerParsed) {
          expect(p.programId.address, isNotEmpty);
        }
      });
    });
  }, skip: !native ? 'filesystem fixtures unavailable' : null);
}

void main() {
  OnChainUtilsTestApi.runTest(rpcFixturesTest, "Rpc Fixtures");
}
