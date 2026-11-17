// Offline replay of captured Sui mainnet responses
// (`test/sui/test_vectors/live/`). No network, no key: runs in seconds.
//
// Endpoint: public JSON-RPC (Mysten deprecated JSON-RPC on their own nodes;
// the protocol still serves elsewhere). Fixtures chained off a real
// checkpoint tx: zero hardcoded addresses (see owner.txt/tx_digest.txt).
//
// Recapture: `python3 /workspaces/cosmos_sdk/work/.tmp/capture_sui_fixtures.py`
@TestOn('vm')
library;

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

dynamic _fixture(String name) {
  final file = File('test/sui/test_vectors/live/$name.json');
  return StringUtils.toJson(file.readAsStringSync());
}

Map<String, dynamic> _map(String name) =>
    (_fixture(name) as Map).cast<String, dynamic>();

void _roundTrip<T>(
  String label,
  Map<String, dynamic> raw,
  T Function(Map<String, dynamic>) parse,
  Map<String, dynamic> Function(T) serialize,
) {
  final parsed = parse(raw);
  final out = serialize(parsed);
  final missing = raw.keys.where((k) => !out.containsKey(k)).toList();
  expect(missing, isEmpty, reason: '$label dropped: $missing');
  parse(out);
}

void suiFixturesTest() {
  group('Sui/Fixtures (needs dart:io)', () {
    group('Sui/Rpc fixtures (offline)', () {
      test('node primitives decode', () {
        expect(_fixture('chain_identifier'), '35834a8a');
        expect(
          BigInt.parse(_fixture('checkpoint_sequence') as String),
          greaterThan(BigInt.zero),
        );
        expect(
          BigInt.parse(_fixture('total_transactions') as String),
          greaterThan(BigInt.zero),
        );
        expect(_fixture('gas_price'), isA<String>());
        final head = _map('checkpoint_head');
        expect(head['sequenceNumber'], isA<String>());
      });

      test('committee round-trip', () {
        _roundTrip(
          'committee',
          _map('committee'),
          SuiApiCommitteeInfo.fromJson,
          (e) => e.toJson(),
        );
      });

      test('system state round-trip', () {
        _roundTrip(
          'system_state',
          _map('system_state'),
          SuiApiSystemStateSummary.fromJson,
          (e) => e.toJson(),
        );
      });

      test('protocol config round-trip', () {
        _roundTrip(
          'protocol_config',
          _map('protocol_config'),
          SuiApiProtocolConfig.fromJson,
          (e) => e.toJson(),
        );
      });

      test('transaction block round-trip', () {
        final raw = _map('tx');
        final parsed = SuiApiTransactionBlockResponse.fromJson(raw);
        expect(parsed.digest, isNotEmpty);
        final out = parsed.toJson();
        final missing = raw.keys.where((k) => !out.containsKey(k)).toList();
        expect(missing, isEmpty, reason: 'tx dropped: $missing');
        SuiApiTransactionBlockResponse.fromJson(out);
        // Effects + events + balance changes must survive, not just parse.
        expect(parsed.effects, isNotNull);
      });

      test('checkpoint round-trip', () {
        _roundTrip(
          'checkpoint',
          _map('checkpoint'),
          SuiApiCheckPoint.fromJson,
          (e) => e.toJson(),
        );
      });

      test('objects round-trip', () {
        _roundTrip(
          'object',
          _map('object'),
          SuiApiObjectResponse.fromJson,
          (e) => e.toJson(),
        );
        for (final e in (_fixture('multi_objects') as List)) {
          final raw = (e as Map).cast<String, dynamic>();
          _roundTrip(
            'multi_objects',
            raw,
            SuiApiObjectResponse.fromJson,
            (e) => e.toJson(),
          );
        }
        _roundTrip(
          'owned_objects',
          _map('owned_objects'),
          SuiApiPaginatedObjectResponse.fromJson,
          (e) => e.toJson(),
        );
        _roundTrip(
          'dynamic_fields',
          _map('dynamic_fields'),
          SuiApiGetDynamicFieldsResponse.fromJson,
          (e) => e.toJson(),
        );
      });

      test('coins round-trip', () {
        _roundTrip(
          'balance',
          _map('balance'),
          SuiApiBalanceResponse.fromJson,
          (e) => e.toJson(),
        );
        for (final e in (_fixture('all_balances') as List)) {
          final raw = (e as Map).cast<String, dynamic>();
          _roundTrip(
            'all_balances',
            raw,
            SuiApiBalanceResponse.fromJson,
            (e) => e.toJson(),
          );
        }
        _roundTrip(
          'coins',
          _map('coins'),
          SuiApiGetCoinResponse.fromJson,
          (e) => e.toJson(),
        );
        final meta = _map('coin_metadata_sui');
        final parsed = SuiApiCoinMetadataResponse.fromJson(meta);
        expect(parsed.decimals, 9);
      });

      test('stakes parse', () {
        final stakes = _fixture('stakes') as List;
        for (final e in stakes) {
          SuiApiDelegatedStake.fromJson((e as Map).cast<String, dynamic>());
        }
      });

      test('events round-trip', () {
        _roundTrip(
          'tx_events',
          _map('tx_events'),
          SuiApiQueryEventsRepose.fromJson,
          (e) => e.toJson(),
        );
      });
    });
  }, skip: !native ? 'filesystem fixtures unavailable' : null);
}

void main() {
  OnChainUtilsTestApi.runTest(suiFixturesTest, "Sui Fixtures");
}
