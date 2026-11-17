// Offline replay of Blockfrost OpenAPI spec-driven fixtures
// (`test/ada/test_vectors/spec/`). No network, no API key: runs in seconds.
//
// Fixtures are generated from the vendor spec's schemas (see
// `.tmp/capture note` in test/ada/blockfrost_spec_gen.dart); values were
// adjusted to realistic ones where models coerce types. This guards that
// every spec-required field parses and round-trips through our models.
@TestOn('vm')
library;

import 'dart:io';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:on_chain/on_chain.dart';
import 'package:test/test.dart';

import '../utils.dart';

dynamic _fixture(String name) {
  final file = File('test/ada/test_vectors/spec/$name.json');
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

void blockfrostFixturesTest() {
  group('ADA/Blockfrost Fixtures', () {
    group('ADA/Blockfrost Fixtures (Offline)', () {
      test('address summary round-trip', () {
        _roundTrip(
          'address',
          _map('address'),
          ADAAddressSummaryResponse.fromJson,
          (e) => e.toJson(),
        );
      });
      test('address utxo round-trip', () {
        final raw = _fixture('address_utxo');
        final list = (raw as List).cast<Map<String, dynamic>>();
        expect(list, isNotEmpty);
        for (final e in list) {
          _roundTrip(
            'address_utxo',
            e,
            ADAAccountUTXOResponse.fromJson,
            (e) => e.toJson(),
          );
        }
      });
      test('stake account round-trip', () {
        _roundTrip(
          'stake_account',
          _map('stake_account'),
          ADAStakeAccountResponse.fromJson,
          (e) => e.toJson(),
        );
      });
      test('transaction round-trip', () {
        _roundTrip(
          'tx',
          _map('tx'),
          ADATransactionInfoResponse.fromJson,
          (e) => e.toJson(),
        );
      });
      test('transaction utxos round-trip', () {
        _roundTrip(
          'tx_utxos',
          _map('tx_utxos'),
          ADATransactionUTXOSResponse.fromJson,
          (e) => e.toJson(),
        );
      });
      test('block round-trip', () {
        _roundTrip(
          'block',
          _map('block'),
          ADABlockResponse.fromJson,
          (e) => e.toJson(),
        );
      });
      test('address transactions round-trip', () {
        final raw = _fixture('address_transactions');
        final list = (raw as List).cast<Map<String, dynamic>>();
        expect(list, isNotEmpty);
        for (final e in list) {
          _roundTrip(
            'address_transactions',
            e,
            ADATransactionSummaryInfoResponse.fromJson,
            (e) => e.toJson(),
          );
        }
      });
      test('epoch params round-trip', () {
        _roundTrip(
          'epoch_params',
          _map('epoch_params'),
          ADAEpochParametersResponse.fromJson,
          (e) => e.toJson(),
        );
      });
      test('asset round-trip', () {
        _roundTrip(
          'asset',
          _map('asset'),
          ADAAssetResponse.fromJson,
          (e) => e.toJson(),
        );
      });
      test('tx cbor shape (raw string passthrough)', () {
        // `/txs/{hash}/cbor` is served raw by BlockfrostRequestTransactionCbor
        // (onResponse returns result["cbor"]); assert the vendor shape.
        final raw = _map('tx_cbor');
        expect(raw['cbor'], isA<String>());
      });
      test('root response round-trip', () {
        _roundTrip(
          'root',
          {'url': 'https://blockfrost.io/', 'version': '0.1.0'},
          ADARootResponse.fromJson,
          (e) => e.toJson(),
        );
      });
    });
  }, skip: !native ? 'filesystem fixtures unavailable' : null);
}

void main() {
  OnChainUtilsTestApi.runTest(blockfrostFixturesTest, "Blockfrost Fixtures");
}
